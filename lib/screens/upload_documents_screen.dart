import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:medivault/data/database_helper.dart';

class UploadDocumentsScreen extends StatefulWidget {
  const UploadDocumentsScreen({super.key});

  @override
  State<UploadDocumentsScreen> createState() =>
      _UploadDocumentsScreenState();
}

class _UploadDocumentsScreenState extends State<UploadDocumentsScreen> {
  List<Map<String, dynamic>> docs = [];

  @override
  void initState() {
    super.initState();
    loadDocs();
  }

  Future<void> loadDocs() async {
    final data = await DatabaseHelper.instance.getDocuments();
    setState(() {
      docs = data;
    });
  }

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
    );

    if (result == null) return;

    final file = result.files.first;

    final fileName = file.name;
    final filePath = file.path ?? "";

    await DatabaseHelper.instance.insertDocument(fileName, filePath);

    await loadDocs();

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("File uploaded successfully")),
    );
  }

  Future<void> deleteDoc(int id) async {
    await DatabaseHelper.instance.deleteDocument(id);
    await loadDocs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Upload Documents")),
      body: Column(
        children: [
          const SizedBox(height: 20),

          ElevatedButton.icon(
            onPressed: pickFile,
            icon: const Icon(Icons.upload_file),
            label: const Text("Upload File"),
          ),

          const SizedBox(height: 20),

          Expanded(
            child: docs.isEmpty
                ? const Center(child: Text("No documents uploaded"))
                : ListView.builder(
                    itemCount: docs.length,
                    itemBuilder: (context, index) {
                      final doc = docs[index];

                      return Card(
                        child: ListTile(
                          leading: const Icon(Icons.insert_drive_file),
                          title: Text(doc['name'] ?? 'No name'),
                          subtitle: Text(doc['path'] ?? 'No path'),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => deleteDoc(doc['id']),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}