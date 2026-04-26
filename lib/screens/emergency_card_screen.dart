import 'package:flutter/material.dart';
import 'package:medivault/data/database_helper.dart';

class EmergencyScreen extends StatefulWidget {
  const EmergencyScreen({super.key});

  @override
  State<EmergencyScreen> createState() => _EmergencyScreenState();
}

class _EmergencyScreenState extends State<EmergencyScreen> {
  Map<String, dynamic>? profile;

  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  Future<void> loadProfile() async {
    final data = await DatabaseHelper.instance.getProfile();

    setState(() {
      profile = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Emergency Info")),
      body: profile == null
          ? const Center(
              child: Text("No profile found"),
            )
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Emergency Patient Card",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 20),

                      Text("Name: ${profile!['name'] ?? 'N/A'}"),
                      Text("Age: ${profile!['age'] ?? 'N/A'}"),
                      Text("Blood Group: ${profile!['bloodGroup'] ?? 'N/A'}"),
                      Text("Allergies: ${profile!['allergies'] ?? 'N/A'}"),
                      Text("Disease: ${profile!['disease'] ?? 'N/A'}"),

                      const SizedBox(height: 20),

                      const Text(
                        "Use this info in emergency situations.",
                        style: TextStyle(color: Colors.red),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}