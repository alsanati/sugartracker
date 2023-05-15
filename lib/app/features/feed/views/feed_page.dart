import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sugar_tracker/app/features/dashboard/components/sugar_level_cards.dart';
import 'package:sugar_tracker/app/models/meals.dart';
import '../../dashboard/components/expandable_fab.dart';
import '../../dashboard/components/get_sugar_data.dart';
import '../state/feed_page_state.dart';

class FeedPage extends ConsumerWidget {
  const FeedPage({Key? key}) : super(key: key);

  Widget _buildMealList(BuildContext context, List<dynamic> feedDataList) {
    return ListView.builder(
      itemCount: feedDataList.length,
      itemBuilder: (context, index) {
        final mealData = feedDataList[index] as Meal;

        return Card(
          color: Theme.of(context).colorScheme.secondaryContainer,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      mealData.mealName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      "Created at: ${mealData.createdAt}",
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Column(
                  children: [
                    _buildInfoItem(
                      icon: Icons.fastfood,
                      label: "${mealData.carbs}g Carbs",
                    ),
                    _buildInfoItem(
                      icon: Icons.sentiment_satisfied,
                      label: "${mealData.protein}g Protein",
                    ),
                    _buildInfoItem(
                      icon: Icons.sentiment_dissatisfied,
                      label: "${mealData.fat}g Fat",
                    ),
                    const Align(
                        alignment: Alignment.bottomLeft,
                        child: Text("--------")),
                    _buildInfoItem(
                      icon: Icons.summarize,
                      label: "${mealData.calories}",
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildInfoItem({required IconData icon, required String label}) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: Colors.grey,
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
          ),
        ),
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
                  body: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: DefaultTabController(
                        length: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Your Feed",
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
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
