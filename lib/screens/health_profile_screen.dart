import 'package:flutter/material.dart';

class HealthProfileScreen extends StatefulWidget {
  const HealthProfileScreen({super.key});

  @override
  State<HealthProfileScreen> createState() => _HealthProfileScreenState();
}

class _HealthProfileScreenState extends State<HealthProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _allergiesController = TextEditingController();
  final _conditionsController = TextEditingController();

  final List<String> _bloodGroups = const [
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
    final ageText = (value ?? '').trim();
    if (ageText.isEmpty) return 'Age is required';

    final age = int.tryParse(ageText);
    if (age == null) return 'Enter valid age';
    if (age <= 0 || age > 120) return 'Enter age 1–120';

    return null;
  }

  Future<void> _saveProfile() async {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    FocusScope.of(context).unfocus();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Health profile saved')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Profile'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Personal Health Details',
                style: theme.textTheme.headlineSmall,
              ),
              const SizedBox(height: 20),

              TextFormField(
                controller: _nameController,
                validator: (v) => _validateRequired(v, 'Name'),
                decoration: _inputDecoration('Name', Icons.person),
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: _ageController,
                keyboardType: TextInputType.number,
                validator: _validateAge,
                decoration: _inputDecoration('Age', Icons.cake),
              ),

              const SizedBox(height: 16),

              DropdownButtonFormField<String>(
                value: _selectedBloodGroup,
                items: _bloodGroups
                    .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                    .toList(),
                onChanged: (v) => setState(() => _selectedBloodGroup = v),
                validator: (v) => v == null ? 'Select blood group' : null,
                decoration: _inputDecoration('Blood Group', Icons.bloodtype),
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: _allergiesController,
                maxLines: 2,
                validator: (v) => _validateRequired(v, 'Allergies'),
                decoration: _inputDecoration('Allergies', Icons.warning),
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: _conditionsController,
                maxLines: 2,
                validator: (v) => _validateRequired(v, 'Conditions'),
                decoration: _inputDecoration('Medical Conditions', Icons.medical_information),
              ),

              const SizedBox(height: 24),

              SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: _saveProfile,
                  child: const Text('Save'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}