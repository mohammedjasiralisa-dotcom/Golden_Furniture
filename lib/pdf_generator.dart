import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'web_utils_stub.dart'
  if (dart.library.html) 'web_utils_web.dart' as web_utils;
import 'package:intl/intl.dart';

class PDFGenerator {
  static Future<String> generateCustomerListPDF(
    List<Map<String, String>> customers,
    String businessName,
    String businessAddress,
    String gstNumber,
  ) async {
    final pdf = pw.Document();

    // Format current date
    final dateFormat = DateFormat('dd-MM-yyyy');
    final currentDate = dateFormat.format(DateTime.now());

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Header
              pw.Container(
                alignment: pw.Alignment.center,
                margin: const pw.EdgeInsets.only(bottom: 20),
                child: pw.Column(
                  children: [
                    pw.Text(
                      businessName,
                      style: pw.TextStyle(
                        fontSize: 24,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.SizedBox(height: 5),
                    pw.Text(
                      'Customer Details Report',
                      style: pw.TextStyle(
                        fontSize: 16,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              // Business Information
              pw.Container(
                margin: const pw.EdgeInsets.only(bottom: 15),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      'Business Information',
                      style: pw.TextStyle(
                        fontSize: 12,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.SizedBox(height: 5),
                    pw.Text('Address: $businessAddress'),
                    pw.Text('GST Number: $gstNumber'),
                    pw.Text('Report Generated: $currentDate'),
                  ],
                ),
              ),

              // Divider
              pw.Divider(thickness: 1),
              pw.SizedBox(height: 10),

              // Customer Details Table
              if (customers.isEmpty)
                pw.Text(
                  'No customers found',
                  style: const pw.TextStyle(fontSize: 12),
                )
              else
                pw.Table(
                  border: pw.TableBorder.all(width: 1),
                  columnWidths: {
                    0: const pw.FlexColumnWidth(0.3),
                    1: const pw.FlexColumnWidth(1.5),
                    2: const pw.FlexColumnWidth(1.5),
                    3: const pw.FlexColumnWidth(1.2),
                  },
                  children: [
                    // Header Row
                    pw.TableRow(
                      decoration: const pw.BoxDecoration(
                        color: PdfColors.grey300,
                      ),
                      children: [
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(5),
                          child: pw.Text(
                            'S.No',
                            style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                          ),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(5),
                          child: pw.Text(
                            'Customer Name',
                            style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                          ),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(5),
                          child: pw.Text(
                            'Address',
                            style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                          ),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(5),
                          child: pw.Text(
                            'Balance (₹)',
                            style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    // Data Rows
                    ...customers.asMap().entries.map((entry) {
                      final index = entry.key + 1;
                      final customer = entry.value;
                      return pw.TableRow(
                        children: [
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(5),
                            child: pw.Text(index.toString()),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(5),
                            child: pw.Text(customer['name'] ?? ''),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(5),
                            child: pw.Text(customer['address'] ?? ''),
                          ),
                          pw.Padding(
                            padding: const pw.EdgeInsets.all(5),
                            child: pw.Text(customer['balance'] ?? '0'),
                          ),
                        ],
                      );
                    }).toList(),
                  ],
                ),

              pw.SizedBox(height: 20),

              // Summary Section
              pw.Container(
                alignment: pw.Alignment.bottomRight,
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      'Summary',
                      style: pw.TextStyle(
                        fontSize: 12,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.SizedBox(height: 5),
                    pw.Text('Total Customers: ${customers.length}'),
                    pw.SizedBox(height: 3),
                    pw.Text(
                      'Total Balance: ₹${_calculateTotalBalance(customers)}',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );

    // Save PDF to file (platform-specific)
    final fileName =
        'Customer_List_${DateFormat('yyyyMMdd_HHmmss').format(DateTime.now())}.pdf';

    if (kIsWeb) {
      // On web, trigger a browser download using the generated bytes
      final bytes = await pdf.save();
      await web_utils.downloadBytes(bytes, fileName);
      return fileName; // return filename for UX feedback
    } else {
      // Mobile / desktop: save to app documents directory
      final output = await getApplicationDocumentsDirectory();
      final file = File('${output.path}/$fileName');
      await file.writeAsBytes(await pdf.save());
      return file.path;
    }
  }

  static String _calculateTotalBalance(List<Map<String, String>> customers) {
    double total = 0;
    for (var customer in customers) {
      final balance = double.tryParse(customer['balance'] ?? '0') ?? 0;
      total += balance;
    }
    return total.toStringAsFixed(2);
  }
}
