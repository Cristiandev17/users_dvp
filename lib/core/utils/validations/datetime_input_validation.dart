import 'package:formz/formz.dart';
import 'package:users_dvp_app/core/constants/app_message.dart';

enum DateTimeInputValidationError { empty, invalidFormat }

// Extend FormzInput and provide the input type and error type.
class DateTimeInputValidation extends FormzInput<String, DateTimeInputValidationError> {
  // Call super.pure to represent an unmodified form input.
  const DateTimeInputValidation.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const DateTimeInputValidation.dirty(super.value) : super.dirty();

  String? get errorMessage {
    if (isValid || isPure) {
      return null;
    }

    if (error == DateTimeInputValidationError.empty) {
      return AppMessage.messageEmpty;
    }

    return null;
  }

  @override
  DateTimeInputValidationError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) {
      return DateTimeInputValidationError.empty;
    }

    return null;
  }
}
