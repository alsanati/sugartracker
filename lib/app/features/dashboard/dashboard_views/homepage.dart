import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sugar_tracker/app/features/charts/components/charts.dart';
import 'package:sugar_tracker/app/features/dashboard/components/current_sugar_stats.dart';
import 'package:sugar_tracker/app/features/dashboard/components/diabetes_report.dart';
import 'package:sugar_tracker/app/features/dashboard/components/sugar_level_cards.dart';
import '../components/expandable_fab.dart';
import '../state/homepage_state.dart';

class Homepage extends ConsumerWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homepageState = ref.watch(homePageProvider);

    return homepageState.when(
      loading: () => const Center(
        child:
            SizedBox(width: 50, height: 50, child: CircularProgressIndicator()),
      ),
      error: (err, stack) {
        return Scaffold(
          body: Center(child: Text('$err')),
        );
      },
      data: (user) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: DefaultTabController(
                length: 3,
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hi, ${user.user} ",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Center(child: GlucoseStats(sugardata: user.sugarData)),
                        const SizedBox(height: 20),
                        const TabBar(
                          tabs: [
                            Tab(icon: Icon(Icons.bar_chart)),
                            Tab(icon: Icon(Icons.summarize)),
                            Tab(icon: Icon(Icons.telegram)),
                          ],
                        ),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(children: [
                        SugarDataListView(sugarData: user.sugarData, ref: ref),
                        const DiabetesReport(),
                        SingleChildScrollView(
                          // To enable scrolling if content overflows
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                SizedBox(height: 20),
                                Chart(days: 7, titleText: "Last 7 days"),
                                SizedBox(height: 20),
                                Chart(
                                  days: 14,
                                  titleText: "Last 14 days",
                                ),
                                SizedBox(height: 20),
                                Chart(
                                  days: 30,
                                  titleText: "Last 30 days",
                                )
                              ],
                            ),
                          ),
                        ),
                      ]),
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
                  onPressed: () => GoRouter.of(context).go("/home/sugarlevels"),
                  label: 'Track sugar',
                ),
                ActionButton(
                  onPressed: () => GoRouter.of(context).go("/home/sugarlevels"),
                  label: 'Track medication',
                ),
                ActionButton(
                  onPressed: () => GoRouter.of(context).go("/home/sugarlevels"),
                  label: 'Track carbs',
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
