import 'package:flutter/material.dart';
import 'package:medivault/data/database_helper.dart';
import 'package:medivault/services/notification_service.dart';

class ReminderScreen extends StatefulWidget {
  const ReminderScreen({super.key});

  @override
  State<ReminderScreen> createState() => _ReminderScreenState();
}

class _ReminderScreenState extends State<ReminderScreen> {
  final TextEditingController _controller = TextEditingController();

  List<Map<String, dynamic>> reminders = [];

  @override
  void initState() {
    super.initState();
    loadReminders();
  }

  Future<void> loadReminders() async {
    final data = await DatabaseHelper.instance.getReminders();

    setState(() {
      reminders = data;
    });
  }

  Future<void> addReminder() async {
    final text = _controller.text.trim();

    if (text.isEmpty) return;

    // SAVE TO DATABASE
    await DatabaseHelper.instance.insertReminder(text);

    // SHOW NOTIFICATION
    await NotificationService.showNotification(
      "MediVault Reminder",
      text,
    );

    _controller.clear();
    await loadReminders();

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Reminder added")),
    );
  }

  Future<void> deleteReminder(int id) async {
    await DatabaseHelper.instance.deleteReminder(id);
    await loadReminders();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Reminders")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: "Enter medicine / appointment",
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: addReminder,
                ),
              ],
            ),

            const SizedBox(height: 20),

            Expanded(
              child: reminders.isEmpty
                  ? const Center(child: Text("No reminders added"))
                  : ListView.builder(
                      itemCount: reminders.length,
                      itemBuilder: (context, index) {
                        final item = reminders[index];

                        return Card(
                          child: ListTile(
                            title: Text(item['title'] ?? ''),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () =>
                                  deleteReminder(item['id']),
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