import '../data/activity_log.dart';
import '../data/cancel_session.dart';
import '../data/correct_reason.dart';
import '../data/money.dart';
import '../l10n/l10n.dart';

/// The sentence for a log line, in the app's language. An unknown kind (from a newer version) shows its name.
String describeActivity(AppLocalizations l10n, ActivityEntry e) {
  String money(String key) => l10n.amountEgp(formatMoney(e.number(key) ?? 0));
  final name = e.text('name') ?? '';
  final unit = e.text('unit') ?? '';
  return switch (e.kind) {
    ActivityKind.cashBoxClosed => l10n.activityCashClosed(money('counted'), money('expected')),
    ActivityKind.cashWithdrawal => l10n.activityCashWithdrawal(money('amount')),
    ActivityKind.sessionZeroCost => l10n.activityZeroCost(unit),
    ActivityKind.discountGiven => l10n.activityDiscount(money('amount'), unit),
    ActivityKind.sessionCancelled => l10n.activitySessionCancelled(unit, money('amount'), cancelReasonText(l10n, e.text('reason'))),
    ActivityKind.billCorrected => l10n.activityBillCorrected(unit.isEmpty ? l10n.navQuickSale : unit, money('old'), money('new'), correctReasonText(l10n, e.text('reason'))),
    ActivityKind.paymentAccountChanged => l10n.activityPaymentChanged(_methodName(l10n, e.text('method'))),
    ActivityKind.paymentAccountRemoved => l10n.activityPaymentRemoved(_methodName(l10n, e.text('method'))),
    ActivityKind.pinLockedOut => l10n.activityPinLocked(name),
    ActivityKind.staffAdded => l10n.activityStaffAdded(name),
    ActivityKind.staffStopped => l10n.activityStaffStopped(name),
    ActivityKind.staffPinReset => l10n.activityPinReset(name),
    ActivityKind.staffRoleChanged => l10n.activityRoleChanged(name),
    _ => e.kind,
  };
}

/// The words for a cancel reason. An unknown one (from a newer version) shows as "other".
String cancelReasonText(AppLocalizations l10n, String? reason) => switch (reason) {
      CancelReason.mistake => l10n.cancelReasonMistake,
      CancelReason.customerLeft => l10n.cancelReasonLeft,
      CancelReason.deviceProblem => l10n.cancelReasonDevice,
      _ => l10n.cancelReasonOther,
    };

/// The words for a correction reason. An unknown one (from a newer version) shows as "other".
String correctReasonText(AppLocalizations l10n, String? reason) => switch (reason) {
      CorrectReason.wrongTime => l10n.correctReasonTime,
      CorrectReason.wrongOrder => l10n.correctReasonOrder,
      CorrectReason.agreedDiscount => l10n.correctReasonAgreed,
      _ => l10n.correctReasonOther,
    };

String _methodName(AppLocalizations l10n, String? method) => method == 'wallet' ? l10n.payWallet : l10n.payInstapay;
