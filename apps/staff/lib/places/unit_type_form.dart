import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../app_theme.dart';
import '../data/unit_types_provider.dart';
import '../floor/floor_sections.dart';
import '../l10n/l10n.dart';
import '../shell/form_surface.dart';

/// A type of device of the shop's own (toy cars, foosball, VR...). Returns the name the owner typed,
/// or null if closed without saving.
Future<String?> showUnitTypeForm(BuildContext context) => showFormSurface<String>(context, const _UnitTypeForm());

class _UnitTypeForm extends ConsumerStatefulWidget {
  const _UnitTypeForm();

  @override
  ConsumerState<_UnitTypeForm> createState() => _UnitTypeFormState();
}

class _UnitTypeFormState extends ConsumerState<_UnitTypeForm> {
  final _name = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final wanted = _name.text.trim().toLowerCase();
    final taken = wanted.isNotEmpty &&
        ref.watch(unitTypesProvider).any((t) => unitTypeName(t, l10n).toLowerCase() == wanted);
    final canSave = wanted.isNotEmpty && !taken;
    return Padding(
      padding: const EdgeInsetsDirectional.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FormHeader(title: l10n.deviceTypeLabel, heading: l10n.newDeviceType),
          const SizedBox(height: 18),
          Text(l10n.unitTypeNameLabel, style: AppText.label),
          const SizedBox(height: 10),
          TextField(
            key: const Key('unit-type-name'),
            controller: _name,
            autofocus: true,
            decoration: InputDecoration(hintText: l10n.unitTypeNameHint),
            onChanged: (_) => setState(() {}), // redraw so the save button can enable
          ),
          if (taken) ...[
            const SizedBox(height: 8),
            Text(l10n.unitTypeExists, key: const Key('unit-type-exists'), style: AppText.small),
          ],
          const SizedBox(height: 22),
          FilledButton(
            key: const Key('unit-type-save'),
            onPressed: canSave ? () => Navigator.pop(context, _name.text.trim()) : null,
            style: FilledButton.styleFrom(minimumSize: const Size(0, 60)),
            child: Text(l10n.save, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }
}
