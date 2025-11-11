class Strings {
  static const Map<String, Map<String, String>> translations = {
    'en': {
      // MyBusinessScreen
      'my_business': 'My Business',
      'add_customer': 'Add Customer',
      'no_customers_yet': 'No customers yet',
      'add_customers_to_see': 'Add customers to see them here',

      // CoustumerScreen (Add Customer Form)
      'add_customer_form': 'Add Customer',
      'product_amount': 'Product Amount',
      'name': 'Name',
      'mobile_no': 'Mobile No',
      'product': 'Product',
      'address': 'Address',
      'submit': 'Submit',
      'enter_amount': 'Enter amount',
      'enter_name': 'Enter name',
      'enter_mobile_number': 'Enter mobile number',
      'value': 'Value',

      // ContactsListScreen
      'contacts': 'Contacts',

      // CustomerDetailsScreen
      'balance_amount': 'Balance Amount',
      'rupee': 'Rupee',
      'sent_collection_reminder': 'Sent Collection Reminder',
      'send_report': 'Send Report',
      'send': 'Send',
      'customer_report': 'Customer Report',
      'date': 'Date',
      'amount_paid': 'Amount\nPaid',
      'actual_amount': 'Actual\nAmount',
      'balance': 'Balance',
      'add_amount': 'Add Amount',
      'add_collection_amount': 'Add Collection Amount',
      'enter_amount_label': 'Enter Amount',
      'confirm_collection': 'Confirm Collection',
    },
    'ta': {
      // MyBusinessScreen
      'my_business': 'என் வணிகம்',
      'add_customer': 'வாடிக்கையாளரைச் சேர்க்கவும்',
      'no_customers_yet': 'இதுவரை வாடிக்கையாளர் இல்லை',
      'add_customers_to_see': 'இங்கு பார்க்க வாடிக்கையாளர்களைச் சேர்க்கவும்',

      // CoustumerScreen (Add Customer Form)
      'add_customer_form': 'வாடிக்கையாளரைச் சேர்க்கவும்',
      'product_amount': 'பொருளின் அளவு',
      'name': 'பெயர்',
      'mobile_no': 'மொபைல் இலக்கம்',
      'product': 'பொருள்',
      'address': 'முகவரி',
      'submit': 'சமர்ப்பிக்கவும்',
      'enter_amount': 'தொகையை உள்ளிடவும்',
      'enter_name': 'பெயரை உள்ளிடவும்',
      'enter_mobile_number': 'மொபைல் இலக்கத்தை உள்ளிடவும்',
      'value': 'மதிப்பு',

      // ContactsListScreen
      'contacts': 'தொடர்புகள்',

      // CustomerDetailsScreen
      'balance_amount': 'இருப்பு தொகை',
      'rupee': 'ரூபாய்',
      'sent_collection_reminder': 'சேகரிப்பு நினைவூட்டல் அனுப்பப்பட்டது',
      'send_report': 'அறிக்கை அனுப்பவும்',
      'send': 'அனுப்பவும்',
      'customer_report': 'வாடிக்கையாளர் அறிக்கை',
      'date': 'தேதி',
      'amount_paid': 'செலுத்திய\nதொகை',
      'actual_amount': 'உண்மையான\nதொகை',
      'balance': 'இருப்பு',
      'add_amount': 'தொகை சேர்க்கவும்',
      'add_collection_amount': 'சேகரிப்பு தொகை சேர்க்கவும்',
      'enter_amount_label': 'தொகை உள்ளிடவும்',
      'confirm_collection': 'சேகரிப்பை உறுதிப்படுத்தவும்',
    },
  };

  static String get(String key, String languageCode) {
    return translations[languageCode]?[key] ?? translations['en']![key] ?? key;
  }
}
