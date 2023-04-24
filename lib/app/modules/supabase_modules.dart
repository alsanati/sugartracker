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

  Future<void> insertPatientData(
      String firstName,
      String lastName,
      String address,
      String birthday,
      String city,
      String street,
      String postalCode,
      String phone,
      String email) async {
    // Insert data into the patient table
    final patientResponse = await supabase.from('patient').insert([
      {'first_name': firstName, 'last_name': lastName, "birthday": birthday}
    ]);

    if (patientResponse.error != null) {
      throw patientResponse.error!;
    }

    final patientData = patientResponse.data;

    // Insert data into the patient_address table
    final addressResponse = await supabase.from('patient_address').insert([
      {
        'patient_id': patientData[0]['id'],
        'use': "home",
        'line': street,
        'city': city,
        'postal_code': postalCode,
        'acccount_id': supabase.auth.currentUser
      }
    ]);

    if (addressResponse.error != null) {
      throw addressResponse.error!;
    }

    // Insert data into the telecom table
    final telecomResponse = await supabase.from('telecom').insert([
      {
        'patient_id': patientData[0]['id'],
        'system': "email",
        'value': email,
        'use': "home"
      }
    ]);

    if (telecomResponse.error != null) {
      throw telecomResponse.error!;
    }
  }
}
