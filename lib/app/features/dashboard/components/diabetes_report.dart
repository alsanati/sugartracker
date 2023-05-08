import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../state/homepage_state.dart';

class DiabetesReport extends ConsumerWidget {
  const DiabetesReport({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final diabetesData = ref.watch(diabetesDataProvider);

    return diabetesData.when(
      loading: () => const Center(
          child: SizedBox(
              width: 50, height: 50, child: CircularProgressIndicator())),
      error: (Object error, StackTrace stackTrace) {
        return Scaffold(body: Center(child: Text('$error')));
      },
      data: (diabetesDataList) {
        // Convert diabetesDataList to a list of strings
        List<String> diabetesDataStringList =
            diabetesDataList.map((data) => data.toString()).toList();

        if (diabetesDataList.isEmpty) {
          return Scaffold(
            body: Center(child: Text("No response from Chatbot.")),
          );
        }

        return SizedBox(
          width: double.infinity,
          child: TypewriterAnimatedTextKit(
            text: diabetesDataStringList,
            textStyle: const TextStyle(fontSize: 16.0),
            textAlign: TextAlign.start,
            speed: const Duration(milliseconds: 25),
          ),
        );
      },
    );
  }
}
