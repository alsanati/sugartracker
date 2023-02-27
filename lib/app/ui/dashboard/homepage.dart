import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sugar_tracker/app/components/posts.dart';
import 'package:sugar_tracker/app/components/getSugarData.dart';

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
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(12),
                    ),
                    Column(
                      children: const [PostSugarLevels(), Posts()],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
