import 'package:dart_mediatr/dart_mediatr.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:users_dvp_app/core/constants/app_message.dart';
import 'package:users_dvp_app/core/failures/failure.dart';
import 'package:users_dvp_app/core/utils/mixins/state_updater_mixin.dart';
import 'package:users_dvp_app/core/utils/validations/datetime_input_validation.dart';
import 'package:users_dvp_app/core/utils/validations/lastname_input_validation.dart';
import 'package:users_dvp_app/core/utils/validations/name_input_validation.dart';
import 'package:users_dvp_app/domain/models/address_model.dart';
import 'package:users_dvp_app/domain/models/user_model.dart';
import 'package:users_dvp_app/features/user/commands/create_user_command.dart';

part 'add_user_state.dart';

class AddUserCubit extends Cubit<AddUserState> with StateUpdaterMixin<AddUserState> {
  final Mediator _mediator;

  AddUserCubit(this._mediator) : super(AddUserState());

  Future<void> onSubmittedUser() async {
    _markFieldAsDirty();

    if (!state.isValid) {
      emit(state.copyWith(status: FormStatus.error));
      return;
    }

    final user = UserModel.builder()
        .setName(state.name.value)
        .setLastName(state.lastName.value)
        .setBirthDate(state.birthDate.value)
        .addAddresses(state.addresses)
        .build();

    final result = await _mediator.sendCommand<CreateUserCommand, Future<Result<bool>>>(
      CreateUserCommand(user: user),
    );

    if (result.isSuccess) {
      emit(state.copyWith(status: FormStatus.success, message: AppMessage.userSavedSuccess));
    } else {
      emit(state.copyWith(status: FormStatus.failure, message: result.failure!.message));
    }
  }

  void onAddressChanged() {
    final address = AddressModel.builder()
        .setCity(state.city)
        .setCountry(state.country)
        .setDepartment(state.department)
        .setComplement(state.complement)
        .build();
    final newAddresses = [...state.addresses, address];
    updateState(
      newAddresses,
      (state) => state.addresses,
      (state, newAddresses) => state.copyWith(addresses: newAddresses),
    );
  }

  void onNameChanged(String value) {
    final name = NameInputValidation.dirty(value);
    updateState(
      name,
      (state) => state.name,
      (state, name) => state.copyWith(
        name: name,
        isValid: Formz.validate([name, state.lastName, state.birthDate]),
      ),
    );
  }

  void onLastNameChanged(String value) {
    final lastName = LastnameInputValidation.dirty(value);
    updateState(
      lastName,
      (state) => state.lastName,
      (state, lastName) => state.copyWith(
        lastName: lastName,
        isValid: Formz.validate([lastName, state.name, state.birthDate]),
      ),
    );
  }

  void onBirthDateChanged(String value) {
    final birthDate = DateTimeInputValidation.dirty(value);
    updateState(
      birthDate,
      (state) => state.birthDate,
      (state, birthDate) => state.copyWith(
        birthDate: birthDate,
        isValid: Formz.validate([birthDate, state.name, state.lastName]),
      ),
    );
  }

  void onCountryChanged(String country) {
    updateState(
      country,
      (state) => state.country,
      (state, country) => state.copyWith(country: country),
    );
  }

  void onDepartmentChanged(String department) {
    updateState(
      department,
      (state) => state.department,
      (state, department) => state.copyWith(department: department),
    );
  }

  void onCityChanged(String city) {
    updateState(city, (state) => state.city, (state, city) => state.copyWith(city: city));
  }

  void onComplementChanged(String complement) {
    updateState(
      complement,
      (state) => state.complement,
      (state, complement) => state.copyWith(complement: complement),
    );
  }

  void _markFieldAsDirty() {
    emit(
      state.copyWith(
        name: NameInputValidation.dirty(state.name.value),
        lastName: LastnameInputValidation.dirty(state.lastName.value),
        birthDate: DateTimeInputValidation.dirty(state.birthDate.value),
        isValid: Formz.validate([state.name, state.lastName, state.birthDate]),
      ),
    );
  }

  void reset() {
    emit(AddUserState());
  }
}
