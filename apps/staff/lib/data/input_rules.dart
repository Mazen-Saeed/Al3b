/// An Egyptian mobile number: 11 digits, 010 / 011 / 012 / 015.
bool isEgyptianMobile(String phone) => RegExp(r'^01[0125]\d{8}$').hasMatch(phone);

/// A PIN is exactly 4 digits.
bool isValidPin(String pin) => RegExp(r'^\d{4}$').hasMatch(pin);
