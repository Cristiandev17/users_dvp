part of 'add_user_cubit.dart';

enum FormStatus { initial, loading, success, failure, invalid, error }

class AddUserState extends Equatable {
  final NameInputValidation name;
  final LastnameInputValidation lastName;
  final DateTimeInputValidation birthDate;
  final bool isValid;
  final FormStatus status;
  final String? message;

  final List<AddressModel> addresses;

  final String country;
  final String department;
  final String city;
  final String complement;

  const AddUserState({
    this.name = const NameInputValidation.pure(),
    this.lastName = const LastnameInputValidation.pure(),
    this.birthDate = const DateTimeInputValidation.pure(),
    this.isValid = false,
    this.status = FormStatus.initial,
    this.message,
    this.addresses = const [],
    this.country = '',
    this.department = '',
    this.city = '',
    this.complement = '',
  });

  AddUserState copyWith({
    NameInputValidation? name,
    LastnameInputValidation? lastName,
    DateTimeInputValidation? birthDate,
    bool? isValid,
    FormStatus? status,
    String? message,
    List<AddressModel>? addresses,
    String? country,
    String? department,
    String? city,
    String? complement,
  }) {
    return AddUserState(
      name: name ?? this.name,
      lastName: lastName ?? this.lastName,
      birthDate: birthDate ?? this.birthDate,
      isValid: isValid ?? this.isValid,
      status: status ?? this.status,
      message: message ?? this.message,
      addresses: addresses ?? this.addresses,
      country: country ?? this.country,
      department: department ?? this.department,
      city: city ?? this.city,
      complement: complement ?? this.complement,
    );
  }

  @override
  List<Object?> get props => [
    name,
    lastName,
    birthDate,
    isValid,
    status,
    message,
    addresses,
    country,
    department,
    city,
    complement,
  ];
}
