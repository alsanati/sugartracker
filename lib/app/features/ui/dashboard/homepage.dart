import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sugar_tracker/app/components/getSugarData.dart';
import 'package:sugar_tracker/app/components/sugarLevelCards.dart';
import 'package:sugar_tracker/app/ui/auth/account_page.dart';

import '../../../main.dart';
import 'state/homepage_state.dart';

class Homepage extends ConsumerWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final RenderBox box = context.findRenderObject() as RenderBox;
    final Offset position = box.localToGlobal(Offset.zero);

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
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    CustomRoute(
                                      builder: (context) => AccountPage(),
                                    ),
                                  );
                                },
                                child: Text('Go to Second Route'),
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
                  onPressed: () {
                    Navigator.push(
                      context,
                      CustomRoute(
                        builder: (context) => AccountPage(),
                      ),
                    );
                  },
                  child: const Icon(Icons.add),
                ),
              ),
            );
          },
        );
  }
}
