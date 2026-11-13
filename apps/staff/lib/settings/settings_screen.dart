import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../app_theme.dart';
import '../data/cash_settings_provider.dart';
import '../data/staff_provider.dart';
import '../l10n/app_language.dart';
import '../l10n/l10n.dart';
import '../shell/pill.dart';
import 'backup_section.dart';
import 'payment_accounts_section.dart';

/// The Settings page (its own place in the nav). Only the language for now; the shop's rules (#38) will be added here.
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final language = ref.watch(appLanguageProvider).languageCode;
    final languages = ref.read(appLanguageProvider.notifier);
    // A ListView, not a Column: with the payment accounts and the backups the page is taller than a small screen.
    return ListView(
      children: [
        Text(l10n.settingsTitle, style: AppText.formTitle),
        const SizedBox(height: 18),
        Text(l10n.languageLabel, style: AppText.label),
        const SizedBox(height: 10),
        // Each language is written in its own language, so it can be found whatever the app shows.
        Wrap(
          spacing: 8,
          children: [
            Pill(label: 'العربية', selected: language == 'ar', onTap: () => languages.set(const Locale('ar'))),
            Pill(label: 'English', selected: language == 'en', onTap: () => languages.set(const Locale('en'))),
          ],
        ),
        // Shop rules are for Admins only. (Staff only get the language.)
        if (ref.watch(currentStaffProvider)?.isAdmin ?? false) ...[
          const SizedBox(height: 26),
          // The cashier may see how much should be in the cash box before counting. Off = a blind count.
          SwitchListTile(
            key: const Key('show-expected-switch'),
            contentPadding: EdgeInsets.zero,
            title: Text(l10n.showExpectedSetting),
            subtitle: Text(l10n.showExpectedHelp, style: AppText.small),
            value: ref.watch(showExpectedCashProvider),
            onChanged: ref.read(showExpectedCashProvider.notifier).set,
          ),
          const SizedBox(height: 26),
          const PaymentAccountsSection(),
          const SizedBox(height: 26),
          const BackupSection(),
        ],
      ],
    );
  }
}
