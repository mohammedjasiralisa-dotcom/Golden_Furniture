import 'package:flutter/material.dart';
import 'strings.dart';
import 'language.dart';

class CustomerDetailsScreen extends StatefulWidget {
  final Map<String, String> customer;

  const CustomerDetailsScreen({
    super.key,
    required this.customer,
  });

  @override
  State<CustomerDetailsScreen> createState() => _CustomerDetailsScreenState();
}

class _CustomerDetailsScreenState extends State<CustomerDetailsScreen> {
  final List<Map<String, String>> transactions = [];

  Future<void> _addAmount() async {
    final TextEditingController amountController = TextEditingController();
    
    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header with back button
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => Navigator.pop(context, false),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      iconSize: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      Strings.get('add_collection_amount', globalLanguageCode),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                
                // Enter Amount label
                Text(
                  Strings.get('enter_amount_label', globalLanguageCode),
                  style: const TextStyle(fontSize: 15),
                ),
                const SizedBox(height: 12),
                
                // Amount input field
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xFF6A5AE0),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextField(
                    controller: amountController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 14,
                      ),
                      border: InputBorder.none,
                      hintText: 'Amount',
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                
                // Confirm Collection button
                ElevatedButton.icon(
                  onPressed: () => Navigator.pop(context, true),
                  icon: const Icon(Icons.check_circle_outline),
                  label: Text(Strings.get('confirm_collection', globalLanguageCode)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6A5AE0),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    if (confirmed == true && amountController.text.isNotEmpty) {
      // parse numbers safely
      final num entered = num.tryParse(amountController.text.trim()) ?? 0;
      final num prevBalance = num.tryParse(widget.customer['balance'] ?? '0') ?? 0;
      final num newBalance = prevBalance - entered;

      setState(() {
        // update the shared customer map so parent list sees new balance
        widget.customer['balance'] = newBalance.toString();

        transactions.add({
          'date': DateTime.now().toString().split(' ')[0],
          'paid': entered.toString(),
          'actual': prevBalance.toString(),
          'balance': newBalance.toString(),
        });
      });
    }
  }

  Future<void> _sendReport() async {
    // TODO: Implement report sending
  }

  Future<void> _sendReminder() async {
    // TODO: Implement reminder sending
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            const CircleAvatar(
              backgroundColor: Color.fromRGBO(200, 200, 200, 0.3),
              child: Icon(Icons.person_outline, color: Colors.black54),
            ),
            const SizedBox(width: 12),
            Text(
              widget.customer['name'] ?? 'Customer',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.phone),
            onPressed: () {
              // TODO: Launch phone call
            },
          ),
        ],
        backgroundColor: const Color.fromARGB(241, 7, 116, 241),
        foregroundColor: const Color.fromARGB(221, 249, 247, 247),
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(235, 235, 235, 0.95),
              Color.fromRGBO(245, 245, 245, 0.97),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Balance amount section
            Container(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    Strings.get('balance_amount', globalLanguageCode),
                    style: const TextStyle(fontSize: 15),
                  ),
                  Text(
                    '${Strings.get('rupee', globalLanguageCode)} ${widget.customer['balance'] ?? '0'}',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            // Action buttons
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          Strings.get('sent_collection_reminder', globalLanguageCode),
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                      TextButton.icon(
                        onPressed: _sendReminder,
                        icon: const Icon(Icons.send, size: 18),
                        label: Text(Strings.get('send', globalLanguageCode)),
                        style: TextButton.styleFrom(
                          backgroundColor: const Color(0xFF6A5AE0),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          Strings.get('send_report', globalLanguageCode),
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                      TextButton.icon(
                        onPressed: _sendReport,
                        icon: const Icon(Icons.send, size: 18),
                        label: Text(Strings.get('send', globalLanguageCode)),
                        style: TextButton.styleFrom(
                          backgroundColor: const Color(0xFF6A5AE0),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Customer Report label
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
              child: Text(
                Strings.get('customer_report', globalLanguageCode),
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),
            ),

            // Transactions table
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Table(
                    border: TableBorder.all(
                      color: Colors.grey.shade300,
                      width: 1,
                    ),
                    columnWidths: const {
                      0: FlexColumnWidth(2.5), // Date
                      1: FlexColumnWidth(2), // Amount Paid
                      2: FlexColumnWidth(2), // Actual Amount
                      3: FlexColumnWidth(2), // Balance
                    },
                    children: [
                      // Header row
                      TableRow(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                        ),
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              Strings.get('date', globalLanguageCode),
                              style: const TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              Strings.get('amount_paid', globalLanguageCode),
                              style: const TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              Strings.get('actual_amount', globalLanguageCode),
                              style: const TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              Strings.get('balance', globalLanguageCode),
                              style: const TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                      // Transaction rows
                      ...transactions.map((t) => TableRow(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(t['date'] ?? ''),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(t['paid'] ?? ''),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(t['actual'] ?? ''),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(t['balance'] ?? ''),
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addAmount,
        icon: const Icon(Icons.add),
        label: Text(Strings.get('add_amount', globalLanguageCode)),
        backgroundColor: const Color(0xFF6A5AE0),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}