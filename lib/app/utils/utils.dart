import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rive/rive.dart';
import 'package:sugar_tracker/app/features/dashboard/state/homepage_state.dart';
import 'package:sugar_tracker/app/modules/supabase_modules.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

extension SupabasePatient on SupabaseClient {
  SupabaseHelpers get patient => SupabaseHelpers(this);
}

class RiveTransition extends StatelessWidget {
  final Animation<double> animation;
  final Widget child;

  const RiveTransition(
      {super.key, required this.animation, required this.child});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) {
        // Use the animation value to control the Rive animation progress
        // You can replace 'animationName' with the name of your Rive animation
        return const RiveAnimation.network(
          '../assets/4188-9638-jump-on-the-trampoline.riv',
          fit: BoxFit.cover,
        );
      },
    );
  }
}

Future<String> loadMarkdownAsset(String string) async {
  return await rootBundle.loadString(string);
}

class MyMarkDownWidget extends ConsumerWidget {
  const MyMarkDownWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Consumer(builder: (BuildContext context, WidgetRef ref, _) {
      final reportAsyncValue = ref.watch(reportProvider);

      return reportAsyncValue.when(
        data: (String data) => Markdown(data: data),
        loading: () => const Center(
            child: SizedBox(
                height: 50, width: 50, child: CircularProgressIndicator())),
        error: (error, stack) => Center(
          child: Text('Error: $error'),
        ),
      );
    });
  }
}
