import 'package:flutter/material.dart';

class UploadDocumentsScreen extends StatefulWidget {
  const UploadDocumentsScreen({super.key});

  // ✅ GLOBAL LIST (used everywhere)
  static List<String> uploadedDocs = [];

  @override
  State<UploadDocumentsScreen> createState() =>
      _UploadDocumentsScreenState();
}

class _UploadDocumentsScreenState
    extends State<UploadDocumentsScreen> {

  final TextEditingController _docController =
      TextEditingController();

  void _addDocument() {
    String doc = _docController.text.trim();

    if (doc.isEmpty) return;

    setState(() {
      UploadDocumentsScreen.uploadedDocs.add(doc);
    });

    _docController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Upload Documents")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            TextField(
              controller: _docController,
              decoration: const InputDecoration(
                labelText: "Enter document name",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: _addDocument,
              child: const Text("Add Document"),
            ),

            const SizedBox(height: 20),

            const Text(
              "Uploaded Documents",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            Expanded(
              child: ListView(
                children: UploadDocumentsScreen.uploadedDocs
                    .map((doc) => ListTile(
                          title: Text(doc),
                        ))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}