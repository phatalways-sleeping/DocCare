import 'package:utility/src/validator/field_validation_response.dart';

/// [FormValidator] is a class that contains all the form validation methods.
class FormValidator {
  const FormValidator._();
  /// [validateEmail] is a method that validates the email address.
  /// It returns a [FieldValidationResponse]
  static FieldValidationResponse validateEmail(String email) {
    if (email.isEmpty) {
      return FieldValidationResponse.empty(field: 'Email');
    }

    // Regex for email validation
    final regEx =
        RegExp(r'^[a-zA-Z0-9.a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$');

    // Check if the email is valid
    if (regEx.hasMatch(email)) {
      return const FieldValidationResponse.valid();
    }

    return const FieldValidationResponse(
      isValid: false,
      cause: 'Your email contains invalid characters',
      field: 'Email',
    );
  }

  /// [validatePassword] is a method that validates the password.
  /// It returns a [FieldValidationResponse]
  static FieldValidationResponse validatePassword(String password) {
    if (password.isEmpty) {
      return FieldValidationResponse.empty(field: 'Password');
    }

    // Check if length of password is greater than 6
    if (password.length < 6) {
      return const FieldValidationResponse(
        isValid: false,
        cause: 'Password must be at least 6 characters long',
        field: 'Password',
      );
    }

    // Check if password contains at least one uppercase letter
    if (!password.contains(RegExp('[A-Z]'))) {
      return const FieldValidationResponse(
        isValid: false,
        cause: 'Password must contain at least one uppercase letter',
        field: 'Password',
      );
    }

    // Check if password contains at least one lowercase letter
    if (!password.contains(RegExp('[a-z]'))) {
      return const FieldValidationResponse(
        isValid: false,
        cause: 'Password must contain at least one lowercase letter',
        field: 'Password',
      );
    }

    // Check if password contains at least one digit
    if (!password.contains(RegExp('[0-9]'))) {
      return const FieldValidationResponse(
        isValid: false,
        cause: 'Password must contain at least one digit',
        field: 'Password',
      );
    }

    // Check if password contains at least one special character
    if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return const FieldValidationResponse(
        isValid: false,
        cause: 'Password must contain at least one special character',
        field: 'Password',
      );
    }

    return const FieldValidationResponse.valid();
  }

  /// [validateName] is a method that validates the name.
  /// It returns a [FieldValidationResponse]
  static FieldValidationResponse validateName(String name) {
    if (name.isEmpty) {
      return FieldValidationResponse.empty(field: 'Name');
    }

    // Check if name contains only alphabets
    if (!name.contains(RegExp('[a-zA-Z]'))) {
      return const FieldValidationResponse(
        isValid: false,
        cause: 'Name must contain only alphabets',
        field: 'Name',
      );
    }

    return const FieldValidationResponse.valid();
  }

  /// [validatePhoneNumber] is a method that validates the phone number.
  /// It returns a [FieldValidationResponse]
  static FieldValidationResponse validatePhoneNumber(String phoneNumber) {
    if (phoneNumber.isEmpty) {
      return FieldValidationResponse.empty(field: 'Phone Number');
    }

    // Check if phone number contains only digits
    if (!phoneNumber.contains(RegExp('[0-9]'))) {
      return const FieldValidationResponse(
        isValid: false,
        cause: 'Phone Number must contain only digits',
        field: 'Phone Number',
      );
    }

    // Check if phone number is 10 digits long
    if (phoneNumber.length != 10) {
      return const FieldValidationResponse(
        isValid: false,
        cause: 'Phone Number must be 10 digits long',
        field: 'Phone Number',
      );
    }

    return const FieldValidationResponse.valid();
  }

  /// [validateDate] is a method that validates the date.
  /// It returns a [FieldValidationResponse]
  static FieldValidationResponse validateDate(String date, {
    bool birthDateValidation = true,
  }) {
    if (date.isEmpty) {
      return FieldValidationResponse.empty(field: 'Date');
    }

    // Check if date is in the format dd/mm/yyyy
    if (!date.contains(RegExp(r'^\d{1,2}\/\d{1,2}\/\d{4}$'))) {
      return const FieldValidationResponse(
        isValid: false,
        cause: 'Date must be in the format dd/mm/yyyy',
        field: 'Date',
      );
    }

    if (birthDateValidation) {
      try {
        final dateParts = date.split('/');
        final day = int.parse(dateParts[0]);
        final month = int.parse(dateParts[1]);
        final year = int.parse(dateParts[2]);

        final processDate = DateTime(year, month, day);

        if (processDate.isAfter(DateTime.now())) {
          return const FieldValidationResponse(
            isValid: false,
            cause: 'Date cannot be in the future',
            field: 'Date',
          );
        }
      } catch (e) {
        return const FieldValidationResponse(
          isValid: false,
          cause: 'Date is invalid',
          field: 'Date',
        );
      }
    }

    return const FieldValidationResponse.valid();
  }
}
