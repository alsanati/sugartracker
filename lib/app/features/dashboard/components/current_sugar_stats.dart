import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:sugar_tracker/app/models/sugar_data.dart';

class GlucoseStats extends StatelessWidget {
  final List<SugarData> sugardata;
  const GlucoseStats({Key? key, required this.sugardata}) : super(key: key);

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

  Color getCircleColor(double? value) {
    Color goodLevelColor = const Color(0xFFA0D4AB);
    Color okayLevelColor = const Color(0xFFFFC482);
    Color badLevelcolor = Colors.red;

    if (value == null) {
      return Colors.black;
    } else if (value >= 70 && value < 180) {
      return goodLevelColor;
    } else if (value < 70 || value >= 180 && value < 300) {
      return okayLevelColor;
    } else {
      return badLevelcolor;
    }
  }

  @override
  Widget build(BuildContext context) {
    int? minGlucose;
    int? maxGlucose;
    double averageGlucose = 0;

    DateTime today = DateTime.now();
    DateTime yesterday = today.subtract(const Duration(days: 1));

    List<SugarData> todayData =
        SugarData.getEntriesForGivenDay(sugardata, today);
    List<SugarData> yesterdayData =
        SugarData.getEntriesForGivenDay(sugardata, yesterday);

    if (todayData.isNotEmpty) {
      minGlucose =
          todayData.map((e) => e.sugarLevel!).reduce((a, b) => a < b ? a : b);
      maxGlucose =
          todayData.map((e) => e.sugarLevel!).reduce((a, b) => a > b ? a : b);
      averageGlucose =
          todayData.map((e) => e.sugarLevel!).reduce((a, b) => a + b) /
              todayData.length;

      String changeInAverage =
          calculateChangeInAverage(todayData, yesterdayData).toString();
      TextStyle changeTextStyle = TextStyle(
        color: changeInAverage.startsWith('↑') ? Colors.red : Colors.green,
      );
      return Center(
        child: Container(
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildCircleStat(context, 'Min.', minGlucose, changeInAverage,
                  changeTextStyle),
              buildCircleStat(
                  context,
                  'Avg.',
                  averageGlucose.toStringAsFixed(0),
                  changeInAverage,
                  changeTextStyle),
              buildCircleStat(context, 'Max.', maxGlucose, changeInAverage,
                  changeTextStyle),
            ],
          ),
        ),
      );
    } else {
      return const Text("Add your sugar data!");
    }
  }

  Padding buildCircleStat(BuildContext context, String title, dynamic value,
      String changeInAverage, TextStyle changeTextStyle) {
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
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: doubleValue != null
              ? getCircleColor(doubleValue)
              : Theme.of(context).colorScheme.surface,
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style:
                  TextStyle(color: Theme.of(context).colorScheme.onBackground),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title == 'Avg.' && doubleValue != null
                      ? doubleValue.toString()
                      : value.toString(),
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
                if (title == 'Avg.')
                  Text(
                    changeInAverage,
                    style: changeTextStyle,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
