import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sugar_tracker/app/models/sugar_data.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../state/chart_state.dart';

class Chart extends StatefulWidget {
  const Chart({
    Key? key,
    required this.days,
    required this.titleText,
  }) : super(key: key);

  final int days;
  final String titleText;

  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  @override
  Widget build(BuildContext context) {
    final colorPrimary = Theme.of(context).colorScheme.secondaryContainer;
    final colorSecondary = Theme.of(context).colorScheme.surface;
    final text = Theme.of(context).textTheme.labelSmall;

    return Card(
      color: colorPrimary,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          constraints: BoxConstraints(
            maxWidth:
                MediaQuery.of(context).size.width * 0.8, // 80% of screen width
            maxHeight: MediaQuery.of(context).size.height *
                0.3, // 40% of screen height
          ),
          child: Consumer(builder: (context, ref, _) {
            final glucoseData = ref.watch(asyncGlucoseNotifier(widget.days));

            return glucoseData.when(
              data: (List<SugarData> data) => SfCartesianChart(
                primaryXAxis: DateTimeAxis(
                  interval: 1,
                  intervalType: DateTimeIntervalType.days,
                  dateFormat: DateFormat('dd/MM'),
                  majorGridLines: const MajorGridLines(width: 0),
                  majorTickLines: const MajorTickLines(size: 0),
                  maximumLabels: widget.days,
                ),
                primaryYAxis: NumericAxis(
                    minimum: 0,
                    maximum: 300,
                    interval: 50,
                    majorGridLines: const MajorGridLines(width: 0),
                    labelFormat: '{value} mg/dL'),
                title: ChartTitle(text: widget.titleText, textStyle: text),
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
              loading: () => const CircularProgressIndicator(),
              error: (error, stack) => Center(
                child: Text('Error: $error'),
              ),
            );
          }),
        ),
      ),
    );
  }
}
