import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:sugar_tracker/app/features/charts/components/charts.dart';
import 'package:sugar_tracker/app/features/dashboard/components/current_sugar_stats.dart';
import 'package:sugar_tracker/app/features/dashboard/components/diabetes_report.dart';
import 'package:sugar_tracker/app/features/dashboard/components/get_meal_data.dart';
import '../components/expandable_fab.dart';
import '../components/get_sugar_data.dart';
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
          appBar: AppBar(
              centerTitle: false,
              title: Text(
                "Hi, ${user.user} ",
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              actions: [
                IconButton(
                    icon: const FaIcon(FontAwesomeIcons.envelope),
                    onPressed: () {
                      GoRouter.of(context).go('/reportdialog');
                    })
              ]),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(child: GlucoseStats(sugardata: user.sugarData)),
                        const SizedBox(height: 20),
                        const TabBar(
                          tabs: [
                            Tab(icon: Icon(Icons.bar_chart)),
                            Tab(icon: Icon(Icons.summarize)),
                          ],
                        ),
                      ],
                    ),
                    const Expanded(
                      child: TabBarView(children: [
                        SingleChildScrollView(
                          // To enable scrolling if content overflows
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
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
                  onPressed: () {
                    // Call the bottom modal sheet here
                    showModalBottomSheet<void>(
                      context: context, // Pass the context here
                      isScrollControlled: true,
                      builder: (BuildContext context) {
                        return const SingleChildScrollView(
                          child: PostSugarLevelsBottomSheet(),
                        );
                      },
                    );
                  },
                  label: 'Add activities',
                  context: context, // Pass the context here
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
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom),
                            child: const MealBottomSheet(),
                          ),
                        );
                      },
                    );
                  },
                  label: "Add meals",
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
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom),
                            child: const PostSugarLevelsBottomSheet(),
                          ),
                        );
                      },
                    );
                  },
                  label: "Add sugar level",
                  context: context,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
