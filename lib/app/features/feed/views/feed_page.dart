import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:sugar_tracker/app/features/dashboard/components/sugar_level_cards.dart';
import 'package:sugar_tracker/app/models/meals.dart';
import '../../dashboard/components/expandable_fab.dart';
import '../../dashboard/components/get_sugar_data.dart';
import '../state/feed_page_state.dart';

class FeedPage extends ConsumerWidget {
  const FeedPage({Key? key}) : super(key: key);

  Widget _buildMealList(BuildContext context, List<dynamic> feedDataList) {
    // Sort the feedDataList based on mealType
    feedDataList.sort((a, b) => a.mealType.index.compareTo(b.mealType.index));

    // Initialize a map to keep track of total calories for each meal type
    Map<MealType, num> totalCalories = {
      MealType.breakfast: 0,
      MealType.lunch: 0,
      MealType.dinner: 0,
      MealType.snack: 0,
    };

    // Calculate the total calories for each meal type
    for (var mealData in feedDataList) {
      totalCalories[mealData.mealType] =
          (totalCalories[mealData.mealType] ?? 0) + mealData.calories;
    }

    // Now you can build the ListView
    return ListView.builder(
      padding: const EdgeInsets.all(4.0),
      itemCount: feedDataList.length,
      itemBuilder: (context, index) {
        final mealData = feedDataList[index] as Meal;

        // Check if the current meal is the first of its type in the list
        bool isFirstOfType =
            index == 0 || mealData.mealType != feedDataList[index - 1].mealType;

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 1.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // If it's the first meal of its type, display the meal type as a header
              if (isFirstOfType)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 1.0),
                  child: Text(
                      '${mealData.mealType.toString().split('.').last.toUpperCase()} - ${totalCalories[mealData.mealType]} Calories',
                      style: Theme.of(context).textTheme.titleMedium),
                ),
              // Then display the meal card
              Card(
                color: Theme.of(context).colorScheme.surface,
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(mealData.mealName,
                              style: Theme.of(context).textTheme.titleSmall),
                        ],
                      ),
                      Row(
                        children: [
                          _buildInfoItem(
                            context: context,
                            icon: FontAwesomeIcons.wheatAwn,
                            label: "${mealData.carbs}g Carbs",
                          ),
                          _buildInfoItem(
                            context: context,
                            icon: FontAwesomeIcons.cow,
                            label: " - ${mealData.protein}g Protein",
                          ),
                          _buildInfoItem(
                            context: context,
                            icon: FontAwesomeIcons.bacon,
                            label: " - ${mealData.fat}g Fat",
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildInfoItem(
      {required IconData icon,
      required String label,
      required BuildContext context}) {
    return Row(
      children: [
        Text(label, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mealData = ref.watch(mealStreamProvider);
    final sugarData = ref.watch(sugarStreamProvider);

    return Builder(
      builder: (context) {
        final sugarDataState = sugarData.when(
          loading: () => const AsyncLoading<List<dynamic>>(),
          error: (err, stack) => AsyncError<List<dynamic>>(err, stack),
          data: (data) => AsyncData<List<dynamic>>(data),
        );

        final mealDataState = mealData.when(
          loading: () => const AsyncLoading<List<dynamic>>(),
          error: (err, stack) => AsyncError<List<dynamic>>(err, stack),
          data: (data) => AsyncData<List<dynamic>>(data),
        );

        return sugarDataState.when(
          loading: () => const Center(
            child: SizedBox(
                width: 50, height: 50, child: CircularProgressIndicator()),
          ),
          error: (err, stack) {
            return Scaffold(
              body: Center(child: Text('$err')),
            );
          },
          data: (sugarDataList) {
            return mealDataState.when(
              loading: () => const Center(
                child: SizedBox(
                    width: 50, height: 50, child: CircularProgressIndicator()),
              ),
              error: (err, stack) {
                return Scaffold(
                  body: Center(child: Text('$err')),
                );
              },
              data: (mealDataList) {
                return Scaffold(
                  appBar: AppBar(
                    title: Text(
                      "Your Feed",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
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
                                _buildMealList(context, mealDataList),
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
                          onPressed: () {
                            showModalBottomSheet<void>(
                              context: context, // Pass the context here
                              isScrollControlled: true,
                              builder: (BuildContext context) {
                                return SingleChildScrollView(
                                  child: Container(
                                    padding: EdgeInsets.only(
                                      bottom: MediaQuery.of(context)
                                          .viewInsets
                                          .bottom,
                                    ),
                                    child: const PostSugarLevelsBottomSheet(),
                                  ),
                                );
                              },
                            );
                          },
                          label: "Add sugar levels",
                          context: context,
                        ),
                        ActionButton(
                          onPressed: () {
                            showModalBottomSheet<void>(
                              context: context, // Pass the context here
                              isScrollControlled: true,
                              builder: (BuildContext context) {
                                return SingleChildScrollView(
                                  child: Container(
                                    padding: EdgeInsets.only(
                                      bottom: MediaQuery.of(context)
                                          .viewInsets
                                          .bottom,
                                    ),
                                    child: const PostSugarLevelsBottomSheet(),
                                  ),
                                );
                              },
                            );
                          },
                          label: "Add sugar levels",
                          context: context,
                        ),
                        ActionButton(
                          onPressed: () {
                            showModalBottomSheet<void>(
                              context: context, // Pass the context here
                              isScrollControlled: true,
                              builder: (BuildContext context) {
                                return SingleChildScrollView(
                                  child: Container(
                                    padding: EdgeInsets.only(
                                      bottom: MediaQuery.of(context)
                                          .viewInsets
                                          .bottom,
                                    ),
                                    child: const PostSugarLevelsBottomSheet(),
                                  ),
                                );
                              },
                            );
                          },
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
  }
}
