import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../app_theme.dart';
import '../data/input_rules.dart';
import '../data/money.dart';
import '../data/staff_member.dart';
import '../data/staff_provider.dart';
import '../l10n/l10n.dart';
import '../shell/form_surface.dart';

/// What the form asks for. [newPin] is null when the PIN is left as it is (editing only). [stop] means "stop
/// this person".
class StaffFormResult {
  const StaffFormResult({required this.name, required this.phone, required this.isAdmin, this.newPin, this.stop = false});

  final String name;
  final String? phone;
  final bool isAdmin;
  final String? newPin;
  final bool stop;
}

/// A new person ([person] null) or change one. Returns null if closed without saving.
Future<StaffFormResult?> showStaffForm(BuildContext context, {StaffMember? person}) =>
    showFormSurface<StaffFormResult>(context, _StaffForm(person: person));

class _StaffForm extends ConsumerStatefulWidget {
  const _StaffForm({this.person});

  final StaffMember? person;

  @override
  ConsumerState<_StaffForm> createState() => _StaffFormState();
}

class _StaffFormState extends ConsumerState<_StaffForm> {
  late final _name = TextEditingController(text: widget.person?.name);
  late final _phone = TextEditingController(text: widget.person?.phone);
  final _pin = TextEditingController();
  late bool _isAdmin = widget.person?.isAdmin ?? false;
  bool _confirmStop = false;

  @override
  void dispose() {
    _name.dispose();
    _phone.dispose();
    _pin.dispose();
    super.dispose();
  }

  bool get _isNew => widget.person == null;
  String get _phoneText => westernDigits(_phone.text).trim();
  String get _pinText => westernDigits(_pin.text).trim();

  bool get _nameTaken => ref.read(staffProvider.notifier).nameTaken(_name.text, exceptId: widget.person?.id);
  bool get _phoneBad => _isAdmin && _phoneText.length >= 11 && !isEgyptianMobile(_phoneText);
  bool get _pinOk => _isNew ? isValidPin(_pinText) : (_pinText.isEmpty || isValidPin(_pinText));

  bool get _canSave =>
      _name.text.trim().isNotEmpty && !_nameTaken && _pinOk && (!_isAdmin || isEgyptianMobile(_phoneText));

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final actor = ref.watch(currentStaffProvider);
    final person = widget.person;
    final canChangeRole = (actor?.isOwner ?? false) && !(person?.isOwner ?? false);
    final canStop = person != null && !person.isOwner && person.id != actor?.id;
    return Padding(
      padding: const EdgeInsetsDirectional.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FormHeader(title: l10n.staffTitle, heading: person?.name ?? l10n.newStaff),
          const SizedBox(height: 18),
          TextField(
            key: const Key('staff-name'),
            controller: _name,
            autofocus: true,
            decoration: InputDecoration(hintText: l10n.staffNameHint),
            onChanged: (_) => setState(() {}),
          ),
          if (_nameTaken) ...[
            const SizedBox(height: 8),
            Text(l10n.staffNameTaken, key: const Key('staff-name-taken'), style: AppText.small),
          ],
          const SizedBox(height: 12),
          TextField(
            key: const Key('staff-pin'),
            controller: _pin,
            keyboardType: TextInputType.number,
            maxLength: 4,
            inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9٠-٩]'))],
            decoration: InputDecoration(hintText: _isNew ? l10n.staffPinNewHint : l10n.staffPinChangeHint, counterText: ''),
            onChanged: (_) => setState(() {}),
          ),
          if (canChangeRole) ...[
            const SizedBox(height: 12),
            SwitchListTile(
              key: const Key('staff-admin'),
              contentPadding: EdgeInsets.zero,
              title: Text(l10n.roleAdmin),
              subtitle: Text(l10n.staffAdminHint, style: AppText.small),
              value: _isAdmin,
              onChanged: (v) => setState(() => _isAdmin = v),
            ),
          ],
          if (_isAdmin) ...[
            const SizedBox(height: 12),
            TextField(
              key: const Key('staff-phone'),
              controller: _phone,
              keyboardType: TextInputType.number,
              maxLength: 11,
              inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9٠-٩]'))],
              decoration: InputDecoration(hintText: l10n.staffPhoneHint, counterText: ''),
              onChanged: (_) => setState(() {}),
            ),
            if (_phoneBad) ...[
              const SizedBox(height: 8),
              Text(l10n.phoneInvalid, style: const TextStyle(color: AppColors.waitingPayment)),
            ],
          ],
          const SizedBox(height: 22),
          FilledButton(
            key: const Key('staff-save'),
            onPressed: _canSave
                ? () => Navigator.pop(
                      context,
                      StaffFormResult(
                        name: _name.text.trim(),
                        phone: _isAdmin ? _phoneText : person?.phone,
                        isAdmin: _isAdmin,
                        newPin: _pinText.isEmpty ? null : _pinText,
                      ),
                    )
                : null,
            style: FilledButton.styleFrom(minimumSize: const Size(0, 60)),
            child: Text(l10n.save, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
          ),
          if (canStop) ...[
            const SizedBox(height: 8),
            TextButton(
              key: const Key('staff-stop'),
              onPressed: () {
                if (!_confirmStop) {
                  setState(() => _confirmStop = true); // the first tap only asks; the second one does it
                  return;
                }
                Navigator.pop(
                  context,
                  StaffFormResult(name: person.name, phone: person.phone, isAdmin: person.isAdmin, stop: true),
                );
              },
              style: TextButton.styleFrom(foregroundColor: AppColors.alert),
              child: Text(_confirmStop ? l10n.stopStaffConfirm : l10n.stopStaff),
            ),
          ],
        ],
      ),
    );
  }
}
