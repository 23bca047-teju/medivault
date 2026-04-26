import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:medivault/data/user_profile.dart';

class QRScreen extends StatelessWidget {
  const QRScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = UserProfile.getProfile();

    final String qrData = profile == null
        ? "No Data Available"
        : "Name: ${profile['name']}\n"
          "Age: ${profile['age']}\n"
          "Blood: ${profile['blood']}\n"
          "Allergies: ${profile['allergies']}\n"
          "Condition: ${profile['disease']}";

    return Scaffold(
      appBar: AppBar(
        title: const Text('Emergency QR Code'),
        backgroundColor: const Color(0xFF0F172A),
      ),
      body: Center(
        child: Card(
          elevation: 10,
          margin: const EdgeInsets.all(20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Scan in Emergency',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),

                QrImageView(
                  data: qrData,
                  size: 200,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}