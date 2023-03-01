import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sugar_tracker/app/components/getSugarData.dart';
import 'package:sugar_tracker/app/components/sugarLevelCards.dart';

import 'state/homepage_state.dart';

class Homepage extends ConsumerWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(userProvider).when(
          loading: () => const CircularProgressIndicator(),
          error: (err, stack) {
            return Scaffold(
              body: Center(child: Text('$err')),
            );
          },
          data: (userProvider) {
            return Scaffold(
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              Text(
                                "Your history",
                                style: Theme.of(context).textTheme.titleMedium,
                              )
                            ],
                          ),
                        ],
                      ),
                      const Expanded(
                        flex: 2,
                        child: SugarDataListView(),
                      ),
                    ],
                  ),
                ),
              ),
              floatingActionButton: Align(
                alignment: Alignment.bottomRight,
                child: FloatingActionButton(
                  onPressed: () async {
                    await showModalBottomSheet<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return SizedBox(
                          height: 200,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: const <Widget>[
                                PostSugarLevels(),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                    // Refresh the data after closing the bottom sheet
                    return ref.refresh(sugarDataProvider);
                  },
                  child: const Icon(Icons.add),
                ),
              ),
            );
          },
        );
  }
}
