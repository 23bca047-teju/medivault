import 'package:flutter/material.dart';
import 'package:medivault/data/disease_data.dart';
import 'upload_documents_screen.dart';

class MissingDocsScreen extends StatelessWidget {
  final String disease;

  const MissingDocsScreen({
    super.key,
    required this.disease,
  });

  @override
  Widget build(BuildContext context) {
    final requiredDocs =
        DiseaseData.diseaseDocs[disease] ??
        DiseaseData.diseaseDocs['General']!;

    // TEMP uploaded docs (later we connect real data)
    final uploadedDocs = UploadDocumentsScreen.uploadedDocs;

    final missingDocs = requiredDocs
        .where((doc) => !uploadedDocs.contains(doc))
        .toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Missing Documents')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Disease: $disease"),
            const SizedBox(height: 10),

            const Text(
              "Missing Documents:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),

            if (missingDocs.isEmpty)
              const Text("All documents uploaded ✅")
            else
              ...missingDocs.map((e) => Text("• $e")),
          ],
        ),
      ),
    );
  }
}