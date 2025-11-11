import 'package:flutter/material.dart';
import 'coustumer.dart';
import 'strings.dart';
import 'language.dart';

/// Mock contacts list used when device contacts package isn't available.
/// Shows a list of sample contacts. Tapping a contact opens the form with
/// that contact prefilled. The FAB opens an empty form.
class ContactsListScreen extends StatefulWidget {
  const ContactsListScreen({super.key});

  @override
  State<ContactsListScreen> createState() => _ContactsListScreenState();
}

class _ContactsListScreenState extends State<ContactsListScreen> {
  final List<Map<String, String>> _contacts = List.generate(
    20,
    (i) => {
      'name': 'Contact ${i + 1}',
      'phone': '${9000000000 + i}',
    },
  );

  Future<void> _openFormWithContact(Map<String, String> contact) async {
    final result = await Navigator.push<Map?>(
      context,
      MaterialPageRoute(
        builder: (context) => CoustumerScreen(
          initialName: contact['name'],
          initialPhone: contact['phone'],
        ),
      ),
    );

    if (result != null && result is Map) {
      Navigator.pop(context, result);
    }
  }

  Future<void> _openEmptyForm() async {
    final result = await Navigator.push<Map?>(
      context,
      MaterialPageRoute(builder: (context) => const CoustumerScreen()),
    );
    if (result != null && result is Map) Navigator.pop(context, result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.get('contacts', globalLanguageCode)),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openEmptyForm,
        child: const Icon(Icons.add),
      ),
      body: ListView.separated(
        itemCount: _contacts.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final c = _contacts[index];
          final initials = _getInitials(c['name']!);
          return ListTile(
            leading: CircleAvatar(child: Text(initials)),
            title: Text(c['name']!),
            subtitle: Text(c['phone']!),
            trailing: const Icon(Icons.check_box_outline_blank),
            onTap: () => _openFormWithContact(c),
          );
        },
      ),
    );
  }

  String _getInitials(String name) {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty) return '';
    if (parts.length == 1) return parts.first[0].toUpperCase();
    return (parts[0][0] + parts[1][0]).toUpperCase();
  }
}
