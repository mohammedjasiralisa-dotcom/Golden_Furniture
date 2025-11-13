import 'package:flutter/material.dart';
import 'strings.dart';
import 'language.dart';
import 'app_settings.dart';
import 'pdf_generator.dart';
import 'settings_manager.dart';

class SidebarMenu extends StatelessWidget {
  final VoidCallback onLogout;
  final List<Map<String, String>> customers;

  const SidebarMenu({
    super.key,
    required this.onLogout,
    required this.customers,
  });

  void _showLogoutConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: Text(Strings.get('confirm_logout', globalLanguageCode)),
          content: Text(Strings.get('logout_message', globalLanguageCode)),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            Container(
              decoration: BoxDecoration(
                color: const Color.fromRGBO(220, 53, 69, 1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  onLogout();
                },
                child: Text(
                  Strings.get('logout', globalLanguageCode),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _generateCustomerPDF(BuildContext context) async {
    // If there are no customers, show localized message and do nothing
    if (customers.isEmpty) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(Strings.get('no_customers_found', globalLanguageCode)),
            backgroundColor: const Color.fromRGBO(255, 193, 7, 1),
            duration: const Duration(seconds: 2),
          ),
        );
      }
      return;
    }

    try {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(Strings.get('generating_pdf', globalLanguageCode)),
            duration: const Duration(seconds: 2),
          ),
        );
      }

      // Fetch saved settings
      final businessName = await SettingsManager.getBusinessName();
      final businessAddress = await SettingsManager.getBusinessAddress();
      final gstNumber = await SettingsManager.getGstNumber();

      final pdfPath = await PDFGenerator.generateCustomerListPDF(
        customers,
        businessName,
        businessAddress,
        gstNumber,
      );

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${Strings.get('pdf_saved', globalLanguageCode)} $pdfPath'),
            backgroundColor: const Color.fromRGBO(76, 175, 80, 1),
            duration: const Duration(seconds: 4),
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${Strings.get('error_generating_pdf', globalLanguageCode)}: $e'),
            backgroundColor: const Color.fromRGBO(220, 53, 69, 1),
            duration: const Duration(seconds: 4),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final menuItems = [
      {'icon': Icons.lock_outline, 'label': 'account_privacy'},
      {'icon': Icons.people_outline, 'label': 'staff'},
      {'icon': Icons.inventory_2_outlined, 'label': 'manage_stocks'},
      {'icon': Icons.construction_outlined, 'label': 'service_product'},
      {'icon': Icons.settings_outlined, 'label': 'settings'},
      {'icon': Icons.picture_as_pdf_outlined, 'label': 'customer_details_pdf'},
      {'icon': Icons.info_outline, 'label': 'about_us'},
    ];

    return Drawer(
      child: Container(
        color: const Color.fromRGBO(240, 242, 247, 1),
        child: Column(
          children: [
            // Header with back button
            Container(
              padding: const EdgeInsets.only(top: 40, left: 16, right: 16, bottom: 20),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, size: 28),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            // Menu items
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: menuItems.length,
                itemBuilder: (context, index) {
                  final item = menuItems[index];
                  final label = item['label'] as String;
                  final icon = item['icon'] as IconData;

                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: ListTile(
                      leading: Icon(
                        icon,
                        size: 24,
                        color: const Color.fromRGBO(106, 90, 224, 1),
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            Strings.get(label, globalLanguageCode),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                            ),
                          ),
                          if (label != 'account_privacy' && label != 'staff') ...[
                            const SizedBox(height: 4),
                            Text(
                              Strings.get('menu_description', globalLanguageCode),
                              style: const TextStyle(
                                fontSize: 12,
                                color: Color.fromRGBO(128, 128, 128, 1),
                              ),
                            ),
                          ],
                        ],
                      ),
                      contentPadding: EdgeInsets.zero,
                      onTap: () {
                        Navigator.pop(context);
                        // Handle menu item navigation
                        if (label == 'settings') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AppSettingsScreen(),
                            ),
                          );
                        } else if (label == 'customer_details_pdf') {
                          _generateCustomerPDF(context);
                        }
                        // TODO: Implement navigation for other menu items
                      },
                    ),
                  );
                },
              ),
            ),
            // Logout button at bottom
            Container(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 40, top: 16),
              child: Row(
                children: [
                  Icon(
                    Icons.logout_outlined,
                    size: 24,
                    color: const Color.fromRGBO(128, 128, 128, 1),
                  ),
                  const SizedBox(width: 16),
                  TextButton(
                    onPressed: () => _showLogoutConfirmation(context),
                    child: Text(
                      Strings.get('logout', globalLanguageCode),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(128, 128, 128, 1),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
