import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../app_theme.dart';
import '../data/unit_type.dart';
import '../data/unit_types_provider.dart';
import '../floor/floor_sections.dart';
import '../l10n/l10n.dart';
import '../shell/form_surface.dart';

/// What the owner filled in for a new type of device.
class UnitTypeDraft {
  const UnitTypeDraft({required this.name, required this.iconKey, required this.hasPairPrice});

  final String name;
  final String iconKey;
  final bool hasPairPrice;
}

/// A type of device of the shop's own (foosball, VR, a padel court...). Returns null if closed without saving.
Future<UnitTypeDraft?> showUnitTypeForm(BuildContext context) =>
    showFormSurface<UnitTypeDraft>(context, const _UnitTypeForm());

class _UnitTypeForm extends ConsumerStatefulWidget {
  const _UnitTypeForm();

  @override
  ConsumerState<_UnitTypeForm> createState() => _UnitTypeFormState();
}

class _UnitTypeFormState extends ConsumerState<_UnitTypeForm> {
  final _name = TextEditingController();
  String _iconKey = unitTypeIconChoices.first;
  bool _hasPairPrice = false;

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
          const SizedBox(height: 18),
          Text(l10n.unitTypeIconLabel, style: AppText.label),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final key in unitTypeIconChoices)
                Material(
                  color: _iconKey == key ? AppColors.running : Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: _iconKey == key ? BorderSide.none : const BorderSide(color: AppColors.raised, width: 1.5),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: InkWell(
                    key: Key('unit-type-icon-$key'),
                    onTap: () => setState(() => _iconKey = key),
                    child: SizedBox(
                      width: 52,
                      height: 52,
                      child: Icon(
                        unitTypeIcons[key],
                        color: _iconKey == key ? AppColors.textOnLight : AppColors.text,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 10),
          SwitchListTile(
            key: const Key('unit-type-pair'),
            contentPadding: EdgeInsets.zero,
            title: Text(l10n.unitTypePairLabel),
            value: _hasPairPrice,
            onChanged: (value) => setState(() => _hasPairPrice = value),
          ),
          const SizedBox(height: 12),
          FilledButton(
            key: const Key('unit-type-save'),
            onPressed: canSave
                ? () => Navigator.pop(
                      context,
                      UnitTypeDraft(name: _name.text.trim(), iconKey: _iconKey, hasPairPrice: _hasPairPrice),
                    )
                : null,
            style: FilledButton.styleFrom(minimumSize: const Size(0, 60)),
            child: Text(l10n.save, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }
}
