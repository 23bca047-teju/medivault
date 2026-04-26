import 'package:flutter/material.dart';
import 'package:medivault/data/database_helper.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRScreen extends StatefulWidget {
  const QRScreen({super.key});

  @override
  State<QRScreen> createState() => _QRScreenState();
}

class _QRScreenState extends State<QRScreen> {
  String qrData = "";
  Map<String, dynamic>? profile;

  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  Future<void> loadProfile() async {
    final p = await DatabaseHelper.instance.getProfile();

    if (p == null) return;

    setState(() {
      profile = p;

      // SIMPLE SINGLE LINE FORMAT (as you want)
      qrData =
          "Name:${p['name']}, "
          "Age:${p['age']}, "
          "Blood:${p['bloodGroup']}, "
          "Allergies:${p['allergies']}, "
          "Disease:${p['disease']}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Emergency QR Code")),
      body: Center(
        child: qrData.isEmpty
            ? const Text("No Profile Data Available")
            : Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    // QR CARD (kept your design)
                    Card(
                      elevation: 6,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: QrImageView(
                          data: qrData,
                          version: QrVersions.auto,
                          size: 220,
                        ),
                      ),
                    ),

                    const SizedBox(height: 25),

                    const Text(
                      "Scan in emergency to access patient details",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),

                    const SizedBox(height: 20),

                    // SUMMARY CARD (kept, but cleaner)
                    if (profile != null)
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            children: [
                              Text("Name: ${profile!['name']}"),
                              Text("Blood Group: ${profile!['bloodGroup']}"),
                              Text("Disease: ${profile!['disease']}"),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
      ),
    );
  }
}