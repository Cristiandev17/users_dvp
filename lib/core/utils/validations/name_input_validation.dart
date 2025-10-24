import 'package:formz/formz.dart';

enum NameInputValidationError { empty, length }

// Extend FormzInput and provide the input type and error type.
class NameInputValidation extends FormzInput<String, NameInputValidationError> {
  // Call super.pure to represent an unmodified form input.
  const NameInputValidation.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const NameInputValidation.dirty(super.value) : super.dirty();

  String? get errorMessage {
    if (isValid || isPure) {
      return null;
    }

    if (error == NameInputValidationError.empty) {
      return 'El campo no puede estar vacio';
    }

    if (error == NameInputValidationError.length) {
      return 'El campo debe tener al menos 4 caracteres';
    }

    return null;
  }

  @override
  NameInputValidationError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) {
      return NameInputValidationError.empty;
    }

    if (value.length < 4) {
      return NameInputValidationError.length;
    }

    return null;
  }
}
