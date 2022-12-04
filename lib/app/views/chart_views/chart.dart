// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sugar_tracker/app/models/sugarData.dart';
import 'package:sugar_tracker/app/modules/supabase_modules.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

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
                height: 600,
                child: SfCartesianChart(
                  primaryXAxis: CategoryAxis(),
                  title: ChartTitle(text: 'Sugar Tracker'),
                  legend: Legend(isVisible: true),
                  tooltipBehavior: TooltipBehavior(enable: true),
                  series: <ChartSeries>[
                    LineSeries<SugarData, String>(
                      dataSource: sugarLevels,
                      xValueMapper: (SugarData sugarData, _) =>
                          sugarData.createdAt,
                      yValueMapper: (SugarData sugarData, _) =>
                          sugarData.sugarLevel,
                      name: 'Sugar Level',
                      dataLabelSettings: DataLabelSettings(isVisible: true),
                    ),
                  ],
                ));
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          } else {
            return CircularProgressIndicator();
          }
        }));
  }
}
