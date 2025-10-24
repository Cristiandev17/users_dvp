import 'package:formz/formz.dart';

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
      return 'El campo no puede estar vacio';
    }

    if (error == LastnameInputValidationError.length) {
      return 'El campo debe tener al menos 4 caracteres';
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
