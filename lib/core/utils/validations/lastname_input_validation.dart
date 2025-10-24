import 'package:formz/formz.dart';
import 'package:users_dvp_app/core/constants/app_message.dart';

enum LastnameInputValidationError { empty, length }

// Extend FormzInput and provide the input type and error type.
class LastnameInputValidation extends FormzInput<String, LastnameInputValidationError> {
  // Call super.pure to represent an unmodified form input.
  const LastnameInputValidation.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const LastnameInputValidation.dirty(super.value) : super.dirty();

  String? get errorMessage {
    if (isValid || isPure) {
      return null;
    }

    if (error == LastnameInputValidationError.empty) {
      return AppMessage.messageEmpty;
    }

    if (error == LastnameInputValidationError.length) {
      return AppMessage.messageErrorLength;
    }

    return null;
  }

  @override
  LastnameInputValidationError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) {
      return LastnameInputValidationError.empty;
    }

    if (value.length < 4) {
      return LastnameInputValidationError.length;
    }

    return null;
  }
}
