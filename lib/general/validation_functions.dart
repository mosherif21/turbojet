import 'package:get/get.dart';

String? validateTextOnly(String? value) {
  if (value == null || value.isEmpty) {
    return 'This can\'t be empty';
  }
  final isCharactersOnly = RegExp(r'^[a-zA-Z\u0600-\u06FF ]+$').hasMatch(value);
  if (!isCharactersOnly) {
    return 'You can\'t use special characters here';
  }
  return null;
}

String? textNotEmpty(String? value) {
  if (value == null || value.isEmpty) {
    return 'This can\'t be empty';
  }
  return null;
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Password is required';
  }
  if (value.length < 8) {
    return 'Password must be at least 8 characters long';
  }
  if (!value.contains(RegExp(r'[A-Z]'))) {
    return 'Password must contain at least one uppercase letter';
  }
  if (!value.contains(RegExp(r'[0-9]'))) {
    return 'Password must contain at least one number';
  }
  return null;
}

String? validateEmail(String? email) {
  if (email == null || email.isEmpty) {
    return 'Email is required';
  } else if (!GetUtils.isEmail(email)) {
    return 'Please enter a valid email';
  }
  return null;
}
