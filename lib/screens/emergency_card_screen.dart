import 'package:flutter/material.dart';

class EmergencyCardScreen extends StatelessWidget {
  const EmergencyCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 🔹 SAMPLE DATA (later DB)
    String name = "Tejaswini";
    String bloodGroup = "O+";
    String allergies = "None";
    String condition = "BP Patient";
    String contact = "9876543210";

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
                _info("Blood Group", bloodGroup),
                _info("Allergies", allergies),
                _info("Condition", condition),
                _info("Emergency Contact", contact),
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