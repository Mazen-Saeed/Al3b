import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../app_theme.dart';
import '../floor/time_text.dart';
import '../l10n/l10n.dart';
import 'nav_provider.dart';
import 'notice_board.dart';
import 'notice_overlay.dart';

/// The bell, at the top corner of every page. A number shows how many notifications are waiting.
/// Tapping it drops a list down under the bell (not a separate page): each row can be tapped to go
/// to the device it is about, or cleared with its X; "امسح الكل" clears the list.
class NotificationBell extends ConsumerWidget {
  const NotificationBell({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(notificationsProvider).length;
    final width = (MediaQuery.sizeOf(context).width - 32).clamp(240.0, 380.0);
    return MenuAnchor(
      style: MenuStyle(
        backgroundColor: const WidgetStatePropertyAll(AppColors.surface),
        shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(22))),
        padding: const WidgetStatePropertyAll(EdgeInsets.zero),
      ),
      alignmentOffset: const Offset(0, 8),
      builder: (context, controller, _) => Badge.count(
        count: count,
        isLabelVisible: count > 0,
        backgroundColor: AppColors.waitingPayment,
        textColor: AppColors.onWaitingPayment,
        child: IconButton.filledTonal(
          key: const Key('notification-bell'),
          tooltip: context.l10n.notificationsTitle,
          onPressed: () => controller.isOpen ? controller.close() : controller.open(),
          icon: const Icon(Icons.notifications_none_rounded),
        ),
      ),
      menuChildren: [
        // A MenuAnchor hands its children a controller only through the builder, so the panel finds
        // it again from here.
        Builder(
          builder: (context) => SizedBox(
            width: width,
            child: _NotificationsPanel(onClose: () => MenuController.maybeOf(context)?.close()),
          ),
        ),
      ],
    );
  }
}

/// The dropped-down list: a title with "clear all", then the notifications, newest first.
class _NotificationsPanel extends ConsumerWidget {
  const _NotificationsPanel({required this.onClose});

  final VoidCallback onClose;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final items = ref.watch(notificationsProvider);
    final notifications = ref.read(notificationsProvider.notifier);
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(14, 10, 14, 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(child: Text(l10n.notificationsTitle, style: AppText.sectionTitle)),
              if (items.isNotEmpty)
                TextButton(
                  key: const Key('clear-all-notifications'),
                  onPressed: notifications.clear,
                  child: Text(l10n.clearAll),
                ),
            ],
          ),
          const SizedBox(height: 6),
          if (items.isEmpty)
            Padding(
              padding: const EdgeInsetsDirectional.symmetric(vertical: 24),
              child: Center(child: Text(l10n.noNotifications, style: AppText.label)),
            )
          else
            // A plain Column, not a ListView: the menu measures its content's width first, which a
            // ListView cannot answer. The menu scrolls by itself when the list is taller than the window.
            for (final item in items)
              Padding(
                padding: const EdgeInsetsDirectional.only(bottom: 8),
                child: _NotificationRow(
                  item: item,
                  onOpen: () {
                    onClose();
                    final unitId = item.unitId;
                    if (unitId == null) return;
                    // Go to the Floor and open that device.
                    ref.read(navProvider.notifier).open(NavPage.floor);
                    ref.read(focusUnitProvider.notifier).focus(unitId);
                  },
                  onClear: () => notifications.remove(item.id),
                ),
              ),
        ],
      ),
    );
  }
}

class _NotificationRow extends StatelessWidget {
  const _NotificationRow({required this.item, required this.onOpen, required this.onClear});

  final AppNotification item;
  final VoidCallback onOpen;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    final (_, _, iconColor, icon) = noticeLook(item.kind);
    return Material(
      color: AppColors.raised,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        key: Key('notification-${item.id}'),
        borderRadius: BorderRadius.circular(18),
        onTap: onOpen,
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(14, 6, 4, 6),
          child: Row(
            children: [
              Icon(icon, color: iconColor, size: 24),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                    Text(friendlyTime(context.l10n, item.at), style: AppText.small),
                  ],
                ),
              ),
              IconButton(
                key: Key('clear-${item.id}'),
                onPressed: onClear,
                icon: const Icon(Icons.close, size: 20, color: AppColors.textMuted),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
