import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sugar_tracker/app/models/activities.dart';
import 'package:sugar_tracker/app/utils/utils.dart';
import 'package:sugar_tracker/app/utils/constants.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:intl/intl.dart';

import '../models/sign_up.dart';
import '../models/sugar_data.dart';

class SupabaseHelpers {
  final SupabaseClient supabaseClient;

  SupabaseHelpers(this.supabaseClient);

  Future<void> signInWithGoogle() async {
    await supabase.auth.signInWithOAuth(Provider.google);
  }

  Future<List<SugarData>> getSugarData() async {
    final response = await supabase
        .from('diabetes_sugar')
        .select()
        .eq('personId', supabase.auth.currentUser!.id)
        .order('created_at', ascending: false);

    List<SugarData> sugarLevels = SugarData.getListMap(response);
    return sugarLevels;
  }

  Future<void> upload(
      String tableName, Object payload, BuildContext context) async {
    try {
      final response = await supabase.from(tableName).insert(payload);
      if (response != null) {
        if (context.mounted) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Upload successful")));
        }
      }
    } catch (error) {
      debugPrint(error.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Unexpected error occured :()"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<List<SugarData>> fetchDiabetesData() async {
    // Get today's date formatted as yyyy-MM-dd
    String today = DateFormat('yyyy-MM-dd').format(DateTime.now());

    // Fetch data from Supabase with a filter for today's date
    final response = await supabase
        .from('diabetes_sugar')
        .select()
        .filter('created_at', 'gte', today);

    List<SugarData> sugarLevels = SugarData.getListMap(response);

    // Use the first row of data for this example
    return sugarLevels;
  }

  Future<String> getCurrentUser() async {
    try {
      final userId = supabase.auth.currentUser!.id;
      final data = await supabase
          .from('patient')
          .select()
          .eq('patient_id', userId)
          .single() as Map;
      String username = (data['first_name'] ?? '') as String;
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
          GoRouter.of(context).go("/stepper");
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

  Future getCurrentPatientId() async {
    try {
      final userId = supabase.auth.currentUser?.id;
      final response = await supabase
          .from('patient')
          .select('id')
          .eq('patient_id', userId)
          .single();

      if (response != null) {
        return response != null && response.isNotEmpty ? response['id'] : null;
      } else {
        debugPrint('Error fetching current patient ID: ${response.error}');
        return null;
      }
    } catch (e) {
      debugPrint('Error fetching current patient ID: $e');
      return null;
    }
  }

  Future<PatientData> fetchPatientData() async {
    final patientId = await getCurrentPatientId();
    final response =
        await supabase.from('patient').select().eq('id', patientId).single();
    if (response != null) {
      Map<String, dynamic> patientDataMap = response as Map<String, dynamic>;
      return PatientData(
        firstName: patientDataMap['first_name'] ?? '',
        lastName: patientDataMap['last_name'] ?? '',
        birthday: patientDataMap['birthday'] ?? '',
        accountId: patientDataMap['account_id'] ?? 0,
      );
    } else {
      debugPrint('Error fetching patient data: ${response.error}');
    }

    return PatientData(
      firstName: '',
      lastName: '',
      birthday: '',
      accountId: 0,
    );
  }

  Future<void> logout(context) async {
    await supabase.auth.signOut();
    GoRouter.of(context).go("/login");
  }

  Future<void> insertPatientData(
      String firstName,
      String lastName,
      String address,
      DateTime birthday,
      String city,
      String street,
      String country,
      int postalCode,
      int phone,
      String email) async {
    User userId = supabase.auth.currentUser!;

    // Insert data into the patient table
    final List<Map<String, dynamic>> patientResponse =
        await supabase.from('patient').insert([
      {
        'first_name': firstName,
        'last_name': lastName,
        'birthday': birthday.toString(),
        'patient_id': userId.id
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

  Future<void> addActivity(
      Activities newActivity, BuildContext context, String notes) async {
    // Retrieve patient id if available in the context

    // Now we insert the new activity
    await supabase.from('acitivity').insert({
      'patient_id': await supabase.patient.getCurrentPatientId(),
      'activity_type': newActivity.activity_type,
      'duration': newActivity.duration,
      'intensity': newActivity.intensity,
      'notes': notes,
    });

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        showCloseIcon: true,
        content: Text("Registration successful"),
        backgroundColor: Colors.greenAccent,
      ));
    }
  }
}
