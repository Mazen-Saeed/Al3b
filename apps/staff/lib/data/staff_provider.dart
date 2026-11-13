import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'activity_log.dart';
import 'ids.dart';
import 'input_rules.dart';
import 'pin_attempts.dart';
import 'pin_hasher.dart';
import 'sample_data.dart';
import 'staff_member.dart';

/// The people who work at this shop when the app starts. Tests replace it; the real app fills it from the database.
final initialStaffProvider = Provider<List<StaffMember>>((ref) => buildSampleStaff());

/// The people who work at this shop now. Starts as [initialStaffProvider]; the setup (and later the staff page) changes it.
class StaffNotifier extends Notifier<List<StaffMember>> {
  @override
  List<StaffMember> build() => ref.read(initialStaffProvider);

  /// Replaces the whole list. Used once, by the first-run setup.
  void setAll(List<StaffMember> staff) => state = staff;

  StaffMember? get _actor {
    final id = ref.read(currentStaffIdProvider);
    for (final s in state) {
      if (s.id == id) return s;
    }
    return null;
  }

  /// Whether another visible person already has [name] (other than [exceptId]).
  bool nameTaken(String name, {String? exceptId}) {
    final wanted = name.trim();
    return state.any((s) => s.active && s.id != exceptId && s.name == wanted);
  }

  /// Who may change whom (decisions #36, #63): the owner may change anyone; an Admin may change plain Staff;
  /// everyone may change themselves. Nobody but the owner can touch the owner, and a stopped person is gone.
  bool canManage(StaffMember target) {
    final actor = _actor;
    if (actor == null || !actor.isAdmin || !target.active) return false;
    if (actor.id == target.id) return true;
    if (actor.isOwner) return true;
    return !target.isAdmin;
  }

  /// Adds a person. Returns null when not allowed or invalid: only an Admin adds people, only the owner adds
  /// an Admin, an Admin needs an Egyptian mobile number (they sign in with it, #67), the name must be free and
  /// the PIN 4 digits.
  StaffMember? add({
    required String name,
    required String pin,
    String? phone,
    bool isAdmin = false,
    PinHasher hasher = const PinHasher(),
  }) {
    final actor = _actor;
    final clean = name.trim();
    if (actor == null || !actor.isAdmin || (isAdmin && !actor.isOwner)) return null;
    if (clean.isEmpty || nameTaken(clean) || !isValidPin(pin)) return null;
    if (isAdmin && !isEgyptianMobile(phone ?? '')) return null;
    final person = StaffMember(id: newId(), name: clean, phone: phone, pinHash: hasher.hash(pin), isAdmin: isAdmin);
    state = [...state, person];
    ref.read(activityLogProvider.notifier).record(ActivityKind.staffAdded, details: {'name': clean, 'admin': isAdmin});
    return person;
  }

  /// Renames, changes the phone or the role. Only the owner changes a role. Returns false when not allowed.
  bool update(String id, {String? name, String? phone, bool? isAdmin}) {
    final target = state.where((s) => s.id == id).firstOrNull;
    if (target == null || !canManage(target)) return false;
    final clean = name?.trim();
    if (clean != null && (clean.isEmpty || nameTaken(clean, exceptId: id))) return false;
    if (isAdmin != null && isAdmin != target.isAdmin && (!_actor!.isOwner || target.isOwner)) return false;
    final becomesAdmin = isAdmin ?? target.isAdmin;
    final newPhone = phone ?? target.phone;
    if (becomesAdmin && !isEgyptianMobile(newPhone ?? '')) return false;
    state = [for (final s in state) s.id == id ? s.copyWith(name: clean, phone: phone, isAdmin: isAdmin) : s];
    if (isAdmin != null && isAdmin != target.isAdmin) {
      ref.read(activityLogProvider.notifier).record(ActivityKind.staffRoleChanged, details: {'name': clean ?? target.name, 'admin': isAdmin});
    }
    return true;
  }

  /// Sets a new PIN (a forgotten one, #54) and lifts any lockout. Returns false when not allowed.
  bool resetPin(String id, String pin, {PinHasher hasher = const PinHasher()}) {
    final target = state.where((s) => s.id == id).firstOrNull;
    if (target == null || !canManage(target) || !isValidPin(pin)) return false;
    state = [for (final s in state) s.id == id ? s.copyWith(pinHash: hasher.hash(pin)) : s];
    ref.read(currentStaffIdProvider.notifier).clearLockout(id);
    ref.read(activityLogProvider.notifier).record(ActivityKind.staffPinReset, details: {'name': target.name});
    return true;
  }

  /// Stops a person: they cannot sign in any more, but old bills and cash records keep their name.
  /// Nobody can stop the owner or themselves. Returns false when not allowed.
  bool deactivate(String id) {
    final target = state.where((s) => s.id == id).firstOrNull;
    if (target == null || target.isOwner || target.id == _actor?.id || !canManage(target)) return false;
    state = [for (final s in state) s.id == id ? s.copyWith(active: false) : s];
    ref.read(activityLogProvider.notifier).record(ActivityKind.staffStopped, details: {'name': target.name});
    return true;
  }
}

final staffProvider = NotifierProvider<StaffNotifier, List<StaffMember>>(StaffNotifier.new);

/// Who is working right now: the id of the person who typed their PIN, or null while locked.
/// Tests start signed in by overriding this.
final initialSignedInProvider = Provider<String?>((ref) => null);

/// What time it is. Tests replace it to move the clock without waiting.
final nowProvider = Provider<DateTime Function()>((ref) => DateTime.now);

/// The lockout rule. A 4-digit PIN has only 10,000 possibilities, so what stops guessing is making
/// each wrong try expensive: after [freeTries] wrong PINs in a row for one person, that person's PIN
/// is refused for [firstLockout], and every further wrong try doubles the wait, up to [longestLockout].
/// A right PIN starts the count again.
const freeTries = 5;
const firstLockout = Duration(seconds: 30);
const longestLockout = Duration(minutes: 15);

enum UnlockOutcome { signedIn, wrongPin, lockedOut }

class UnlockResult {
  const UnlockResult(this.outcome, [this.retryAfter = Duration.zero]);

  final UnlockOutcome outcome;

  /// How long until the next try is allowed (only for [UnlockOutcome.lockedOut]).
  final Duration retryAfter;

  bool get signedIn => outcome == UnlockOutcome.signedIn;
}

class CurrentStaffNotifier extends Notifier<String?> {
  // Saved after every try (see pinAttemptsSaverProvider), so closing the app does not reset the count.
  var _tries = <String, PinAttempts>{};

  @override
  String? build() {
    _tries = {...ref.read(initialPinAttemptsProvider)};
    return ref.read(initialSignedInProvider);
  }

  void _remember(String staffId, PinAttempts attempts) {
    _tries[staffId] = attempts;
    ref.read(pinAttemptsSaverProvider)?.call(staffId, attempts);
  }

  /// Signs [staffId] in if [pin] is theirs, and says what happened.
  UnlockResult unlock(String staffId, String pin) {
    final now = ref.read(nowProvider)();
    final tries = _tries[staffId] ?? const PinAttempts();

    // While locked out, the PIN is not even looked at.
    final until = tries.lockedUntil;
    if (until != null && now.isBefore(until)) {
      return UnlockResult(UnlockOutcome.lockedOut, until.difference(now));
    }

    final staff = ref.read(staffProvider).where((s) => s.id == staffId);
    if (staff.isNotEmpty && staff.first.active && PinHasher.verify(pin, staff.first.pinHash)) {
      if (tries != const PinAttempts()) _remember(staffId, const PinAttempts());
      state = staffId;
      return const UnlockResult(UnlockOutcome.signedIn);
    }

    final wrong = tries.wrong + 1;
    if (wrong < freeTries) {
      _remember(staffId, PinAttempts(wrong: wrong));
      return const UnlockResult(UnlockOutcome.wrongPin);
    }
    final doublings = min(wrong - freeTries, 10);
    final wait = Duration(seconds: min(firstLockout.inSeconds * (1 << doublings), longestLockout.inSeconds));
    _remember(staffId, PinAttempts(wrong: wrong, lockedUntil: now.add(wait)));
    // Nobody is signed in here, so the line is about the person whose PIN was tried. The owner is told (#63).
    ref.read(activityLogProvider.notifier).record(
      ActivityKind.pinLockedOut,
      staffId: staffId,
      suspicious: true,
      details: {'tries': wrong, 'name': ref.read(staffProvider).where((s) => s.id == staffId).firstOrNull?.name ?? ''},
    );
    return UnlockResult(UnlockOutcome.lockedOut, wait);
  }

  /// Signs [staffId] in without a PIN. Only for the first-run setup, where the owner has just chosen theirs.
  void signInAs(String staffId) => state = staffId;

  /// Forgets the wrong tries of [staffId] (after their PIN was reset).
  void clearLockout(String staffId) => _remember(staffId, const PinAttempts());

  /// Back to the "who is working?" screen. Nothing is lost: sessions keep running.
  void lock() => state = null;
}

final currentStaffIdProvider = NotifierProvider<CurrentStaffNotifier, String?>(CurrentStaffNotifier.new);

/// The person working now (null while locked).
final currentStaffProvider = Provider<StaffMember?>((ref) {
  final id = ref.watch(currentStaffIdProvider);
  if (id == null) return null;
  for (final s in ref.watch(staffProvider)) {
    if (s.id == id) return s;
  }
  return null;
});
