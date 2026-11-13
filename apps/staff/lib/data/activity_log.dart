import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'ids.dart';
import 'staff_provider.dart';

/// The kinds of line in the activity log (decisions #62, #63). The text is what the backend stores, so a new
/// kind needs no migration.
class ActivityKind {
  const ActivityKind._();

  static const cashBoxClosed = 'cash_box_closed';
  static const cashWithdrawal = 'cash_withdrawal';
  static const sessionZeroCost = 'session_zero_cost';
  static const discountGiven = 'discount_given';
  static const sessionCancelled = 'session_cancelled';
  static const billCorrected = 'bill_corrected';
  static const paymentAccountChanged = 'payment_account_changed'; // a QR people pay to: always suspicious
  static const paymentAccountRemoved = 'payment_account_removed';
  static const pinLockedOut = 'pin_locked_out';
  static const staffAdded = 'staff_added';
  static const staffStopped = 'staff_stopped';
  static const staffPinReset = 'staff_pin_reset';
  static const staffRoleChanged = 'staff_role_changed';
}

/// The limits behind "suspicious" (decision #63, #38). They become shop settings later; until then they are here.
const cashDifferenceLimit = 2000; // a cash box counted 20 EGP or more off
const largeDiscountLimit = 5000; // a discount of 50 EGP or more

/// One line of the log: who did what, and when. Never changed or removed once written.
class ActivityEntry {
  const ActivityEntry({
    required this.id,
    required this.at,
    required this.staffId,
    required this.kind,
    this.suspicious = false,
    this.details = const {},
  });

  final String id;
  final DateTime at;
  final String staffId;
  final String kind;

  /// One of the events that tell the owner (decision #63).
  final bool suspicious;

  /// What is special about this kind: amounts, names, minutes. Plain values only (they are stored as JSON).
  final Map<String, Object?> details;

  /// A detail that is text, or null.
  String? text(String key) => details[key] is String ? details[key] as String : null;

  /// A detail that is a whole number (piasters, minutes), or null.
  int? number(String key) => details[key] is int ? details[key] as int : null;
}

/// The log when the app starts: loaded from the database. Tests replace it.
final initialActivityLogProvider = Provider<List<ActivityEntry>>((ref) => const []);

/// The activity log, oldest first. Lines are only ever added.
class ActivityLogNotifier extends Notifier<List<ActivityEntry>> {
  @override
  List<ActivityEntry> build() => ref.read(initialActivityLogProvider);

  /// Writes a line. [staffId] is who did it; by default whoever is signed in.
  void record(String kind, {Map<String, Object?> details = const {}, bool suspicious = false, String? staffId}) {
    final who = staffId ?? ref.read(currentStaffIdProvider) ?? '';
    state = [
      ...state,
      ActivityEntry(
        id: newId(),
        at: ref.read(nowProvider)(),
        staffId: who,
        kind: kind,
        suspicious: suspicious,
        details: details,
      ),
    ];
  }
}

final activityLogProvider = NotifierProvider<ActivityLogNotifier, List<ActivityEntry>>(ActivityLogNotifier.new);
