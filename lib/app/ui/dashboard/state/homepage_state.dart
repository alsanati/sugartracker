import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sugar_tracker/constants.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final userProvider = FutureProvider((ref) async {
  try {
    final userId = supabase.auth.currentUser!.id;
    final data = await supabase
        .from('profiles')
        .select()
        .eq('id', userId)
        .single() as Map;
    String username = (data['username'] ?? '') as String;
    return username;
  } on PostgrestException catch (error) {
    debugPrint(error.message);
    rethrow;
  } catch (error) {
    debugPrint('Unexpected exception occurred');
    rethrow;
  }
});
