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

  TimeOfDay? selectedTime;

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

  // ---------------- PICK TIME ----------------
  Future<void> pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  // ---------------- ADD REMINDER ----------------
  Future<void> addReminder() async {
    final text = _controller.text.trim();

    if (text.isEmpty || selectedTime == null) return;

    final now = DateTime.now();

    DateTime scheduled = DateTime(
      now.year,
      now.month,
      now.day,
      selectedTime!.hour,
      selectedTime!.minute,
    );

    // ✅ Fix: if time already passed → schedule tomorrow
    if (scheduled.isBefore(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }

    // SAVE DB
    await DatabaseHelper.instance.insertReminder(
      text,
      selectedTime!.format(context),
    );

    // SCHEDULE NOTIFICATION
    await NotificationService.scheduleNotification(
      DateTime.now().millisecondsSinceEpoch ~/ 1000,
      "Reminder",
      text,
      scheduled,
    );

    _controller.clear();
    selectedTime = null;

    await loadReminders();

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Reminder Scheduled")),
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

  // ---------------- UI ----------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Reminders")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: "Medicine / Appointment",
              ),
            ),

            const SizedBox(height: 10),

            Row(
              children: [
                ElevatedButton(
                  onPressed: pickTime,
                  child: const Text("Pick Time"),
                ),
                const SizedBox(width: 10),
                Text(
                  selectedTime == null
                      ? "No time selected"
                      : selectedTime!.format(context),
                ),
              ],
            ),

            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: addReminder,
              child: const Text("Add Reminder"),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: reminders.isEmpty
                  ? const Center(child: Text("No reminders"))
                  : ListView.builder(
                      itemCount: reminders.length,
                      itemBuilder: (context, index) {
                        final item = reminders[index];

                        return Card(
                          child: ListTile(
                            title: Text(item['title']),
                            subtitle: Text(item['time'] ?? ''),
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