import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../app_theme.dart';
import '../data/money.dart';
import '../data/staff_member.dart';
import '../data/staff_provider.dart';
import '../floor/time_text.dart';
import '../l10n/l10n.dart';
import 'pill.dart';

/// Shown while nobody is signed in: pick your name, then type your 4-digit PIN.
/// It is only a lock: running sessions, alerts and data carry on behind it.
class LockScreen extends ConsumerStatefulWidget {
  const LockScreen({super.key});

  @override
  ConsumerState<LockScreen> createState() => _LockScreenState();
}

class _LockScreenState extends ConsumerState<LockScreen> {
  static const _pinLength = 4;

  /// The numpad keys, whatever character the keyboard layout reports for them.
  static final _numpadDigits = {
    LogicalKeyboardKey.numpad0: '0',
    LogicalKeyboardKey.numpad1: '1',
    LogicalKeyboardKey.numpad2: '2',
    LogicalKeyboardKey.numpad3: '3',
    LogicalKeyboardKey.numpad4: '4',
    LogicalKeyboardKey.numpad5: '5',
    LogicalKeyboardKey.numpad6: '6',
    LogicalKeyboardKey.numpad7: '7',
    LogicalKeyboardKey.numpad8: '8',
    LogicalKeyboardKey.numpad9: '9',
  };

  StaffMember? _who; // null = still choosing a name
  String _typed = '';
  bool _wrong = false;
  Duration? _lockedFor; // set when too many wrong tries: how long to wait
  final _focus = FocusNode(); // keeps the keyboard listening after the name buttons disappear

  @override
  void dispose() {
    _focus.dispose();
    super.dispose();
  }

  void _digit(String d) {
    if (_typed.length >= _pinLength) return;
    setState(() {
      _typed += d;
      _wrong = false;
    });
    if (_typed.length == _pinLength) {
      // Read the notifier before anything else; if the PIN is right this screen is replaced.
      final result = ref.read(currentStaffIdProvider.notifier).unlock(_who!.id, _typed);
      if (!result.signedIn) {
        setState(() {
          _typed = '';
          _wrong = true;
          _lockedFor = result.outcome == UnlockOutcome.lockedOut ? result.retryAfter : null;
        });
      }
    }
  }

  void _backspace() {
    if (_typed.isEmpty) return;
    setState(() {
      _typed = _typed.substring(0, _typed.length - 1);
      _wrong = false;
    });
  }

  /// The PIN can also be typed on the keyboard: digits (Arabic digits too, and the numpad) and
  /// Backspace. Only while a name is chosen; the on-screen keys keep working.
  KeyEventResult _onKey(FocusNode node, KeyEvent event) {
    if (_who == null || event is KeyUpEvent) return KeyEventResult.ignored;
    if (event.logicalKey == LogicalKeyboardKey.backspace) {
      _backspace();
      return KeyEventResult.handled;
    }
    final typed = _numpadDigits[event.logicalKey] ?? westernDigits(event.character ?? event.logicalKey.keyLabel);
    if (RegExp(r'^[0-9]$').hasMatch(typed)) {
      _digit(typed);
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final staff = ref.watch(staffProvider);
    return Focus(
      focusNode: _focus,
      autofocus: true,
      onKeyEvent: _onKey,
      child: _scaffold(l10n, staff),
    );
  }

  Widget _scaffold(AppLocalizations l10n, List<StaffMember> staff) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsetsDirectional.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 360),
              child: _who == null ? _names(l10n.pickYourName, staff) : _pinStep(l10n),
            ),
          ),
        ),
      ),
    );
  }

  Widget _names(String title, List<StaffMember> staff) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(title, style: AppText.formTitle, textAlign: TextAlign.center),
        const SizedBox(height: 24),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 10,
          runSpacing: 12,
          children: [
            for (final s in staff.where((s) => s.active))
              Pill(label: s.name, selected: false, onTap: () {
                setState(() => _who = s);
                _focus.requestFocus();
              }),
          ],
        ),
      ],
    );
  }

  Widget _pinStep(AppLocalizations l10n) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(_who!.name, style: AppText.formTitle, textAlign: TextAlign.center),
        const SizedBox(height: 6),
        Text(l10n.enterPin, style: AppText.label),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (var i = 0; i < _pinLength; i++)
              Container(
                key: Key('pin-dot-$i'),
                width: 16,
                height: 16,
                margin: const EdgeInsetsDirectional.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: i < _typed.length ? AppColors.running : Colors.transparent,
                  border: Border.all(color: AppColors.raised, width: 1.5),
                ),
              ),
          ],
        ),
        SizedBox(
          height: 32,
          child: Center(
            child: _wrong
                ? Text(
                    _lockedFor == null ? l10n.wrongPin : l10n.pinLockedOut(playedText(l10n, _lockedFor!)),
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: AppColors.waitingPayment),
                  )
                : null,
          ),
        ),
        // Number pad: 1-9, then a gap, 0, and delete. Always left to right like every phone keypad,
        // even in Arabic (Directionality stops the right-to-left mirroring for the pad only).
        for (final row in const [
          ['1', '2', '3'],
          ['4', '5', '6'],
          ['7', '8', '9'],
          ['', '0', '<'],
        ])
          Padding(
            padding: const EdgeInsetsDirectional.only(bottom: 10),
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (final k in row)
                    Padding(
                      padding: const EdgeInsetsDirectional.symmetric(horizontal: 5),
                      child: SizedBox(
                        width: 84,
                        height: 60,
                        child: k.isEmpty
                            ? null
                            : FilledButton.tonal(
                                key: Key('pin-key-$k'),
                                onPressed: () => k == '<' ? _backspace() : _digit(k),
                                style: FilledButton.styleFrom(minimumSize: const Size(0, 60)),
                                child: k == '<'
                                    ? const Icon(Icons.backspace_outlined)
                                    : Text(k, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600)),
                              ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        TextButton(
          onPressed: () => setState(() {
            _who = null;
            _typed = '';
            _wrong = false;
          }),
          child: Text(l10n.notYou),
        ),
      ],
    );
  }
}
