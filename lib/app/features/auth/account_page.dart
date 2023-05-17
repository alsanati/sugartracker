import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sugar_tracker/app/features/data_export/pdf_service.dart';
import 'package:sugar_tracker/app/models/sign_up.dart';
import 'package:sugar_tracker/app/utils/constants.dart';
import 'package:sugar_tracker/app/utils/utils.dart';

import '../data_export/pdf_page.dart';
import '../reminders/reminder_page.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    final items = [
      {'title': 'Reminders', 'child': const ReminderPage()},
      {'title': 'Data Export', 'child': ExportPage()},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Account')),
      body: FutureBuilder<PatientData>(
        future: supabase.patient.fetchPatientData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final patientData = snapshot.data!;
            final textColor = Theme.of(context).textTheme.bodyMedium;

            return ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              children: [
                const SizedBox(height: 20),
                Card(
                  color: Theme.of(context).colorScheme.tertiaryContainer,
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        ListTile(
                          title: Text(
                            'First Name',
                            style: textColor,
                          ),
                          subtitle: Text(patientData.firstName),
                          leading: const FaIcon(FontAwesomeIcons.faceGrin),
                        ),
                        ListTile(
                          title: Text('Last Name', style: textColor),
                          subtitle: Text(patientData.lastName),
                          leading: const FaIcon(FontAwesomeIcons.faceGrin),
                        ),
                        ListTile(
                          title: Text('Birthday', style: textColor),
                          subtitle: Text(patientData.birthday),
                          leading: const FaIcon(FontAwesomeIcons.cakeCandles),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ...items.map((item) => ListTile(
                      title: Text(item['title'] as String),
                      trailing: const Icon(Icons.navigate_next),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => item['child'] as Widget,
                          ),
                        );
                      },
                    )),
                ElevatedButton(
                  onPressed: () => supabase.patient.logout(context),
                  child: const Text('Logout'),
                ),
              ],
            );
          } else {
            return const Center(child: Text('No patient data available'));
          }
        },
      ),
    );
  }
}
