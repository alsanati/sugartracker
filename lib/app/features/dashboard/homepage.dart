import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sugar_tracker/app/features/dashboard/components/current_sugar_stats.dart';
import 'package:sugar_tracker/app/features/dashboard/components/sugar_level_cards.dart';
import 'state/homepage_state.dart';

class Homepage extends ConsumerWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final currentSugarData = ref.watch(getCurrentSugarDataStats);
    final sugarData = ref.watch(sugarDataProvider);

    return user.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) {
        return Scaffold(
          body: Center(child: Text('$err')),
        );
      },
      data: (userProvider) {
        return RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(sugarDataProvider);
            ref.invalidate(getCurrentSugarDataStats);
          },
          child: Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hi, $userProvider",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Center(
                            child: GlucoseStats(sugardata: currentSugarData)),
                      ],
                    ),
                    Expanded(
                      flex: 2,
                      child: SugarDataListView(sugarData: sugarData),
                    ),
                  ],
                ),
              ),
            ),
            floatingActionButton: Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                onPressed: () {
                  GoRouter.of(context).go("/home/sugarlevels");
                },
                child: const Icon(Icons.add),
              ),
            ),
          ),
        );
      },
    );
  }
}
