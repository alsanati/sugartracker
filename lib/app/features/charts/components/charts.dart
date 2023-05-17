import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../models/sugar_data.dart';
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
    final colorPrimary = Theme.of(context).colorScheme.primary;
    final colorSecondary = Theme.of(context).colorScheme.surface;
    final text = Theme.of(context).textTheme.titleSmall;

    return Card(
      color: colorPrimary,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          constraints: BoxConstraints(
            maxWidth:
                MediaQuery.of(context).size.width * 0.8, // 80% of screen width
            maxHeight: MediaQuery.of(context).size.height *
                0.3, // 30% of screen height
          ),
          child: Consumer(builder: (context, ref, _) {
            final glucoseData = ref.watch(asyncGlucoseNotifier(widget.days));

            return glucoseData.when(
              data: (List<SugarData> data) {
                if (data.isEmpty) {
                  return const Center(
                    child: Text('No data available'),
                  );
                }

                return SfCartesianChart(
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
                      labelFormat: '{value} mg/dL',
                      labelStyle: TextStyle(color: colorSecondary)),
                  title: ChartTitle(
                      text: widget.titleText,
                      textStyle: TextStyle(color: colorSecondary)),
                  tooltipBehavior: TooltipBehavior(enable: true),
                  zoomPanBehavior: ZoomPanBehavior(
                    enablePanning: true,
                    enablePinching: true,
                    maximumZoomLevel: 4,
                  ),
                  series: <ChartSeries>[
                    LineSeries<SugarData, DateTime>(
                      dataSource: data,
                      xValueMapper: (SugarData sugarData, _) =>
                          sugarData.createdAt,
                      yValueMapper: (SugarData sugarData, _) =>
                          sugarData.sugarLevel,
                      color: colorSecondary,
                      dashArray: [
                        8,
                        4
                      ], // Apply dashed line style with dash array [8, 4]
                      width: 2,
                    ),
                    ScatterSeries<SugarData, DateTime>(
                      dataSource: data,
                      xValueMapper: (SugarData sugarData, _) =>
                          sugarData.createdAt,
                      yValueMapper: (SugarData sugarData, _) =>
                          sugarData.sugarLevel,
                      color: colorSecondary,
                      markerSettings: const MarkerSettings(
                        isVisible: true,
                        shape: DataMarkerType.circle,
                        borderWidth: 2,
                        height: 2,
                        width: 2,
                        borderColor: Colors.black,
                      ),
                    ),
                    // Additional series can be added here...
                  ],
                );
              },
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
