import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:sugar_tracker/app/features/charts/components/charts.dart';
import 'package:sugar_tracker/app/features/dashboard/components/current_sugar_stats.dart';
import 'package:sugar_tracker/app/features/dashboard/components/get_meal_data.dart';
import 'package:sugar_tracker/app/features/dashboard/components/streak_counter.dart';
import 'package:sugar_tracker/app/features/dashboard/dashboard_views/get_meal_stats.dart';
import '../components/expandable_fab.dart';
import '../components/get_sugar_data.dart';
import '../state/homepage_state.dart';

class Homepage extends ConsumerWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chartPageController = PageController();
    final statsPageController = PageController();

    final homepageState = ref.watch(homePageProvider);

    return homepageState.when(
      loading: () => const Center(
        child: SizedBox(
          width: 50,
          height: 50,
          child: CircularProgressIndicator(),
        ),
      ),
      error: (err, stack) {
        return Scaffold(
          body: Center(child: Text('$err')),
        );
      },
      data: (user) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Hi, ${user.user} ",
              textAlign: TextAlign.start,
            ),
            actions: [
              const StreakCounter(),
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: IconButton(
                  icon: const FaIcon(FontAwesomeIcons.envelope),
                  onPressed: () {
                    GoRouter.of(context).go('/reportdialog');
                  },
                ),
              ),
            ],
          ),
          body: SafeArea(
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 14, top: 14),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      "Dashboard",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 14.0, right: 14),
                  child: SizedBox(
                    height: 200,
                    child: PageView(
                      controller: statsPageController,
                      children: [
                        GlucoseStats(sugardata: user.sugarData),
                        NutritionStats(mealsData: user.meals),
                      ],
                      onPageChanged: (index) {
                        HapticFeedback
                            .lightImpact(); // Add a little feedback on page change to make it more lively.
                      },
                    ),
                  ),
                ),
                SmoothPageIndicator(
                  controller: statsPageController,
                  count: 2,
                  effect: WormEffect(
                    dotColor: Theme.of(context).colorScheme.onTertiaryContainer,
                    activeDotColor:
                        Theme.of(context).colorScheme.tertiaryContainer,
                    dotHeight: 7,
                    dotWidth: 10,
                  ),
                  onDotClicked: (index) {
                    statsPageController.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.ease,
                    );
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 28, right: 28, bottom: 28, top: 10),
                  child: Center(
                    child: SizedBox(
                      height: 250,
                      width: 400,
                      child: PageView(
                        scrollDirection: Axis.horizontal,
                        controller: chartPageController,
                        children: [
                          Center(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .tertiaryContainer,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              width: 400,
                              child: const Chart(
                                  days: 7, titleText: "Last 7 days"),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .tertiaryContainer,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            width: 380,
                            child: const Chart(
                                days: 14, titleText: "Last 14 days"),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .tertiaryContainer,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            width: 400,
                            child: const Chart(
                                days: 30, titleText: "Last 30 days"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12, right: 12),
                  child: SmoothPageIndicator(
                    controller: chartPageController,
                    count: 3,
                    effect: ExpandingDotsEffect(
                      dotColor:
                          Theme.of(context).colorScheme.onTertiaryContainer,
                      activeDotColor:
                          Theme.of(context).colorScheme.tertiaryContainer,
                      dotHeight: 7,
                      dotWidth: 10,
                    ),
                    onDotClicked: (index) {
                      chartPageController.animateToPage(
                        index,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.ease,
                      );
                    },
                  ),
                ),
              ],
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
                        return SingleChildScrollView(
                          child: Text("ji"),
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
                              bottom: MediaQuery.of(context).viewInsets.bottom,
                            ),
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
                              bottom: MediaQuery.of(context).viewInsets.bottom,
                            ),
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
