import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../app_theme.dart';
import '../data/staff_member.dart';
import '../data/staff_provider.dart';
import '../l10n/l10n.dart';
import '../shell/add_card.dart';
import 'staff_form.dart';

/// Manage > Staff (الموظفين): the people who work at the shop. Admins add people, change names and PINs
/// (a forgotten PIN, #54) and stop people who left. Only the owner makes someone an Admin (#63). A stopped
/// person cannot sign in, but their name stays on old bills and cash records, so they are not listed here.
class StaffScreen extends ConsumerWidget {
  const StaffScreen({super.key, required this.onBack});

  final VoidCallback onBack; // back to the Manage list

  Future<void> _add(BuildContext context, WidgetRef ref) async {
    final staff = ref.read(staffProvider.notifier); // before the await
    final result = await showStaffForm(context);
    if (result == null) return;
    staff.add(name: result.name, pin: result.newPin ?? '', phone: result.phone, isAdmin: result.isAdmin);
  }

  Future<void> _edit(BuildContext context, WidgetRef ref, StaffMember person) async {
    final staff = ref.read(staffProvider.notifier);
    final result = await showStaffForm(context, person: person);
    if (result == null) return;
    if (result.stop) {
      staff.deactivate(person.id);
      return;
    }
    staff.update(person.id, name: result.name, phone: result.isAdmin ? result.phone : null, isAdmin: result.isAdmin);
    if (result.newPin != null) staff.resetPin(person.id, result.newPin!);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final notifier = ref.read(staffProvider.notifier);
    final people = ref.watch(staffProvider).where((s) => s.active).toList();
    ref.watch(currentStaffIdProvider); // the rows a person may open depend on who is signed in
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            IconButton.filledTonal(onPressed: onBack, icon: const Icon(Icons.arrow_back)),
            const SizedBox(width: 14),
            Text(l10n.staffTitle, style: AppText.sectionTitle),
          ],
        ),
        const SizedBox(height: 18),
        Expanded(
          child: SingleChildScrollView(
            child: Align(
              alignment: AlignmentDirectional.topStart,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 720),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    AddCard(label: l10n.newStaff, onTap: () => _add(context, ref)),
                    const SizedBox(height: 14),
                    for (final p in people) ...[
                      _PersonRow(person: p, onTap: notifier.canManage(p) ? () => _edit(context, ref, p) : null),
                      const SizedBox(height: 10),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _PersonRow extends StatelessWidget {
  const _PersonRow({required this.person, required this.onTap});

  final StaffMember person;
  final VoidCallback? onTap; // null = this person cannot be changed by whoever is signed in

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final role = person.isOwner ? l10n.roleOwner : (person.isAdmin ? l10n.roleAdmin : l10n.roleStaff);
    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        key: Key('staff-row-${person.id}'),
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsetsDirectional.symmetric(horizontal: 18, vertical: 16),
          child: Row(
            children: [
              Expanded(child: Text(person.name, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600))),
              Text(role, style: AppText.small),
              if (onTap != null) ...[
                const SizedBox(width: 10),
                const Icon(Icons.edit_outlined, size: 20, color: AppColors.textMuted),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
