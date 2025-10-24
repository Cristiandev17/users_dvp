import 'package:users_dvp_app/domain/models/address_model.dart';

class UserModel {
  final int? id;
  final String name;
  final String lastName;
  final String birthDate;
  final List<AddressModel>? addresses;

  UserModel._({
    this.id,
    required this.name,
    required this.lastName,
    required this.birthDate,
    this.addresses,
  });

  static UserModelBuilder builder() => UserModelBuilder();
}

class UserModelBuilder {
  int? _id;
  String? _name;
  String? _lastName;
  String? _birthDate;
  final List<AddressModel> _addresses = [];

  UserModelBuilder setId(int id) {
    _id = id;
    return this;
  }

  UserModelBuilder setName(String name) {
    _name = name;
    return this;
  }

  UserModelBuilder setLastName(String lastName) {
    _lastName = lastName;
    return this;
  }

  UserModelBuilder setBirthDate(String birthDate) {
    _birthDate = birthDate;
    return this;
  }

  UserModelBuilder addAddress(AddressModel address) {
    _addresses.add(address);
    return this;
  }

  UserModelBuilder addAddresses(List<AddressModel> addresses) {
    _addresses.addAll(addresses);
    return this;
  }

  UserModel build() {
    return UserModel._(
      id: _id ?? 0,
      name: _name ?? '',
      lastName: _lastName ?? '',
      birthDate: _birthDate ?? '',
      addresses: _addresses.isEmpty ? null : List.unmodifiable(_addresses),
    );
  }
}
