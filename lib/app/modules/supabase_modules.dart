import 'package:flutter/material.dart';
import 'package:sugar_tracker/app/features/auth/signup/stepper_page_state.dart';
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
          .showErrorSnackBar(message: "unexpected error");
    }
  }

  Future<void> logout(context) async {
    await supabase.auth.signOut();
    Navigator.pushReplacementNamed(context, "login");
  }

  Future<void> insertPatientData(
      String firstName,
      String lastName,
      String address,
      String birthday,
      String city,
      String street,
      String country,
      int postalCode,
      int phone,
      String email) async {
    // Insert data into the patient table
    final List<Map<String, dynamic>> patientResponse =
        await supabase.from('patient').insert([
      {
        'first_name': firstName,
        'last_name': lastName,
        'birthday': birthday,
        'account_id': supabaseHelper.getCurrentUser()
      }
    ]).select();

    debugPrint(patientResponse[0][0]);

    // Insert data into the patient_address table
    await supabase.from('patient_address').insert([
      {
        'patient_id': patientResponse[0]['id'],
        'use': "home",
        'line': street,
        'city': city,
        'postal_code': postalCode,
        'country': country
      }
    ]);

    // Insert data into the telecom table
    await supabase.from('telecom').insert([
      {
        'patient_id': patientResponse[0]['id'],
        'system': "email",
        'value': email,
        'use': "home"
      }
    ]);
  }
}
