import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'sample_data.dart';
import 'staff_member.dart';

/// The people who work at this shop. Tests replace it; later it comes from the local database.
final initialStaffProvider = Provider<List<StaffMember>>((ref) => buildSampleStaff());

/// Who is working right now: the id of the person who typed their PIN, or null while locked.
/// Tests start signed in by overriding this.
final initialSignedInProvider = Provider<String?>((ref) => null);

class CurrentStaffNotifier extends Notifier<String?> {
  @override
  String? build() => ref.read(initialSignedInProvider);

  /// Signs [staffId] in if [pin] is theirs. Returns false (and stays locked) when it is not.
  bool unlock(String staffId, String pin) {
    final staff = ref.read(initialStaffProvider).where((s) => s.id == staffId);
    if (staff.isEmpty || staff.first.pin != pin) return false;
    state = staffId;
    return true;
  }

  /// Back to the "who is working?" screen. Nothing is lost: sessions keep running.
  void lock() => state = null;
}

final currentStaffIdProvider = NotifierProvider<CurrentStaffNotifier, String?>(CurrentStaffNotifier.new);

/// The person working now (null while locked).
final currentStaffProvider = Provider<StaffMember?>((ref) {
  final id = ref.watch(currentStaffIdProvider);
  if (id == null) return null;
  for (final s in ref.watch(initialStaffProvider)) {
    if (s.id == id) return s;
  }
  return null;
});
