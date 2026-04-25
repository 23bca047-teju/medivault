import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRScreen extends StatelessWidget {
  const QRScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // This is the data encoded in QR
    final String qrData =
        "Name: Tejaswini\nBlood: O+\nAllergies: Dust\nCondition: BP\nContact: 9876543210";

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