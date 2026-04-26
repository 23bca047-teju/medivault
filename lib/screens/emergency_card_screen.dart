import 'package:flutter/material.dart';
import 'package:medivault/data/user_profile.dart';

class EmergencyCardScreen extends StatelessWidget {
  const EmergencyCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = UserProfile.getProfile();

    final name = profile?['name'] ?? 'Not set';
    final age = profile?['age'] ?? 'Not set';
    final blood = profile?['blood'] ?? 'Not set';
    final allergies = profile?['allergies'] ?? 'None';
    final condition = profile?['disease'] ?? 'Not set';

    return Scaffold(
      appBar: AppBar(
        title: const Text("Emergency Card"),
        backgroundColor: const Color(0xFF0F172A),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.all(20),
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Emergency Details",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Divider(),

                _info("Name", name),
                _info("Age", age.toString()),
                _info("Blood Group", blood),
                _info("Allergies", allergies),
                _info("Condition", condition),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _info(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Text(
            "$label: ",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}