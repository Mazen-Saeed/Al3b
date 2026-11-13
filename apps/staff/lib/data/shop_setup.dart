import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'expense_categories_provider.dart';
import 'expense_category.dart';
import 'ids.dart';
import 'input_rules.dart';
import 'pin_hasher.dart';
import 'shop_info.dart';
import 'staff_member.dart';
import 'staff_provider.dart';

export 'input_rules.dart';

/// The id the shop will get when the first-run setup is finished. The app opens the database with it, so
/// everything saved belongs to this shop. (Tests get a fresh one.)
final pendingVenueIdProvider = Provider<String>((ref) => newId());

/// The first-run setup: the owner names the shop and chooses their PIN. Everything the shop starts with is
/// created here, with fresh ids that belong to this shop alone.
class ShopSetup {
  ShopSetup(this._ref);

  final Ref _ref;

  void finish({
    required String shopName,
    required String ownerName,
    required String phone,
    required String pin,
    PinHasher hasher = const PinHasher(),
  }) {
    assert(isEgyptianMobile(phone) && isValidPin(pin));
    final venueId = _ref.read(pendingVenueIdProvider);
    final owner = StaffMember(
      id: newId(),
      name: ownerName.trim(),
      phone: phone,
      pinHash: hasher.hash(pin),
      isAdmin: true,
      isOwner: true,
    );
    // Signed in first, so everything saved from here on is recorded as the owner's. The shop name goes last:
    // it is what makes the app leave the setup screen.
    _ref.read(currentStaffIdProvider.notifier).signInAs(owner.id);
    _ref.read(staffProvider.notifier).setAll([owner]);
    _ref.read(expenseCategoriesProvider.notifier).setAll(defaultExpenseCategoriesFor(venueId));
    _ref.read(shopInfoProvider.notifier).set(ShopInfo(id: venueId, name: shopName.trim(), phone: phone));
  }
}

final shopSetupProvider = Provider<ShopSetup>(ShopSetup.new);
