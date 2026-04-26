import 'package:flutter/material.dart';
import 'package:medivault/data/disease_data.dart';
import 'missing_docs_screen.dart'; 
import 'package:medivault/data/user_profile.dart';

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
  final _conditionsController = TextEditingController();

  final List<String> _bloodGroups = [
    'A+','A-','B+','B-','AB+','AB-','O+','O-'
  ];

  String? _selectedBloodGroup;



  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _allergiesController.dispose();
    _conditionsController.dispose();
    super.dispose();
  }

  String? _validateRequired(String? value, String label) {
    if ((value ?? '').trim().isEmpty) {
      return '$label is required';
    }
    return null;
  }

  String? _validateAge(String? value) {
    final age = int.tryParse(value ?? '');
    if (age == null || age <= 0) return 'Enter valid age';
    return null;
  }

  void _saveProfile() {
    if (!_formKey.currentState!.validate()) return;

    FocusScope.of(context).unfocus();

    String disease = _conditionsController.text.trim();

    //  SAVE PROFILE
    UserProfile.saveProfile({
      'name': _nameController.text,
      'age': _ageController.text,
      'blood': _selectedBloodGroup,
      'allergies': _allergiesController.text,
      'disease': disease,
    });

    //  Navigate to Missing Docs
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MissingDocsScreen(
          disease: disease,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [

              TextFormField(
                controller: _nameController,
                validator: (v) => _validateRequired(v, 'Name'),
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 12),

              TextFormField(
                controller: _ageController,
                keyboardType: TextInputType.number,
                validator: _validateAge,
                decoration: const InputDecoration(
                  labelText: 'Age',
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 12),

              DropdownButtonFormField<String>(
                value: _selectedBloodGroup,
                items: _bloodGroups
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        ))
                    .toList(),
                onChanged: (v) =>
                    setState(() => _selectedBloodGroup = v),
                validator: (v) =>
                    v == null ? 'Select blood group' : null,
                decoration: const InputDecoration(
                  labelText: 'Blood Group',
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 12),

              TextFormField(
                controller: _allergiesController,
                decoration: const InputDecoration(
                  labelText: 'Allergies',
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 12),

              TextFormField(
                controller: _conditionsController,
                validator: (v) => _validateRequired(v, 'Disease'),
                decoration: const InputDecoration(
                  labelText: 'Disease (e.g. Diabetes)',
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _saveProfile,
                  child: const Text('Analyze'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}