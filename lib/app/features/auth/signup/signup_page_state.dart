import 'package:flutter/material.dart';

class PasswordValidator with ChangeNotifier {
  String? _passwordError;

  String? get passwordError => _passwordError;

  void validatePassword(String password) {
    if (password.length < 12) {
      _passwordError = 'Password must be at least 12 characters long';
    } else if (!_containsLowercaseLetter(password)) {
      _passwordError = 'Password must contain at least one lowercase letter';
    } else if (!_containsUppercaseLetter(password)) {
      _passwordError = 'Password must contain at least one uppercase letter';
    } else if (_isCommonPassword(password)) {
      _passwordError = 'Avoid using common passwords or patterns';
    } else if (_containsPersonalInformation(password)) {
      _passwordError = 'Avoid using personal information in your password';
    } else {
      _passwordError = null;
    }
    notifyListeners();
  }

  bool _containsLowercaseLetter(String password) {
    return password.contains(RegExp(r'[a-z]'));
  }

  bool _containsUppercaseLetter(String password) {
    return password.contains(RegExp(r'[A-Z]'));
  }

  bool _isCommonPassword(String password) {
    final commonPasswords = [
      'password',
      '123456',
      'qwerty',
      'admin',
      // Add more common passwords as needed
    ];

    return commonPasswords.contains(password.toLowerCase());
  }

  bool _containsPersonalInformation(String password) {
    final personalInformation = [
      'birthday',
      'name',
      'username',
      'social media handle',
      // Add more personal information keywords as needed
    ];

    for (final keyword in personalInformation) {
      if (password.toLowerCase().contains(keyword)) {
        return true;
      }
    }

    return false;
  }
}
