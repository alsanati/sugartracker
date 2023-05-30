import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sugar_tracker/app/features/target_ranges/target_range_page.dart';
import 'package:sugar_tracker/app/models/sign_up.dart';
import 'package:sugar_tracker/app/utils/constants.dart';
import 'package:sugar_tracker/app/utils/list_packages.dart';
import 'package:sugar_tracker/app/utils/utils.dart';

import '../data_export/pdf_page.dart';
import '../reminders/reminder_page.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final items = [
    {'title': 'Reminders', 'child': const ReminderPage()},
    {'title': 'Data Export', 'child': ExportPage()},
    {'title': 'Target Ranges', 'child': const SugarLevelTargetPage()},
    {'title': 'Librarys', 'child': PackageListWidget()},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account'),
        elevation: 1,
      ),
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
              padding: const EdgeInsets.all(16.0),
              children: [
                const SizedBox(height: 20),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  color: Theme.of(context).colorScheme.surface,
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
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
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
              ],
            );
          } else {
            return const Center(child: Text('No patient data available'));
          }
        },
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () => supabase.patient.logout(context),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: const Text('Logout'),
      ),
    );
  }
}
