import 'package:flutter/cupertino.dart';

class PatientData {
  final String firstName;
  final String lastName;
  final String birthday;
  final num accountId;

  PatientData(
      {required this.firstName,
      required this.lastName,
      required this.birthday,
      required this.accountId});
}

class PatientAddress {
  final String use;
  final String line;
  final String city;
  final num postalCode;
  final String country;
  final num patientId;

  PatientAddress(
      {required this.use,
      required this.line,
      required this.city,
      required this.postalCode,
      required this.country,
      required this.patientId});
}

class PatientTelecom {
  final String system;
  final String value;
  final String use;
  final num patientId;

  PatientTelecom(
      {required this.system,
      required this.value,
      required this.use,
      required this.patientId});
}

class FormControllers {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController birthdayController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController cityCodeController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
}
