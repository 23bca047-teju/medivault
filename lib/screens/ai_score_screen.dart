import 'package:flutter/material.dart';
import 'package:medivault/data/database_helper.dart';
import 'package:medivault/data/disease_data.dart';

class AIScoreScreen extends StatefulWidget {
  const AIScoreScreen({super.key});

  @override
  State<AIScoreScreen> createState() => _AIScoreScreenState();
}

class _AIScoreScreenState extends State<AIScoreScreen> {
  Map<String, dynamic>? profile;
  List<Map<String, dynamic>> documents = [];

  int score = 0;
  List<String> missingDocs = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final p = await DatabaseHelper.instance.getProfile();
    final d = await DatabaseHelper.instance.getDocuments();

    setState(() {
      profile = p;
      documents = d;
      calculateScore();
    });
  }

  void calculateScore() {
    score = 0;
    missingDocs.clear();

    // NO PROFILE
    if (profile == null || profile!.isEmpty) {
      missingDocs.add("Complete Health Profile");
      return;
    }

    String disease = profile!['disease'] ?? "General";

    // SAFETY CHECK
    if (!DiseaseData.diseaseDocs.containsKey(disease)) {
      disease = "General";
    }

    // PROFILE SCORE
    score += 20;

    // REQUIRED DOCS
    List<String> requiredDocs =
        DiseaseData.diseaseDocs[disease] ?? [];

    // TOTAL UPLOADED DOCS
    int uploadedCount = documents.length;

    // MATCHED DOCS
    int matched = uploadedCount;

    // LIMIT MATCH COUNT
    if (matched > requiredDocs.length) {
      matched = requiredDocs.length;
    }

    // FIND MISSING DOCS
    for (int i = matched; i < requiredDocs.length; i++) {
      missingDocs.add(requiredDocs[i]);
    }

    // DOCUMENT SCORE
    if (requiredDocs.isNotEmpty) {
      score += ((matched / requiredDocs.length) * 60).toInt();
    }

    // BASE SCORE
    score += 20;

    // LIMIT SCORE
    if (score > 100) {
      score = 100;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("AI Score")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // SCORE CARD
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Text("AI Preparedness Score"),
                    const SizedBox(height: 10),
                    Text(
                      "$score / 100",
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // DISEASE DISPLAY
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Disease: ${profile?['disease'] ?? 'Not Set'}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 10),

            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Missing Documents",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 10),

            // MISSING DOCS LIST
            Expanded(
              child: missingDocs.isEmpty
                  ? const Center(
                      child: Text(
                        "All required documents uploaded",
                      ),
                    )
                  : ListView.builder(
                      itemCount: missingDocs.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: const Icon(
                            Icons.warning,
                            color: Colors.red,
                          ),
                          title: Text(missingDocs[index]),
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