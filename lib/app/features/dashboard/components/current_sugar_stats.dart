import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:sugar_tracker/app/models/sugar_data.dart';
import '../state/homepage_state.dart';

class GlucoseStats extends ConsumerWidget {
  final AsyncValue<List<SugarData>> sugardata;
  const GlucoseStats({Key? key, required this.sugardata}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return sugardata.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) {
        return Text('$err');
      },
      data: (currentEntries) {
        // Calculate the minimum and maximum glucose levels for the current day
        int? minGlucose;
        int? maxGlucose;
        double averageGlucose = 0;

        if (currentEntries.isNotEmpty) {
          minGlucose = currentEntries
              .map((e) => e.sugarLevel!)
              .reduce((a, b) => a < b ? a : b);
          maxGlucose = currentEntries
              .map((e) => e.sugarLevel!)
              .reduce((a, b) => a > b ? a : b);
          averageGlucose =
              currentEntries.map((e) => e.sugarLevel!).reduce((a, b) => a + b) /
                  currentEntries.length;
        }

        return Center(
          child: Container(
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text(
                      '${minGlucose ?? '-'} mg/dL',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Text(
                      '${averageGlucose.toStringAsFixed(0)} mg/dL',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Text(
                      '${maxGlucose ?? '-'} mg/dL',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
