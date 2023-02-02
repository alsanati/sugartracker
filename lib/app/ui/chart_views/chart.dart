import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sugar_tracker/app/models/sugarData.dart';
import 'package:sugar_tracker/app/modules/supabase_modules.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Chart extends StatefulWidget {
  const Chart({Key? key}) : super(key: key);

  @override
  _ChartState createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  final _supabaseAuth = SupabaseHelpers();
  final sugarData = SugarData();
  List<SugarData> sugar = <SugarData>[];

  @override
  void initState() {
    _supabaseAuth.getSugarData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _supabaseAuth.getSugarData(),
        builder: ((context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            var showData = snapshot.data;
            List<SugarData> sugarLevels = [];
            for (var i = 0; i < showData.length; i++) {
              final data = showData[i];
              sugarLevels.add(SugarData(
                  id: data['id'],
                  personId: data['personId'],
                  sugarLevel: data['sugar_level'],
                  createdAt: data['created_at']));
            }

            return SizedBox(
                width: 400,
                height: 400,
                child: SfCartesianChart(
                  primaryXAxis: CategoryAxis(
                    majorGridLines: const MajorGridLines(width: 0),
                  ),
                  primaryYAxis: NumericAxis(
                      majorGridLines: const MajorGridLines(width: 0),
                      labelFormat: '{value} mg/dL'),
                  title: ChartTitle(
                      text: 'Sugar Tracker',
                      textStyle: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                  series: <ChartSeries>[
                    LineSeries<SugarData, String>(
                      dataSource: sugarLevels,
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
                ));
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          } else {
            return const CircularProgressIndicator();
          }
        }));
  }
}
