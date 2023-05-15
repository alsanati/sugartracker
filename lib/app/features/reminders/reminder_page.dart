import 'package:flutter/material.dart';
import 'package:sugar_tracker/app/features/reminders/reminder.dart';

class ReminderPage extends StatefulWidget {
  const ReminderPage({Key? key}) : super(key: key);

  @override
  _ReminderPageState createState() => _ReminderPageState();
}

class _ReminderPageState extends State<ReminderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reminders'),
      ),
      body: const ReminderList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ReminderForm(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
