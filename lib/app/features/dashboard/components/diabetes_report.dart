import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sugar_tracker/app/utils/utils.dart';

import '../state/homepage_state.dart';

class ConfirmationPage extends StatelessWidget {
  const ConfirmationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AlertDialog(
        title: const Text('Diabetes Report'),
        content: const Text('Do you agree to view the diabetes report?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pushNamed(context, '/home'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pushNamed(context, '/diabetesreport'),
            child: const Text('Agree'),
          ),
        ],
      ),
    );
  }
}

class DiabetesReport extends ConsumerWidget {
  const DiabetesReport({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final diabetesData = ref.watch(reportProvider);

    return diabetesData.when(
      loading: () => const Center(
        child: SizedBox(
          width: 50,
          height: 50,
          child: CircularProgressIndicator(),
        ),
      ),
      error: (Object error, StackTrace stackTrace) => Scaffold(
        body: Center(child: Text('$error')),
      ),
      data: (diabetesDataList) {
        if (diabetesDataList.isEmpty) {
          return const Scaffold(
            body: Center(child: Text("No response from Chatbot.")),
          );
        }

        return MyMarkDownWidget();
      },
    );
  }
}
