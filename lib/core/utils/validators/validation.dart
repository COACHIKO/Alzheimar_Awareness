import 'package:get/get.dart';

import '../constants/text_strings.dart';

class TValidator {

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return TTexts.emailRequired;
    }

    // Regular expression for email validation
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegExp.hasMatch(value)) {
      return TTexts.invalidAddress;
    }

    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return TTexts.passwordRequired;
    }
    // Check for spaces
    if (value.contains(RegExp(r'\s'))) {
      return TTexts.unAllowedSpaces;
    }
    // Check for minimum password length
    if (value.length < 6) {
      return TTexts.minimumSixLength;
    }

    // Check for uppercase letters
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return TTexts.minimumOneUppercaseLatter;
    }

    // Check for numbers
    if (!value.contains(RegExp(r'[0-9]'))) {
      return TTexts.minimumOneNumber;
    }

    // Check for special characters
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return TTexts.minimumOneSpecialCharacter;
    }



    return null;
  }

  static String? validatePhoneNumber(String? value) {
    if (value == null  || value.isEmpty) {
      return TTexts.phoneNumberRequired;
    }

    // Regular expression for phone number validation (assuming a 10-digit US phone number format)
    final phoneRegExp = RegExp(r'^\d{10}$');

    if (!phoneRegExp.hasMatch(value)) {
      return TTexts.invalidPhoneNumber;
    }

    return null;
  }

  static String? validateSsn(String? value) {
    if (value == null || value.isEmpty) {
      return TTexts.ssnRequired;
    }

    // Check if the value consists only of digits and has a length of 14
    if (value.length != 14 || !value.contains(RegExp(r'^\d+$'))) {
    return TTexts.invalidSsn;
    }

    return null;
  }

  static String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return TTexts.usernameRequired;
    }

    // Check if the username contains any whitespace
    if (value.contains(RegExp(r'\s'))) {
      return TTexts.unAllowedWhitespaces;
    }

    return null;
  }


// Add more custom validators as needed for your specific requirements.

}