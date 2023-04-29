import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../state/homepage_state.dart';

class DiabetesReport extends ConsumerWidget {
  const DiabetesReport({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reportAsyncValue = ref.watch(reportProvider);

    return reportAsyncValue.when(
      data: (report) => SizedBox(
        width: double.infinity,
        // ignore: deprecated_member_use
        child: TypewriterAnimatedTextKit(
          text: [report],
          textStyle: const TextStyle(fontSize: 16.0),
          textAlign: TextAlign.start,
          speed: const Duration(milliseconds: 50),
        ),
      ),
      loading: () => const CircularProgressIndicator(),
      error: (error, _) => Text('Error: $error'),
    );
  }
}
