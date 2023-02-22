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
    return ref.watch(asyncGlucoseNotifier).when(
        loading: () => const CircularProgressIndicator(),
        error: (err, stack) {
          return Scaffold(
            body: Center(child: Text('$err')),
          );
        },
        data: (asyncGlucoseNotifier) {
          return RefreshIndicator(
            onRefresh: () =>
                ref.refresh(asyncGlucoseNotifier as Refreshable<Future<void>>),
            child: Card(
              child: SizedBox(
                  width: 400,
                  height: 300,
                  child: SfCartesianChart(
                    primaryXAxis: CategoryAxis(
                      majorGridLines: const MajorGridLines(width: 0),
                    ),
                    primaryYAxis: NumericAxis(
                        majorGridLines: const MajorGridLines(width: 0),
                        labelFormat: '{value} mg/dL'),
                    title: ChartTitle(
                        textStyle: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                    series: <ChartSeries>[
                      LineSeries<SugarData, String>(
                        dataSource: asyncGlucoseNotifier,
                        xValueMapper: (SugarData sugarData, _) =>
                            sugarData.createdAt,
                        yValueMapper: (SugarData sugarData, _) =>
                            sugarData.sugarLevel,
                        color: Colors.black,
                        dataLabelSettings:
                            const DataLabelSettings(isVisible: false),
                        width: 2,
                      ),
                    ],
                  )),
            ),
          );
        });
  }
}
