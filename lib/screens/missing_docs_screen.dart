import 'package:flutter/material.dart';
import 'package:medivault/data/disease_data.dart';

class MissingDocsScreen extends StatelessWidget {
  final String disease;
  final List<String> uploadedDocs;

  const MissingDocsScreen({
    super.key,
    required this.disease,
    required this.uploadedDocs,
  });

  @override
  Widget build(BuildContext context) {
    final requiredDocs =
        DiseaseData.diseaseDocs[disease] ??
        DiseaseData.diseaseDocs["General"]!;

    final missingDocs = requiredDocs
        .where((doc) => !uploadedDocs.contains(doc))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Missing Documents"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Disease: $disease",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "Required Documents Check:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            if (missingDocs.isEmpty)
              const Text("All documents uploaded ✔")
            else
              ...missingDocs.map(
                (e) => ListTile(
                  leading: const Icon(Icons.warning, color: Colors.red),
                  title: Text(e),
                ),
              ),
          ],
        ),
      ),
    );
  }
}