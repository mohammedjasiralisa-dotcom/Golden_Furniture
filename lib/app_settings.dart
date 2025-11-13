import 'package:flutter/material.dart';
import 'strings.dart';
import 'language.dart';
import 'settings_manager.dart';

class AppSettingsScreen extends StatefulWidget {
  const AppSettingsScreen({super.key});

  @override
  State<AppSettingsScreen> createState() => _AppSettingsScreenState();
}

class _AppSettingsScreenState extends State<AppSettingsScreen> {
  // Configuration settings
  bool _enableNotifications = true;
  bool _darkMode = false;
  bool _autoBackup = true;
  String _currency = 'INR';
  String _businessName = 'Golden Furniture';
  String _ownerName = 'Business Owner';
  String _phoneNumber = '+91 9876543210';
  String _email = 'business@example.com';
  String _gstNumber = '27AABCU9603R1Z0';
  String _businessAddress = 'Chennai, Tamil Nadu';

  final TextEditingController _businessNameController = TextEditingController();
  final TextEditingController _ownerNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _gstNumberController = TextEditingController();
  final TextEditingController _businessAddressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final businessName = await SettingsManager.getBusinessName();
    final ownerName = await SettingsManager.getOwnerName();
    final phoneNumber = await SettingsManager.getPhoneNumber();
    final email = await SettingsManager.getEmail();
    final gstNumber = await SettingsManager.getGstNumber();
    final businessAddress = await SettingsManager.getBusinessAddress();
    final currency = await SettingsManager.getCurrency();

    setState(() {
      _businessName = businessName;
      _ownerName = ownerName;
      _phoneNumber = phoneNumber;
      _email = email;
      _gstNumber = gstNumber;
      _businessAddress = businessAddress;
      _currency = currency;

      _businessNameController.text = _businessName;
      _ownerNameController.text = _ownerName;
      _phoneNumberController.text = _phoneNumber;
      _emailController.text = _email;
      _gstNumberController.text = _gstNumber;
      _businessAddressController.text = _businessAddress;
    });
  }

  @override
  void dispose() {
    _businessNameController.dispose();
    _ownerNameController.dispose();
    _phoneNumberController.dispose();
    _emailController.dispose();
    _gstNumberController.dispose();
    _businessAddressController.dispose();
    super.dispose();
  }

  void _saveSettings() {
    setState(() {
      _businessName = _businessNameController.text;
      _ownerName = _ownerNameController.text;
      _phoneNumber = _phoneNumberController.text;
      _email = _emailController.text;
      _gstNumber = _gstNumberController.text;
      _businessAddress = _businessAddressController.text;
    });

    // Persist to local storage
    SettingsManager.saveAllSettings(
      businessName: _businessName,
      ownerName: _ownerName,
      phoneNumber: _phoneNumber,
      email: _email,
      gstNumber: _gstNumber,
      businessAddress: _businessAddress,
      currency: _currency,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Settings saved successfully'),
        backgroundColor: const Color.fromRGBO(76, 175, 80, 1),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(Strings.get('settings', globalLanguageCode)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: const Color.fromRGBO(255, 255, 255, 0.9),
        foregroundColor: Colors.black87,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Business Information Section
          _buildSectionHeader('Business Information'),
          const SizedBox(height: 12),
          _buildTextField(
            controller: _businessNameController,
            label: 'Business Name',
            icon: Icons.business,
          ),
          const SizedBox(height: 12),
          _buildTextField(
            controller: _ownerNameController,
            label: 'Owner Name',
            icon: Icons.person,
          ),
          const SizedBox(height: 12),
          _buildTextField(
            controller: _phoneNumberController,
            label: 'Phone Number',
            icon: Icons.phone,
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 12),
          _buildTextField(
            controller: _emailController,
            label: 'Email',
            icon: Icons.email,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 24),

          // Business Details Section
          _buildSectionHeader('Business Details'),
          const SizedBox(height: 12),
          _buildTextField(
            controller: _gstNumberController,
            label: 'GST Number',
            icon: Icons.receipt,
          ),
          const SizedBox(height: 12),
          _buildTextField(
            controller: _businessAddressController,
            label: 'Business Address',
            icon: Icons.location_on,
            maxLines: 3,
          ),
          const SizedBox(height: 24),

          // App Settings Section
          _buildSectionHeader('App Settings'),
          const SizedBox(height: 12),
          _buildToggleSetting(
            title: 'Enable Notifications',
            value: _enableNotifications,
            onChanged: (value) {
              setState(() {
                _enableNotifications = value;
              });
            },
          ),
          const SizedBox(height: 12),
          _buildToggleSetting(
            title: 'Dark Mode',
            value: _darkMode,
            onChanged: (value) {
              setState(() {
                _darkMode = value;
              });
            },
          ),
          const SizedBox(height: 12),
          _buildToggleSetting(
            title: 'Auto Backup',
            value: _autoBackup,
            onChanged: (value) {
              setState(() {
                _autoBackup = value;
              });
            },
          ),
          const SizedBox(height: 24),

          // Currency Settings
          _buildSectionHeader('Currency'),
          const SizedBox(height: 12),
          _buildCurrencyDropdown(),
          const SizedBox(height: 32),

          // Save Button
          ElevatedButton(
            onPressed: _saveSettings,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromRGBO(106, 90, 224, 1),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Save Settings',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 16),

          // App Version
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(240, 242, 247, 1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(
              child: Text(
                'App Version: 1.0.0',
                style: TextStyle(
                  fontSize: 12,
                  color: Color.fromRGBO(128, 128, 128, 1),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromRGBO(245, 245, 245, 1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color.fromRGBO(200, 200, 200, 1),
        ),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          prefixIcon: Icon(icon, color: const Color.fromRGBO(106, 90, 224, 1)),
          labelText: label,
          border: InputBorder.none,
          floatingLabelBehavior: FloatingLabelBehavior.never,
        ),
      ),
    );
  }

  Widget _buildToggleSetting({
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(245, 245, 245, 1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color.fromRGBO(200, 200, 200, 1),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: const Color.fromRGBO(106, 90, 224, 1),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrencyDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(245, 245, 245, 1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color.fromRGBO(200, 200, 200, 1),
        ),
      ),
      child: DropdownButton<String>(
        value: _currency,
        isExpanded: true,
        underline: const SizedBox(),
        items: const [
          DropdownMenuItem(value: 'INR', child: Text('Indian Rupee (INR)')),
          DropdownMenuItem(value: 'USD', child: Text('US Dollar (USD)')),
          DropdownMenuItem(value: 'EUR', child: Text('Euro (EUR)')),
          DropdownMenuItem(value: 'GBP', child: Text('British Pound (GBP)')),
        ],
        onChanged: (value) {
          setState(() {
            _currency = value!;
          });
        },
      ),
    );
  }
}
