import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
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
    final colorSecondary = Theme.of(context).colorScheme.onSurface;

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
          padding: const EdgeInsets.all(16.0),
          itemCount: todayData.length,
          itemBuilder: (context, index) {
            final sugarData = todayData[index];
            final date = sugarData.createdAt!;
            final formattedDate = DateFormat().add_yMEd().format(date);
            final sugarLevel = sugarData.sugarLevel;
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                color: sugarData.fasting == true
                    ? sugarLevel < 100
                        ? const Color(0xFF81C784) // green
                        : sugarLevel >= 100 && sugarLevel < 126
                            ? const Color(0xFFFFB74D) // orange
                            : const Color(0xFFE57373) // red
                    : sugarLevel <= 180
                        ? const Color(0xFF81C784) // green
                        : const Color(0xFFE57373), // red
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        formattedDate,
                        style: TextStyle(
                          color: colorSecondary,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Text(
                            sugarData.fasting == true
                                ? "Pre-meal:"
                                : sugarData.fasting == false
                                    ? "After Meal:"
                                    : "Unknown",
                            style:
                                TextStyle(color: colorSecondary, fontSize: 16),
                          ),
                          Text(
                            ' $sugarLevel mg/dL',
                            style:
                                TextStyle(color: colorSecondary, fontSize: 16),
                          ),
                          const Spacer(),
                          Text(
                            sugarData.fasting == true
                                ? sugarLevel < 100
                                    ? '😃'
                                    : sugarLevel >= 100 && sugarLevel < 126
                                        ? '😊'
                                        : '😞'
                                : sugarLevel <= 180
                                    ? '😃'
                                    : '😞',
                            style: const TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
