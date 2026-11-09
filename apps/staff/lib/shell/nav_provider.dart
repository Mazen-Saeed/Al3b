import 'package:flutter_riverpod/flutter_riverpod.dart';

/// The pages of the nav, in nav order. The index is the page's place in the nav bar.
class NavPage {
  static const floor = 0;
  static const quickSale = 1;
  static const reservations = 2;
  static const shift = 3;
  static const manage = 4;
  static const settings = 5;
}

/// Which page is showing. It lives in a provider, not inside the shell, so a button on one page
/// (the Floor's "+ بيع سريع") can open another page.
class NavNotifier extends Notifier<int> {
  @override
  int build() => NavPage.floor;

  void open(int page) => state = page;
}

final navProvider = NotifierProvider<NavNotifier, int>(NavNotifier.new);

/// A unit the Floor should open (its panel, and the highlight ring), set when staff tap a
/// notification about it. The Floor takes it and clears it.
class FocusUnitNotifier extends Notifier<String?> {
  @override
  String? build() => null;

  void focus(String unitId) => state = unitId;

  void clear() => state = null;
}

final focusUnitProvider = NotifierProvider<FocusUnitNotifier, String?>(FocusUnitNotifier.new);
