import 'package:flutter/material.dart';

class UploadDocumentsScreen extends StatefulWidget {
  const UploadDocumentsScreen({super.key});

  @override
  State<UploadDocumentsScreen> createState() =>
      _UploadDocumentsScreenState();
}

class _UploadDocumentsScreenState
    extends State<UploadDocumentsScreen> {
  final List<String> _documents = [];
  final TextEditingController _docController = TextEditingController();

  void _addDocument() {
    final text = _docController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _documents.add(text);
      _docController.clear();
    });
  }

  void _deleteDocument(int index) {
    setState(() {
      _documents.removeAt(index);
    });
  }

  @override
  void dispose() {
    _docController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Upload Documents"),
        backgroundColor: const Color(0xFF0F172A),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _docController,
              decoration: InputDecoration(
                hintText: "Enter document name (e.g. BP Report)",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: _addDocument,
                ),
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: _documents.isEmpty
                  ? const Center(
                      child: Text("No documents added"),
                    )
                  : ListView.builder(
                      itemCount: _documents.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            title: Text(_documents[index]),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _deleteDocument(index),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}