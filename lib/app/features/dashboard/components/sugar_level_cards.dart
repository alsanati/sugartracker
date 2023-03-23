import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../models/sugar_data.dart';

class SugarDataListView extends ConsumerWidget {
  final AsyncValue<List<SugarData>> sugarData;
  const SugarDataListView({Key? key, required this.sugarData})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorSecondary = Theme.of(context).colorScheme.surface;

    return sugarData.when(
      loading: () => const CircularProgressIndicator(),
      error: (error, stackTrace) => Text('Error: $error'),
      data: (data) {
        final todayData = data.where((sugarData) {
          final date = sugarData.createdAt!;
          final currentDate = DateTime.now();
          return date.year == currentDate.year &&
              date.month == currentDate.month &&
              date.day == currentDate.day;
        }).toList();

        return ListView.builder(
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
        );
      },
    );
  }
}
