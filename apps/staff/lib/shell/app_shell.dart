import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../app_theme.dart';
import '../cash/cash_box_screen.dart';
import '../floor/floor_screen.dart';
import '../l10n/l10n.dart';
import '../manage/manage_screen.dart';
import '../quick_sale/quick_sale_screen.dart';
import '../settings/settings_screen.dart';
import 'layout.dart';
import 'nav_provider.dart';
import 'needs_action_provider.dart';
import 'notification_bell.dart';
import 'side_nav.dart';

/// The frame around every page: side nav on tablets and PCs, bottom bar on phones.
/// A page is just its content; it never builds navigation itself.
///
/// Page order = nav order: Floor, Quick sale, Reservations, Cash box, Manage, Settings.
class AppShell extends ConsumerStatefulWidget {
  const AppShell({super.key});

  @override
  ConsumerState<AppShell> createState() => _AppShellState();
}

class _AppShellState extends ConsumerState<AppShell> {
  /// Opening a page means seeing what is waiting on it: mark it seen, so its dot goes away (and stays
  /// away while the page is open).
  void _seeCurrentPage() {
    final page = ref.read(navProvider);
    ref.read(seenProvider.notifier).acknowledge(page, ref.read(needsActionKeysProvider)[page] ?? const {});
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _seeCurrentPage();
    });
  }

  // The pages sit in a different place in the widget tree on a phone (inside a SafeArea, above
  // the bottom bar) than on a PC (next to the side nav). Without a key, resizing the window
  // across that line makes Flutter throw the pages away and build new ones, so you lose
  // whatever you were in (the Products page, a selected unit). A GlobalKey lets Flutter
  // pick the same pages up and move them to the new place, state included.
  final _pagesKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final index = ref.watch(navProvider); // which page is showing
    final dots = ref.watch(navDotsProvider); // nav pages with something new waiting
    ref.listen(navProvider, (previous, next) => _seeCurrentPage());
    ref.listen(needsActionKeysProvider, (previous, next) => _seeCurrentPage());

    // An orange dot on a nav icon when that page has something waiting.
    Widget dotted(int page, IconData icon) => Badge(
          isLabelVisible: dots.contains(page),
          smallSize: 10,
          backgroundColor: AppColors.waitingPayment,
          child: Icon(icon),
        );

    // IndexedStack builds all pages but shows one, so each page keeps its own state
    // (the Floor's toggle and selection survive a trip to another page).
    final pages = IndexedStack(
      key: _pagesKey,
      index: index,
      sizing: StackFit.expand,
      children: [
        const FloorScreen(),
        const QuickSaleScreen(),
        _ComingSoon(title: l10n.navReservations),
        const CashBoxScreen(),
        const ManageScreen(),
        const SettingsScreen(),
      ],
    );

    void select(int page) {
      // Tapping Manage always shows its list, even from inside one of its areas.
      if (page == NavPage.manage) ref.read(manageAreaProvider.notifier).close();
      ref.read(navProvider.notifier).open(page);
    }

    // Phone: bottom navigation bar.
    if (screenSizeOf(context) == ScreenSize.phone) {
      return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 16, 0),
            child: Column(
              children: [
                const Align(alignment: AlignmentDirectional.centerEnd, child: NotificationBell()),
                const SizedBox(height: 8),
                Expanded(child: pages),
              ],
            ),
          ),
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: index,
          onDestinationSelected: select,
          destinations: [
            NavigationDestination(icon: dotted(NavPage.floor, Icons.grid_view_rounded), label: l10n.homeTitle),
            NavigationDestination(icon: const Icon(Icons.local_drink_outlined), label: l10n.navQuickSale),
            NavigationDestination(icon: dotted(NavPage.reservations, Icons.event_outlined), label: l10n.navReservations),
            NavigationDestination(icon: dotted(NavPage.shift, Icons.payments_outlined), label: l10n.navShift),
            NavigationDestination(icon: dotted(NavPage.manage, Icons.tune_rounded), label: l10n.navManage),
            NavigationDestination(icon: const Icon(Icons.settings_outlined), label: l10n.settingsTitle),
          ],
        ),
      );
    }

    // Tablet / PC: side nav + page.
    return Scaffold(
      body: Padding(
        padding: const EdgeInsetsDirectional.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch, // nav and page are full height
          children: [
            SideNav(selectedIndex: index, onSelect: select),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // The bell sits at the end of the top edge (top left in Arabic) on every page.
                  const Align(alignment: AlignmentDirectional.centerEnd, child: NotificationBell()),
                  const SizedBox(height: 8),
                  Expanded(child: pages),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Placeholder for pages we haven't built yet: just the nav label.
class _ComingSoon extends StatelessWidget {
  const _ComingSoon({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(title, style: AppText.label));
  }
}
