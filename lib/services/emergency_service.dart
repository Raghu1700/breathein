import 'package:shared_preferences/shared_preferences.dart';

class EmergencyService {
  static const String _contactsKey = 'emergency_contacts';

  static Future<List<Map<String, String>>> getContacts() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final contactsJson = prefs.getStringList(_contactsKey) ?? [];
      return contactsJson.map((contact) {
        final parts = contact.split('|');
        return {
          'name': parts[0],
          'phone': parts[1],
        };
      }).toList();
    } catch (e) {
      print('Error getting contacts: $e');
      return [];
    }
  }

  static Future<void> addContact(String name, String phone) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final contacts = await getContacts();
      contacts.add({'name': name, 'phone': phone});
      
      final contactsJson = contacts.map((contact) => 
        '${contact['name']}|${contact['phone']}'
      ).toList();
      
      await prefs.setStringList(_contactsKey, contactsJson);
    } catch (e) {
      print('Error adding contact: $e');
    }
  }

  static Future<void> removeContact(int index) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final contacts = await getContacts();
      if (index >= 0 && index < contacts.length) {
        contacts.removeAt(index);
        
        final contactsJson = contacts.map((contact) => 
          '${contact['name']}|${contact['phone']}'
        ).toList();
        
        await prefs.setStringList(_contactsKey, contactsJson);
      }
    } catch (e) {
      print('Error removing contact: $e');
    }
  }

  static Future<void> sendEmergencyAlert(String message) async {
    try {
      final contacts = await getContacts();
      for (final contact in contacts) {
        print('Would send SMS to ${contact['phone']}: $message');
        // TODO: Implement actual SMS sending when needed
      }
    } catch (e) {
      print('Error sending emergency alert: $e');
    }
  }
}
