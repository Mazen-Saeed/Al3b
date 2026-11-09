import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../app_theme.dart';
import '../data/staff_provider.dart';
import '../l10n/l10n.dart';
import 'needs_action_provider.dart';

/// The app's side navigation (shared by all screens).
/// On the start side: right in Arabic, left in English.
class SideNav extends ConsumerWidget {
  const SideNav({
    super.key,
    required this.selectedIndex,
    required this.onSelect,
  });

  final int selectedIndex; // which item is highlighted
  final ValueChanged<int> onSelect; // called with the tapped item's index

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final name = ref.watch(currentStaffProvider)?.name ?? '';
    final dots = ref.watch(navDotsProvider); // nav pages with something waiting

    // The items, in order. Index 0 is the Floor screen.
    final items = [
      (Icons.grid_view_rounded, l10n.homeTitle),
      (Icons.local_drink_outlined, l10n.navQuickSale),
      (Icons.event_outlined, l10n.navReservations),
      (Icons.payments_outlined, l10n.navShift),
    ];

    return Container(
      width: 88,
      padding: const EdgeInsetsDirectional.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(28),
      ),
      // When the window is too short for every button, the nav scrolls instead of overflowing.
      // (minHeight + IntrinsicHeight keep the Spacer working: in a tall window the profile button
      // still sits at the bottom.)
      child: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: IntrinsicHeight(
              child: Column(
                children: [
                  // App mark: first letter of the name on a cream square.
                  Container(
                    width: 52,
                    height: 52,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.running,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Text(
                      l10n.appTitle.characters.first,
                      style: const TextStyle(color: AppColors.textOnLight, fontSize: 22, fontWeight: FontWeight.w700),
                    ),
                  ),
                  const SizedBox(height: 14),
                  for (final (index, (icon, label)) in items.indexed)
                    Padding(
                      padding: const EdgeInsetsDirectional.only(bottom: 6),
                      child: _NavButton(
                        icon: icon,
                        label: label,
                        selected: index == selectedIndex,
                        showDot: dots.contains(index),
                        onTap: () => onSelect(index),
                      ),
                    ),
                  const Spacer(),
                  // Management (staff, units & prices, products, reports, settings).
                  // TODO: show only to owners and managers once login exists.
                  Padding(
                    padding: const EdgeInsetsDirectional.only(bottom: 12),
                    child: _NavButton(
                      icon: Icons.tune_rounded,
                      label: l10n.navManage,
                      selected: selectedIndex == items.length,
                      showDot: dots.contains(items.length),
                      onTap: () => onSelect(items.length),
                    ),
                  ),
                  // Settings sits right under Management.
                  Padding(
                    padding: const EdgeInsetsDirectional.only(bottom: 12),
                    child: _NavButton(
                      icon: Icons.settings_outlined,
                      label: l10n.settingsTitle,
                      selected: selectedIndex == items.length + 1,
                      onTap: () => onSelect(items.length + 1),
                    ),
                  ),
                  // The person using the app (hover shows the name). It will open their profile later;
                  // switching person is the button in the Floor header.
                  Tooltip(
                    message: name,
                    child: InkWell(
                      onTap: () {}, // TODO: open the profile
                      customBorder: const CircleBorder(),
                      child: Container(
                        width: 52,
                        height: 52,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.raised, width: 2),
                        ),
                        child: const Icon(Icons.person_outline_rounded, size: 26),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// One icon button in the side nav, with a tooltip and an optional red dot.
class _NavButton extends StatelessWidget {
  const _NavButton({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
    this.showDot = false,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;
  final bool showDot;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: label, // shown on hover/long-press; also read by screen readers
      child: Material(
        color: selected ? AppColors.raised : Colors.transparent,
        borderRadius: BorderRadius.circular(18),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(18),
          child: SizedBox(
            width: 56,
            height: 56,
            // Stack = widgets on top of each other: the icon, plus the dot in a corner.
            child: Stack(
              alignment: Alignment.center,
              children: [
                Icon(icon, color: selected ? AppColors.text : AppColors.textMuted),
                if (showDot)
                  PositionedDirectional(
                    top: 12,
                    end: 12,
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: const BoxDecoration(color: AppColors.waitingPayment, shape: BoxShape.circle),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
