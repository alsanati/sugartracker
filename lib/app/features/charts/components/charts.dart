import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sugar_tracker/app/models/sugar_data.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Chart extends StatefulWidget {
  const Chart({super.key, required this.sugarData, required this.data});

  final SugarData sugarData;
  final List<SugarData> data;

  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  @override
  Widget build(BuildContext context) {
    final colorPrimary = Theme.of(context).colorScheme.primaryContainer;
    final colorSecondary = Theme.of(context).colorScheme.surface;
    final text = Theme.of(context).textTheme.labelSmall;
    return Card(
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
              dataSource: widget.data,
              xValueMapper: (SugarData sugarData, _) => sugarData.createdAt,
              yValueMapper: (SugarData sugarData, _) => sugarData.sugarLevel,
              color: colorSecondary,
              dataLabelSettings: const DataLabelSettings(isVisible: false),
              width: 2,
            ),
          ],
        ),
      ),
    );
  }
}
