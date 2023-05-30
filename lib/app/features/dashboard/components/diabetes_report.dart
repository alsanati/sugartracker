import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sugar_tracker/app/utils/utils.dart';

final dialogShownProvider =
    StateNotifierProvider<DialogNotifier, bool>((ref) => DialogNotifier());

class DialogNotifier extends StateNotifier<bool> {
  DialogNotifier() : super(false);

  void showDialog(bool value) {
    state = value;
  }
}

class ConfirmationPage extends ConsumerWidget {
  const ConfirmationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dialogShown = ref.watch(dialogShownProvider);

    return WillPopScope(
      onWillPop: () async {
        ref.read(dialogShownProvider.notifier).showDialog(false);
        GoRouter.of(context).go('/home');
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                GoRouter.of(context).go('/home');
              },
              icon: const Icon(Icons.arrow_back)),
          title: const Text("Diabetes Report"),
        ),
        body: SafeArea(
          child: Center(
            child: dialogShown
                ? const MyMarkDownWidget()
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Do you agree to create the diabetes report?'),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              ref
                                  .read(dialogShownProvider.notifier)
                                  .showDialog(false);
                              GoRouter.of(context).go('/home');
                            },
                            child: const Text('Cancel'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              ref
                                  .read(dialogShownProvider.notifier)
                                  .showDialog(true);
                            },
                            child: const Text('Agree'),
                          ),
                        ],
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
