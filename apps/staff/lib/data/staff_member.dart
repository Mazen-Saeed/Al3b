/// A person who works at the shop. Staff and Admin are the only two roles (decision #36).
///
/// For now the PIN is kept as typed, in memory. When the local database comes, only a hash of
/// it is stored (the backend already has `staff.pin_hash`).
class StaffMember {
  const StaffMember({required this.id, required this.name, required this.pin, this.isAdmin = false});

  final String id;
  final String name;
  final String pin; // 4 digits
  final bool isAdmin; // Admin: prices, deletes, reports, staff, settings. Staff: the floor.
}
