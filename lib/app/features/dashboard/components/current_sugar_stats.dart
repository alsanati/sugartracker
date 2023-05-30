import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sugar_tracker/app/models/sugar_data.dart';

class GlucoseStats extends StatefulWidget {
  final List<SugarData> sugardata;

  const GlucoseStats({Key? key, required this.sugardata}) : super(key: key);

  @override
  _GlucoseStatsState createState() => _GlucoseStatsState();
}

class _GlucoseStatsState extends State<GlucoseStats> {
  late Future<SharedPreferences> _prefs;

  @override
  void initState() {
    super.initState();
    _prefs = SharedPreferences.getInstance();
  }

  double calculateChangeInAverage(
      List<SugarData> todayData, List<SugarData> yesterdayData) {
    if (todayData.isEmpty || yesterdayData.isEmpty) return 0;

    double todaySum =
        todayData.map((e) => e.sugarLevel!.toDouble()).reduce((a, b) => a + b);
    double yesterdaySum = yesterdayData
        .map((e) => e.sugarLevel!.toDouble())
        .reduce((a, b) => a + b);

    double todayAverage = todaySum / todayData.length;
    double yesterdayAverage = yesterdaySum / yesterdayData.length;

    return todayAverage - yesterdayAverage;
  }

  Color getCircleColor(double value, double minTarget, double maxTarget) {
    Color safeLevelGlucoseColor = Colors.greenAccent;
    Color okayLevelColor = Colors.orangeAccent;
    Color alarmingLevelGlucoseColor = Colors.redAccent;

    if (value >= minTarget && value < maxTarget) {
      return safeLevelGlucoseColor;
    } else if (value < minTarget || value >= maxTarget) {
      return alarmingLevelGlucoseColor;
    } else {
      return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SharedPreferences>(
      future: _prefs,
      builder:
          (BuildContext context, AsyncSnapshot<SharedPreferences> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else {
          final SharedPreferences prefs = snapshot.data!;
          double minTarget = (prefs.getDouble('minTarget') ?? 80).toDouble();
          double maxTarget = (prefs.getDouble('maxTarget') ?? 180).toDouble();
          double avgTarget = (prefs.getDouble('avgTarget') ?? 110).toDouble();

          int? minGlucose;
          int? maxGlucose;
          double averageGlucose = 0;

          DateTime today = DateTime.now();
          DateTime yesterday = today.subtract(const Duration(days: 1));

          List<SugarData> todayData =
              SugarData.getEntriesForGivenDay(widget.sugardata, today);
          List<SugarData> yesterdayData =
              SugarData.getEntriesForGivenDay(widget.sugardata, yesterday);

          if (todayData.isNotEmpty) {
            minGlucose = todayData
                .map((e) => e.sugarLevel!)
                .reduce((a, b) => a < b ? a : b);
            maxGlucose = todayData
                .map((e) => e.sugarLevel!)
                .reduce((a, b) => a > b ? a : b);
            averageGlucose =
                todayData.map((e) => e.sugarLevel!).reduce((a, b) => a + b) /
                    todayData.length;

            String changeInAverage =
                calculateChangeInAverage(todayData, yesterdayData).toString();
            TextStyle changeTextStyle = TextStyle(
              color:
                  changeInAverage.startsWith('↑') ? Colors.red : Colors.green,
            );

            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Theme.of(context).colorScheme.tertiaryContainer,
                  ),
                  height: 160,
                  width: 400,
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                            alignment: Alignment.topLeft,
                            child: Text("Glucose Stats",
                                style:
                                    Theme.of(context).textTheme.titleMedium)),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: buildCircleStat(
                                context,
                                'Min.',
                                minGlucose,
                                changeInAverage,
                                changeTextStyle,
                                minTarget,
                                maxTarget,
                                avgTarget),
                          ),
                          Center(
                            child: buildCircleStat(
                                context,
                                'Avg.',
                                averageGlucose.toStringAsFixed(0),
                                changeInAverage,
                                changeTextStyle,
                                minTarget,
                                maxTarget,
                                avgTarget),
                          ),
                          Center(
                            child: buildCircleStat(
                                context,
                                'Max.',
                                maxGlucose,
                                changeInAverage,
                                changeTextStyle,
                                minTarget,
                                maxTarget,
                                avgTarget),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                  height: 150,
                  alignment: Alignment.center,
                  width: 400,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Theme.of(context).colorScheme.tertiaryContainer),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Glucose Stats",
                              style: Theme.of(context).textTheme.titleMedium,
                            )),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Add your sugar data!",
                            style: Theme.of(context).textTheme.labelLarge,
                          )),
                    ],
                  )),
            );
          }
        }
      },
    );
  }

  Padding buildCircleStat(
    BuildContext context,
    String title,
    dynamic value,
    String changeInAverage,
    TextStyle changeTextStyle,
    double minTarget,
    double maxTarget,
    double avgTarget,
  ) {
    double? doubleValue;
    if (value != null) {
      if (value is int) {
        doubleValue = value.toDouble();
      } else if (value is double) {
        doubleValue = value;
      } else if (value is String) {
        doubleValue = double.tryParse(value);
      }
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: Theme.of(context).colorScheme.tertiaryContainer,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black, width: 2),
                ),
                height: 50,
                width: 50,
                child: Center(
                  child: Text(
                    value.toString(),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onTertiaryContainer,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
            if (title == 'Min.')
              Text("/$minTarget",
                  style: Theme.of(context).textTheme.labelMedium),
            if (title == 'Max.')
              Text("/$maxTarget",
                  style: Theme.of(context).textTheme.labelMedium),
            if (title == 'Avg.')
              Text("/$avgTarget",
                  style: Theme.of(context).textTheme.labelMedium),
          ],
        ),
      ),
    );
  }
}
