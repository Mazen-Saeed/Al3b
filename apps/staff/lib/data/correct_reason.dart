/// Why a paid bill was changed. The text is what the log stores.
class CorrectReason {
  const CorrectReason._();

  static const wrongTime = 'wrong_time';
  static const wrongOrder = 'wrong_order';
  static const agreedDiscount = 'agreed_discount';
  static const other = 'other';

  static const all = [wrongTime, wrongOrder, agreedDiscount, other];
}
