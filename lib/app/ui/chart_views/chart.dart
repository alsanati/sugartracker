// ignore_for_file: unused_result

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sugar_tracker/app/models/sugarData.dart';
import 'package:sugar_tracker/app/modules/supabase_modules.dart';
import 'package:sugar_tracker/app/ui/chart_views/state/chart_state.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Chart extends ConsumerWidget {
  const Chart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorPrimary = Theme.of(context).colorScheme.primaryContainer;
    final colorSecondary = Theme.of(context).colorScheme.surface;
    final text = Theme.of(context).textTheme.labelSmall;
    final colorTertiary = Theme.of(context).colorScheme.tertiaryContainer;

    return ref.watch(asyncGlucoseNotifier).when(
          loading: () => const CircularProgressIndicator(),
          error: (err, stack) {
            return Scaffold(
              body: Center(child: Text('$err')),
            );
          },
          data: (data) {
            return Center(
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ActionChip(
                        label: const Text('7 Days'),
                        backgroundColor: ref.watch(sevenDaysProvider)
                            ? colorPrimary
                            : colorTertiary,
                        onPressed: () {
                          ref.refresh(asyncGlucoseNotifier);
                          ref.watch(sevenDaysProvider.notifier).state = true;
                          ref.watch(fourTeenDaysProvider.notifier).state =
                              false;
                        },
                      ),
                      const SizedBox(width: 10),
                      ActionChip(
                        label: const Text('14 Days'),
                        backgroundColor: ref.watch(fourTeenDaysProvider)
                            ? colorPrimary
                            : colorTertiary,
                        onPressed: () {
                          ref.watch(sevenDaysProvider.notifier).state = false;
                          ref.watch(fourTeenDaysProvider.notifier).state = true;
                        },
                      ),
                      const SizedBox(width: 10),
                      ActionChip(
                        label: const Text('30 Days'),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Card(
                    color: colorPrimary,
                    child: SizedBox(
                      width: 400,
                      height: 300,
                      child: SfCartesianChart(
                        primaryXAxis: DateTimeAxis(
                          interval: 1,
                          majorGridLines: const MajorGridLines(width: 0),
                        ),
                        primaryYAxis: NumericAxis(
                            majorGridLines: const MajorGridLines(width: 0),
                            labelFormat: '{value} mg/dL'),
                        title: ChartTitle(textStyle: text),
                        series: <ChartSeries>[
                          LineSeries<SugarData, DateTime>(
                            dataSource: data,
                            xValueMapper: (SugarData sugarData, _) =>
                                sugarData.createdAt,
                            yValueMapper: (SugarData sugarData, _) =>
                                sugarData.sugarLevel,
                            color: colorSecondary,
                            dataLabelSettings:
                                const DataLabelSettings(isVisible: false),
                            width: 2,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
  }
}
