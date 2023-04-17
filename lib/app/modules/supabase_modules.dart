import 'package:flutter/material.dart';
import 'package:sugar_tracker/app/utils/utils.dart';
import 'package:sugar_tracker/app/utils/constants.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseHelpers {
  Future getSugarData() async {
    final response = await supabase
        .from('diabetes_sugar')
        .select()
        .eq('personId', supabase.auth.currentUser!.id)
        .order('created_at', ascending: false);
    return response;
  }

  Future<String> getCurrentUser() async {
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
  }

  Future<void> signUpUser(BuildContext context, email, password) async {
    debugPrint("email: $email password: $password");
    try {
      final response = await supabase.auth.signUp(
        email: email!,
        password: password!,
      );

      if (response.user != null) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Registration successful"),
            backgroundColor: Colors.green,
          ));
          context.go(NavigationHelper.stepperPage);
        }
      }
    } on AuthException catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.message), backgroundColor: Colors.red),
      );
    } catch (error) {
      debugPrint(error.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("unexpected error occured"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future signInWithPassword(
      GlobalKey<FormState> formkey, email, password) async {
    try {
      await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
    } on AuthException catch (error) {
      formkey.currentState?.context.showErrorSnackBar(message: error.message);
    } catch (error) {
      formkey.currentState?.context
          .showErrorSnackBar(message: "unexpected error brah");
    }
  }

  Future<void> logout(context) async {
    await supabase.auth.signOut();
    Navigator.pushReplacementNamed(context, "login");
  }
}
