import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sugar_tracker/app/utils/utils.dart';

import '../state/homepage_state.dart';

class DiabetesReport extends ConsumerWidget {
  const DiabetesReport({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final diabetesData = ref.watch(reportProvider);

    return diabetesData.when(
      loading: () => const Center(
          child: SizedBox(
              width: 50, height: 50, child: CircularProgressIndicator())),
      error: (Object error, StackTrace stackTrace) {
        return Scaffold(body: Center(child: Text('$error')));
      },
      data: (diabetesDataList) {
        // Convert diabetesDataList to a list of strings

        if (diabetesDataList.isEmpty) {
          return const Scaffold(
            body: Center(child: Text("No response from Chatbot.")),
          );
        }

        return const SizedBox(
            width: double.infinity, child: MyMarkDownWidget());
      },
    );
  }
}
