import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sugar_tracker/app/features/reminders/reminder_service.dart';
import 'package:timezone/timezone.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class Reminder {
  Reminder({
    required this.id,
    required this.title,
    required this.message,
    required this.time,
    required this.recurring,
  });

  final int id;
  final String message;
  final bool recurring;
  final TimeOfDay time;
  final String title;
}

class ReminderForm extends StatefulWidget {
  const ReminderForm({Key? key}) : super(key: key);

  @override
  _ReminderFormState createState() => _ReminderFormState();
}

class _ReminderFormState extends State<ReminderForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isRecurring = false;
  late TextEditingController _messageController;
  TimeOfDay _selectedTime = TimeOfDay.now();
  late TextEditingController _titleController;

  @override
  void dispose() {
    _titleController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _messageController = TextEditingController();
  }

  void _saveReminder() async {
    if (_formKey.currentState!.validate()) {
      final title = _titleController.text;
      final message = _messageController.text;

      // Convert selected time to DateTime object
      final now = TZDateTime.now(local);
      final selectedDateTime = TZDateTime(
        local,
        now.year,
        now.month,
        now.day,
        _selectedTime.hour,
        _selectedTime.minute,
      );

      // Create an instance of NotificationService
      NotificationService notificationService = NotificationService.instance;

      // Schedule the reminder notification using the instance
      await notificationService.showScheduledLocalNotification(
        id: 123,
        title: title,
        body: message,
        payload: 'reminder',
        seconds: selectedDateTime.difference(DateTime.now()).inSeconds,
      );

      // Save the reminder locally
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> reminders = prefs.getStringList('reminders') ?? [];
      reminders.add(jsonEncode({
        'id': DateTime.now().millisecondsSinceEpoch,
        'title': title,
        'message': message,
        'hour': _selectedTime.hour,
        'minute': _selectedTime.minute,
        'recurring': _isRecurring,
      }));
      await prefs.setStringList('reminders', reminders);

      // Show success message and clear form
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Reminder added")));
      }

      _formKey.currentState!.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Set Reminder'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _titleController,
                      decoration: const InputDecoration(
                        labelText: 'Title',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a title';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _messageController,
                      decoration: const InputDecoration(
                        labelText: 'Message',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a message';
                        }
                        return null;
                      },
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            const Text('Time:'),
                            const SizedBox(width: 10),
                            TextButton(
                              onPressed: () async {
                                final TimeOfDay? selectedTime =
                                    await showTimePicker(
                                  context: context,
                                  initialTime: _selectedTime,
                                );
                                if (selectedTime != null) {
                                  setState(() {
                                    _selectedTime = selectedTime;
                                  });
                                }
                              },
                              child: Text(
                                _selectedTime.format(context),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Checkbox(
                              value: _isRecurring,
                              onChanged: (value) {
                                setState(() {
                                  _isRecurring = value ?? false;
                                });
                              },
                            ),
                            const Text('Recurring'),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: ElevatedButton(
                            onPressed: _saveReminder,
                            child: const Text('Save Reminder'),
                          ),
                        ),
                      ],
                    ),
                  ]),
            ),
          ),
        ));
  }
}

class ReminderList extends StatefulWidget {
  const ReminderList({Key? key}) : super(key: key);

  @override
  _ReminderListState createState() => _ReminderListState();
}

class _ReminderListState extends State<ReminderList> {
  List<Reminder> _reminders = [];

  @override
  void initState() {
    super.initState();
    _loadReminders();
  }

  void _loadReminders() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> reminders = prefs.getStringList('reminders') ?? [];
    _reminders = reminders.map((reminder) {
      Map<String, dynamic> data = jsonDecode(reminder);
      return Reminder(
        id: data['id'],
        title: data['title'],
        message: data['message'],
        time: TimeOfDay(hour: data['hour'], minute: data['minute']),
        recurring: data['recurring'],
      );
    }).toList();
    setState(() {});
  }

  void _deleteReminder(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> reminders = prefs.getStringList('reminders') ?? [];
    reminders.removeWhere((reminder) {
      Map<String, dynamic> data = jsonDecode(reminder);
      return data['id'] == id;
    });
    await prefs.setStringList('reminders', reminders);
    _loadReminders();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _reminders.length,
      itemBuilder: (context, index) {
        final reminder = _reminders[index];
        return Card(
          child: ListTile(
            title: Text(reminder.title,
                style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(),
                Text("Message: ${reminder.message}"),
                Text("Time: ${reminder.time.format(context)}"),
                Text("Recurring: ${reminder.recurring ? "Yes" : "No"}"),
              ],
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => _deleteReminder(reminder.id),
            ),
          ),
        );
      },
    );
  }
}
