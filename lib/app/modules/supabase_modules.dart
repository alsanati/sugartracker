import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sugar_tracker/app/models/sugarData.dart';
import 'package:supabase/supabase.dart';
import 'package:sugar_tracker/app/pages/homepage.dart';
import 'package:sugar_tracker/constants.dart';

class SupabaseHelpers {
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

  Future<void> signIn(context, email) async {
    try {
      await supabase.auth.signInWithOtp(
        email: email,
        emailRedirectTo:
            kIsWeb ? null : 'io.supabase.flutterquickstart://login-callback/',
      );
    } on AuthException catch (error) {
      context.showErrorSnackBar(message: error.message);
    } catch (error) {
      context.showErrorSnackBar(message: 'Unexpected error occurred');
    }
  }

  Future<void> logout(context) async {
    await supabase.auth.signOut();
    Navigator.pushReplacementNamed(context, "login");
  }
}
