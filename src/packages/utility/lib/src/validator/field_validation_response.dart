import 'package:utility/src/validator/form_validator.dart';

/// [FieldValidationResponse] is the response of the [FormValidator] class.
/// It contains the [cause] of the exception and the [field]
/// that caused the error if [isValid] is false.
final class FieldValidationResponse {
  /// [FieldValidationResponse] is the constructor for [FieldValidationResponse]
  const FieldValidationResponse({
    this.isValid = true,
    this.cause,
    this.field,
  }) : assert(
          isValid || (cause != null && field != null),
          'cause and field cannot be null if isValid is false',
        );

  /// [FieldValidationResponse.valid] is a named constructor 
  /// for [FieldValidationResponse] to return a valid response.
  const FieldValidationResponse.valid()
      : isValid = true,
        cause = null,
        field = null;

  /// [FieldValidationResponse.empty] is a factory constructor 
  /// for [FieldValidationResponse] that returns an [FieldValidationResponse] 
  /// object representing an empty field error
  factory FieldValidationResponse.empty({
    required String field,
  }) {
    return FieldValidationResponse(
      isValid: false,
      cause: 'Field cannot be empty',
      field: field,
    );
  }

  /// [isValid] is a boolean that tells if the field is valid or not.
  final bool isValid;

  /// [cause] is the cause of the error.
  final String? cause;

  /// [field] is the field that caused the error.
  final String? field;
}
