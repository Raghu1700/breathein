import 'package:flutter/material.dart';
import '../services/emergency_service.dart';

class EmergencyContactsScreen extends StatefulWidget {
  const EmergencyContactsScreen({super.key});

  @override
  State<EmergencyContactsScreen> createState() => _EmergencyContactsScreenState();
}

class _EmergencyContactsScreenState extends State<EmergencyContactsScreen> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  List<Map<String, String>> _contacts = [];

  @override
  void initState() {
    super.initState();
    _loadContacts();
  }

  Future<void> _loadContacts() async {
    final contacts = await EmergencyService.getContacts();
    setState(() {
      _contacts = contacts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emergency Contacts'),
      ),
      body: ListView.builder(
        itemCount: _contacts.length,
        itemBuilder: (context, index) {
          final contact = _contacts[index];
          return ListTile(
            title: Text(contact['name'] ?? ''),
            subtitle: Text(contact['phone'] ?? ''),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => _deleteContact(index),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddContactDialog,
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _showAddContactDialog() async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Emergency Contact'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
              ),
            ),
            TextField(
              controller: _phoneController,
              decoration: const InputDecoration(
                labelText: 'Phone Number',
              ),
              keyboardType: TextInputType.phone,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              _addContact();
              Navigator.pop(context);
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  Future<void> _addContact() async {
    if (_nameController.text.isEmpty || _phoneController.text.isEmpty) {
      return;
    }

    try {
      await EmergencyService.addContact(
        _nameController.text,
        _phoneController.text,
      );
      _nameController.clear();
      _phoneController.clear();
      await _loadContacts();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }
  }

  Future<void> _deleteContact(int index) async {
    try {
      await EmergencyService.removeContact(index);
      await _loadContacts();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }
  }
}
