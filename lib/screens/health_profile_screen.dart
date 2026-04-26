import 'package:flutter/material.dart';
import 'package:medivault/data/database_helper.dart';

class HealthProfileScreen extends StatefulWidget {
  const HealthProfileScreen({super.key});

  @override
  State<HealthProfileScreen> createState() =>
      _HealthProfileScreenState();
}

class _HealthProfileScreenState extends State<HealthProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _allergiesController = TextEditingController();
  final _diseaseController = TextEditingController();

  String? _bloodGroup;

  final List<String> bloodGroups = [
    "A+","A-","B+","B-","O+","O-","AB+","AB-"
  ];

  Future<void> _saveProfile() async {
    print("SAVE BUTTON PRESSED");

    if (!_formKey.currentState!.validate()) return;

    await DatabaseHelper.instance.insertProfile({
      'name': _nameController.text.trim(),
      'age': _ageController.text.trim(),
      'bloodGroup': _bloodGroup ?? '',
      'allergies': _allergiesController.text.trim(),
      'disease': _diseaseController.text.trim(),
    });

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Profile saved")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Health Profile")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [

              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: "Name"),
                validator: (v) => v!.isEmpty ? "Required" : null,
              ),

              TextFormField(
                controller: _ageController,
                decoration: const InputDecoration(labelText: "Age"),
                validator: (v) => v!.isEmpty ? "Required" : null,
              ),

              DropdownButtonFormField<String>(
                value: _bloodGroup,
                items: bloodGroups
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        ))
                    .toList(),
                onChanged: (v) => setState(() => _bloodGroup = v),
                decoration: const InputDecoration(labelText: "Blood Group"),
              ),

              TextFormField(
                controller: _allergiesController,
                decoration: const InputDecoration(labelText: "Allergies"),
              ),

              TextFormField(
                controller: _diseaseController,
                decoration: const InputDecoration(labelText: "Disease"),
                validator: (v) => v!.isEmpty ? "Required" : null,
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: _saveProfile,
                child: const Text("Save Profile"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}