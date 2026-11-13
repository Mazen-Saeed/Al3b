/// A person who works at the shop. Staff and Admin are the only two roles (decision #36).
///
/// Only a hash of the PIN is kept (see PinHasher); the PIN itself is never stored.
class StaffMember {
  const StaffMember({
    required this.id,
    required this.name,
    required this.pinHash,
    this.phone,
    this.isAdmin = false,
    this.isOwner = false,
    this.active = true,
  });

  final String id;
  final String name;
  final String pinHash; // from PinHasher.hash
  final String? phone; // Owner and Admins have one (they sign in with it, #67); plain Staff may not
  final bool isAdmin; // Admin: prices, deletes, reports, staff, settings. Staff: the floor.
  final bool active; // false = stopped: cannot sign in, but old bills and cash records keep the name
  final bool isOwner; // The shop's owner: an Admin who can also add or remove Admins (decision #63).

  StaffMember copyWith({String? name, String? phone, String? pinHash, bool? isAdmin, bool? active}) => StaffMember(
        id: id,
        name: name ?? this.name,
        phone: phone ?? this.phone,
        pinHash: pinHash ?? this.pinHash,
        isAdmin: isAdmin ?? this.isAdmin,
        isOwner: isOwner,
        active: active ?? this.active,
      );
}
