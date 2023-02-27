import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sugar_tracker/app/models/sugarData.dart';

final sugarDataProvider = FutureProvider<List<SugarData>>((ref) async {
  // Here you would fetch the sugar data from your data source
  // and return a List<SugarData>.
  return [];
});

class SugarDataListView extends ConsumerWidget {
  const SugarDataListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sugarDataList = ref.watch(sugarDataProvider);

    return sugarDataList.when(
      loading: () => const CircularProgressIndicator(),
      error: (error, stackTrace) => Text('Error: $error'),
      data: (data) => ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          final sugarData = data[index];
          final date = DateTime.parse(sugarData.createdAt!);
          final formattedDate = DateFormat('dd/MM/yyyy').format(date);

          return Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sugar level: ${sugarData.sugarLevel} mg/dL',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Date: $formattedDate',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
