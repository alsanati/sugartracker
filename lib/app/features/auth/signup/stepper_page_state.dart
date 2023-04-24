import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sugar_tracker/app/models/sign_up.dart';

import '../../../modules/supabase_modules.dart';
import '../../../utils/constants.dart';

final supabaseHelper = SupabaseHelpers();

final selectedDateProvider = StateProvider<DateTime>((ref) {
  return DateTime.now();
});

final diabetesTypeProvider = StateProvider<String>((ref) {
  return 'Type 1';
});

Future<void> _submitData(WidgetRef ref) async {
  // Create a UserData instance
  final patientData = PatientData(
      firstName: "firstName",
      lastName: "lastName",
      birthday: "birthday",
      accountId: 123);

  final patientAddress = PatientAddress(
      use: "use",
      line: "line",
      city: "city",
      postalCode: 123,
      country: "country",
      patientId: 123);

  final patientTelecom = PatientTelecom(
      system: "system", value: "value", use: "use", patientId: 123);

  // Upload data to all three databases concurrently
  final results = await Future.wait([
    uploadPatientData(patientData),
    uploadPatientAddressData(patientAddress),
    uploadPatientTelecomData(patientTelecom),
  ]);

  // Check the results of each upload
  for (int i = 0; i < results.length; i++) {
    if (results[i]) {
      if (kDebugMode) {
        debugPrint('Data added successfully to database ${i + 1}');
      }
    } else {
      if (kDebugMode) {
        debugPrint('Error adding data to database ${i + 1}');
      }
    }
  }
}

Future<bool> uploadPatientData(PatientData patientData) async {
  try {
    final response = await supabase.from('patient_data').insert(patientData);

    if (response.error == null) {
      print('PatientData added successfully');
      return true;
    } else {
      print('Error adding PatientData: ${response.error!.message}');
      return false;
    }
  } catch (e) {
    print('Exception adding PatientData: $e');
    return false;
  }
}

Future<bool> uploadPatientAddressData(PatientAddress patientAddress) async {
  try {
    final response =
        await supabase.from('patient_address').insert(patientAddress);

    if (response.error == null) {
      debugPrint('PatientAddress added successfully');
      return true;
    } else {
      debugPrint('Error adding PatientAddress: ${response.error!.message}');
      return false;
    }
  } catch (e) {
    debugPrint('Exception adding PatientAddress: $e');
    return false;
  }
}

Future<bool> uploadPatientTelecomData(PatientTelecom patientTelecom) async {
  try {
    final response =
        await supabase.from('patient_telecom').insert(patientTelecom);

    if (response.error == null) {
      debugPrint('PatientTelecom added successfully');
      return true;
    } else {
      debugPrint('Error adding PatientTelecom: ${response.error!.message}');
      return false;
    }
  } catch (e) {
    debugPrint('Exception adding PatientTelecom: $e');
    return false;
  }
}
