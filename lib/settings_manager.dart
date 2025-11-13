import 'package:shared_preferences/shared_preferences.dart';

class SettingsManager {
  static const String _businessNameKey = 'business_name';
  static const String _ownerNameKey = 'owner_name';
  static const String _phoneNumberKey = 'phone_number';
  static const String _emailKey = 'email';
  static const String _gstNumberKey = 'gst_number';
  static const String _businessAddressKey = 'business_address';
  static const String _currencyKey = 'currency';

  // Default values
  static const String defaultBusinessName = 'Golden Furniture';
  static const String defaultOwnerName = 'Business Owner';
  static const String defaultPhoneNumber = '+91 9876543210';
  static const String defaultEmail = 'business@example.com';
  static const String defaultGstNumber = '27AABCU9603R1Z0';
  static const String defaultBusinessAddress = 'Chennai, Tamil Nadu';
  static const String defaultCurrency = 'INR';

  // Save individual settings
  static Future<void> saveBusinessName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_businessNameKey, name);
  }

  static Future<void> saveOwnerName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_ownerNameKey, name);
  }

  static Future<void> savePhoneNumber(String phone) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_phoneNumberKey, phone);
  }

  static Future<void> saveEmail(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_emailKey, email);
  }

  static Future<void> saveGstNumber(String gst) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_gstNumberKey, gst);
  }

  static Future<void> saveBusinessAddress(String address) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_businessAddressKey, address);
  }

  static Future<void> saveCurrency(String currency) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_currencyKey, currency);
  }

  // Save all settings at once
  static Future<void> saveAllSettings({
    required String businessName,
    required String ownerName,
    required String phoneNumber,
    required String email,
    required String gstNumber,
    required String businessAddress,
    required String currency,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await Future.wait([
      prefs.setString(_businessNameKey, businessName),
      prefs.setString(_ownerNameKey, ownerName),
      prefs.setString(_phoneNumberKey, phoneNumber),
      prefs.setString(_emailKey, email),
      prefs.setString(_gstNumberKey, gstNumber),
      prefs.setString(_businessAddressKey, businessAddress),
      prefs.setString(_currencyKey, currency),
    ]);
  }

  // Get individual settings with fallback to defaults
  static Future<String> getBusinessName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_businessNameKey) ?? defaultBusinessName;
  }

  static Future<String> getOwnerName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_ownerNameKey) ?? defaultOwnerName;
  }

  static Future<String> getPhoneNumber() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_phoneNumberKey) ?? defaultPhoneNumber;
  }

  static Future<String> getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_emailKey) ?? defaultEmail;
  }

  static Future<String> getGstNumber() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_gstNumberKey) ?? defaultGstNumber;
  }

  static Future<String> getBusinessAddress() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_businessAddressKey) ?? defaultBusinessAddress;
  }

  static Future<String> getCurrency() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_currencyKey) ?? defaultCurrency;
  }

  // Get all settings as a map
  static Future<Map<String, String>> getAllSettings() async {
    return {
      'businessName': await getBusinessName(),
      'ownerName': await getOwnerName(),
      'phoneNumber': await getPhoneNumber(),
      'email': await getEmail(),
      'gstNumber': await getGstNumber(),
      'businessAddress': await getBusinessAddress(),
      'currency': await getCurrency(),
    };
  }
}
