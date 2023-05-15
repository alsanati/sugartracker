import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../models/sugar_data.dart';
import '../../feed/state/feed_page_state.dart';
import '../state/homepage_state.dart';

class SugarDataListView extends StatelessWidget {
  final List<dynamic> sugarData;
  final WidgetRef ref;

  const SugarDataListView(
      {Key? key, required this.sugarData, required this.ref})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorSecondary = Theme.of(context).colorScheme.surface;

    final todayData = sugarData.where((sugarData) {
      final date = sugarData.createdAt!;
      final currentDate = DateTime.now();
      return date.isAfter(currentDate.subtract(const Duration(days: 1))) &&
          date.isBefore(currentDate.add(const Duration(seconds: 1)));
    }).toList();

    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(homePageProvider);
        ref.invalidate(getCurrentSugarDataStats);
        ref.invalidate(mealStreamProvider);
        ref.invalidate(sugarStreamProvider);
      },
      child: ListView.builder(
        itemCount: todayData.length,
        itemBuilder: (context, index) {
          final sugarData = todayData[index];
          final date = sugarData.createdAt!;
          final formattedDate = DateFormat().add_yMEd().format(date);
          final sugarLevel = sugarData.sugarLevel;
          final icon = sugarLevel! < 70
              ? '😃'
              : sugarLevel >= 70 && sugarLevel < 180
                  ? '😊'
                  : '😞';
          return Card(
            color: sugarLevel < 70
                ? const Color.fromRGBO(0, 184, 169, 1)
                : sugarLevel >= 70 && sugarLevel < 180
                    ? const Color.fromRGBO(255, 222, 125, 1)
                    : const Color.fromRGBO(246, 65, 108, 1),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Text(
                    formattedDate,
                    style: TextStyle(
                        color: colorSecondary, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(' $sugarLevel mg/dL ',
                      style: TextStyle(color: colorSecondary)),
                  const Spacer(),
                  Text(icon)
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
