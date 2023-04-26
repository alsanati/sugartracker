import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sugar_tracker/app/features/charts/state/chart_state.dart';
import 'package:sugar_tracker/app/features/components/bottom_nav.dart';
import 'package:sugar_tracker/app/models/sugar_data.dart';
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
            if (data.length < 7) {
              return Scaffold(
                body: Center(child: Text('Not enough data')),
              );
            }
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
                          ref.watch(sevenDaysProvider.notifier).state = true;
                          ref.watch(thirtyDaysProvider.notifier).state = false;
                          ref.watch(fourTeenDaysProvider.notifier).state =
                              false;

                          return ref.refresh(asyncGlucoseNotifier);
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
                          ref.watch(thirtyDaysProvider.notifier).state = false;
                          ref.watch(fourTeenDaysProvider.notifier).state = true;
                        },
                      ),
                      const SizedBox(width: 10),
                      ActionChip(
                        label: const Text('30 Days'),
                        backgroundColor: ref.watch(thirtyDaysProvider)
                            ? colorPrimary
                            : colorTertiary,
                        onPressed: () {
                          ref.watch(sevenDaysProvider.notifier).state = false;
                          ref.watch(fourTeenDaysProvider.notifier).state =
                              false;

                          ref.watch(thirtyDaysProvider.notifier).state = true;
                        },
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
                          intervalType: DateTimeIntervalType.days,
                          dateFormat: DateFormat('dd/MM'),
                          majorGridLines: const MajorGridLines(width: 0),
                          majorTickLines: const MajorTickLines(size: 0),
                          maximumLabels: 7,
                        ),
                        primaryYAxis: NumericAxis(
                            minimum: 0,
                            maximum: 300,
                            interval: 50,
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
