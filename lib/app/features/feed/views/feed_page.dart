import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sugar_tracker/app/features/dashboard/components/sugar_level_cards.dart';
import 'package:sugar_tracker/app/models/meals.dart';
import 'package:sugar_tracker/app/utils/error_screen.dart';
import '../../../models/activities.dart';
import '../../dashboard/components/expandable_fab.dart';
import '../state/feed_page_state.dart';

class FeedPage extends ConsumerWidget {
  const FeedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mealData = ref.watch(mealStreamProvider);
    final sugarData = ref.watch(sugarStreamProvider);
    final activityData = ref.watch(activityStreamProvider);

    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Builder(
      builder: (context) {
        return sugarData.when(
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
          error: (err, stack) {
            return CuteErrorScreen(
              error: err.toString(),
            );
          },
          data: (sugarDataList) {
            return mealData.when(
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              error: (err, stack) {
                return CuteErrorScreen(error: "Meal data: ${err.toString()}");
              },
              data: (mealDataList) {
                return activityData.when(
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  error: (err, stack) {
                    return CuteErrorScreen(
                      error: "Activity: ${err.toString()}",
                    );
                  },
                  data: (activityDataList) {
                    return Scaffold(
                      appBar: AppBar(
                        title: Text("Your Feed", style: textTheme.titleLarge),
                      ),
                      body: SafeArea(
                        child: DefaultTabController(
                          length: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const TabBar(
                                tabs: [
                                  Tab(text: "Sugar Levels"),
                                  Tab(text: "Food Items"),
                                  Tab(text: "Activities"),
                                ],
                              ),
                              Expanded(
                                child: TabBarView(
                                  children: [
                                    SugarDataListView(
                                        sugarData: sugarDataList, ref: ref),
                                    MealListView(
                                        mealDataList: mealDataList,
                                        theme: theme),
                                    ActivityListView(
                                      theme: theme,
                                      activityDataList: activityDataList,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      floatingActionButton: Align(
                        alignment: Alignment.bottomRight,
                        child: ExpandableFab(
                          distance: 56.0,
                          children: [
                            ActionButton(
                              onPressed: () =>
                                  showPostSugarLevelsBottomSheet(context),
                              label: "Add sugar levels",
                              context: context,
                            ),
                            ActionButton(
                              onPressed: () =>
                                  showPostSugarLevelsBottomSheet(context),
                              label: "Add sugar levels",
                              context: context,
                            ),
                            ActionButton(
                              onPressed: () =>
                                  showPostSugarLevelsBottomSheet(context),
                              label: "Add sugar levels",
                              context: context,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}

void showPostSugarLevelsBottomSheet(BuildContext context) {
  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return SingleChildScrollView(
        child: Container(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: const Text('Placeholder content'), // Add your content here
        ),
      );
    },
  );
}

class MealListView extends StatelessWidget {
  final List<Meal> mealDataList;
  final ThemeData theme;

  const MealListView({
    Key? key,
    required this.mealDataList,
    required this.theme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mealsGroupedByType = groupBy(mealDataList, (Meal m) => m.mealType);

    return ListView.builder(
      itemCount: mealsGroupedByType.keys.length,
      itemBuilder: (context, index) {
        final mealType = mealsGroupedByType.keys.elementAt(index);
        final mealsOfThisType = mealsGroupedByType[mealType]!;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                mealType.toString().split('.').last.toUpperCase(),
                style: theme.textTheme.bodyLarge,
              ),
            ),
            ...mealsOfThisType.map((meal) {
              return Padding(
                padding: const EdgeInsets.only(left: 4, right: 4),
                child: Card(
                  color: Theme.of(context).colorScheme.surface,
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ListTile(
                    title: Text(meal.mealName),
                    subtitle: Text(
                        '${meal.carbs}g Carbs, ${meal.protein}g Protein, ${meal.fat}g Fat'),
                    trailing: Text(
                      '${meal.calories} Calories',
                      style: theme.textTheme.bodyMedium,
                    ),
                  ),
                ),
              );
            }).toList(),
          ],
        );
      },
    );
  }
}

class ActivityListView extends StatelessWidget {
  final List<Activities> activityDataList;
  final ThemeData theme;

  const ActivityListView({
    Key? key,
    required this.activityDataList,
    required this.theme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: activityDataList.length,
      itemBuilder: (context, index) {
        final activity = activityDataList[index];
        return Padding(
            padding: const EdgeInsets.only(left: 4, right: 4),
            child: Card(
              color: Theme.of(context).colorScheme.surface,
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: ListTile(
                title: Text(activity.activity_type),
                subtitle: Text('Intensity: ${activity.intensity}'),
                leading: const Icon(Icons.directions_run),
                trailing: Text(
                  '${activity.duration} mins',
                  style: theme.textTheme.bodyLarge,
                ),
              ),
            ));
      },
    );
  }
}
