import 'package:flutter/material.dart';

class AIScoreScreen extends StatelessWidget {
  const AIScoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 🔹 TEMP SAMPLE DATA (later we connect DB)
    bool hasProfile = true;
    bool hasDocuments = false;
    bool hasEmergency = true;

    int score = 0;
    List<String> missing = [];

    if (hasProfile) {
      score += 40;
    } else {
      missing.add("Complete Health Profile");
    }

    if (hasDocuments) {
      score += 30;
    } else {
      missing.add("Upload Medical Documents");
    }

    if (hasEmergency) {
      score += 30;
    } else {
      missing.add("Add Emergency Details");
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("AI Preparedness Score"),
        backgroundColor: const Color(0xFF0F172A),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // SCORE CARD
            Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  children: [
                    const Text(
                      "Your Score",
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "$score / 100",
                      style: const TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            // MISSING ITEMS
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "What’s Missing:",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 10),

            ...missing.map(
              (item) => ListTile(
                leading: const Icon(Icons.warning, color: Colors.red),
                title: Text(item),
              ),
            ),

            if (missing.isEmpty)
              const Text(
                "All set! Great job 🎉",
                style: TextStyle(color: Colors.green),
              ),
          ],
        ),
      ),
    );
  }
}