import 'package:flutter/material.dart';
import 'contacts_list.dart';
import 'customer_details.dart';
import 'strings.dart';
import 'language.dart';

class MyBusinessScreen extends StatefulWidget {
  const MyBusinessScreen({super.key});

  @override
  State<MyBusinessScreen> createState() => _MyBusinessScreenState();
}

class _MyBusinessScreenState extends State<MyBusinessScreen> {
  // Start with an empty list: only show customers the user adds
  final List<Map<String, String>> _customers = [];

  Future<void> _addCustomer() async {
    // Open the contacts list; user can pick a contact or tap + to create new
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ContactsListScreen()),
    );

    // If ContactsListScreen returns a Map with customer data, append it to list
    if (result != null && result is Map) {
      // Normalize result to our list item shape. Use 'amount' as initial balance if present.
      final Map<String, String> data = Map<String, String>.from(result.cast<String, String>());
      final String balance = (data['amount'] != null && data['amount']!.isNotEmpty) ? data['amount']! : '0';
      final String name = data['name'] ?? data['mobile'] ?? 'Customer';
      final String address = data['address'] ?? data['product'] ?? '';

      setState(() {
        _customers.insert(0, {
          'name': name,
          'address': address,
          'balance': balance,
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {},
        ),
        title: Text(Strings.get('my_business', globalLanguageCode)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle_outlined),
            onPressed: () {},
          ),
        ],
        elevation: 0,
        backgroundColor: const Color.fromRGBO(255, 255, 255, 0.9),
        foregroundColor: Colors.black87,
      ),
      body: Stack(
        children: [
          // subtle background: keep existing bg image if available, otherwise gradient
          Container(
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: AssetImage('assets/images/bg.jpg'),
                fit: BoxFit.cover,
                opacity: 0.9,
              ),
              gradient: const LinearGradient(
                colors: [
                  Color.fromRGBO(255, 255, 255, 0.6),
                  Color.fromRGBO(96, 125, 139, 0.06)
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          // content: either an empty state or the list of customer cards
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: _customers.isEmpty
                  ? Center(
                      child: _buildEmptyState(),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.only(top: 12, bottom: 96),
                      itemCount: _customers.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 8),
                      itemBuilder: (context, index) {
                        final c = _customers[index];
                        return _buildCustomerListItem(c);
                      },
                    ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SizedBox(
          width: 180,
          height: 48,
          child: FloatingActionButton.extended(
            onPressed: _addCustomer,
            label: Text(Strings.get('add_customer', globalLanguageCode)),
            icon: const Icon(Icons.add),
            backgroundColor: const Color(0xFF6A5AE0), // purple-ish
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          ),
        ),
      ),
    );
  }

  Widget _buildCustomerListItem(Map<String, String> c) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromRGBO(255, 255, 255, 0.92),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: const Color.fromRGBO(0, 0, 0, 0.05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () async {
            // Await so we can refresh UI when details update the customer's map in-place
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CustomerDetailsScreen(customer: c),
              ),
            );
            setState(() {});
          },
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 12.0),
            child: Row(
              children: [
                // Left: name + address
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        c['name'] ?? '',
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        c['address'] ?? '',
                        style: TextStyle(fontSize: 13, color: Colors.grey[700]),
                      ),
                    ],
                  ),
                ),

                // Right: balance aligned to the end
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    c['balance'] ?? '',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          Strings.get('no_customers_yet', globalLanguageCode),
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Text(
          Strings.get('add_customers_to_see', globalLanguageCode),
          style: const TextStyle(color: Colors.black54),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: _addCustomer,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF6A5AE0),
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          ),
          child: Text(Strings.get('add_customer', globalLanguageCode)),
        ),
      ],
    );
  }
}
