import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase/supabase.dart';
import 'package:sugar_tracker/constants.dart';

class SupabaseHelpers with ChangeNotifier {
  Future getSugarData() async {
    final response = await supabase
        .from('diabetes_sugar')
        .select()
        .eq('personId', supabase.auth.currentUser!.id)
        .order('created_at', ascending: false);
    return response;
  }

  Future<void> signUpUser(context, email, password) async {
    debugPrint("email: $email password: $password");

    try {
      final response = await supabase.auth.signUp(
        email: email!,
        password: password!,
      );

      if (response.user != null) {
        context.showErrorSnackBar(
            message: "Registration successful!", isError: false);
        Navigator.pushReplacementNamed(context, "login");
      }
    } on AuthException catch (error) {
      context.showErrorSnackBar(message: error.message);
    } catch (error) {
      context.showErrorSnackBar(message: 'Unexpected error occurred');
    }
  }

  Future signInWithPassword(
      GlobalKey<FormState> formkey, email, password) async {
    try {
      final AuthResponse response = await supabase.auth.signInWithPassword(
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
