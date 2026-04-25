import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const MediVaultApp());
}

class MediVaultApp extends StatelessWidget {
  const MediVaultApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MediVault',
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}