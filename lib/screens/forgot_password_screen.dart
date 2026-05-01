import 'package:flutter/material.dart';
import 'package:medivault/data/database_helper.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final emailController = TextEditingController();

  String? recoveredPassword;

  Future<void> recoverPassword() async {
    final email = emailController.text.trim();

    if (email.isEmpty) return;

    final user = await DatabaseHelper.instance.getUserByEmail(email);

    if (user != null) {
      setState(() {
        recoveredPassword = user['password'];
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("User not found")),
      );
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Forgot Password")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: "Enter registered email",
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: recoverPassword,
              child: const Text("Recover Password"),
            ),

            const SizedBox(height: 20),

            if (recoveredPassword != null)
              Text(
                "Your Password: $recoveredPassword",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
          ],
        ),
      ),
    );
  }
}