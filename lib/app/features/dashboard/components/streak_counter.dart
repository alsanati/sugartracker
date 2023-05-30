import 'package:flutter/material.dart';
import 'package:sugar_tracker/app/utils/constants.dart';

class StreakCounter extends StatefulWidget {
  const StreakCounter({
    Key? key,
  }) : super(key: key);

  @override
  _StreakCounterState createState() => _StreakCounterState();
}

class _StreakCounterState extends State<StreakCounter>
    with WidgetsBindingObserver {
  int streakCount = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    loadStreak();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    print(state);
    if (state == AppLifecycleState.resumed) {
      updateStreak();
    }
  }

  void loadStreak() async {
    final response =
        await supabase.from('streaks').select().eq('user_id', 29).single();

    final data = response as Map<String, dynamic>;
    setState(() {
      streakCount = data['streak_count'] as int;
    });
  }

  void updateStreak() async {
    final response = await supabase
        .from('streaks')
        .select('last_open_date')
        .eq('user_id', 29)
        .single();

    final data = response as Map<String, dynamic>;
    final lastOpenDate = DateTime.parse(data['last_open_date'] as String);

    if (DateTime.now().difference(lastOpenDate).inDays >= 1) {
      streakCount++;
      await supabase.from('streaks').update({
        'streak_count': streakCount,
        'last_open_date': DateTime.now().toIso8601String()
      }).eq('user_id', 29);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text('$streakCount 🔥',
        style: Theme.of(context).textTheme.labelSmall);
  }
}
