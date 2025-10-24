class AddressModel {
  int? id;
  String country;
  String department;
  String city;
  String complement;

  AddressModel({
    this.id,
    required this.country,
    required this.department,
    required this.city,
    required this.complement,
  });

  static AddressModelBuilder builder() => AddressModelBuilder();
}

class AddressModelBuilder {
  int? _id;
  String? _country;
  String? _department;
  String? _city;
  String? _complement;

  AddressModelBuilder setId(int id) {
    _id = id;
    return this;
  }

  AddressModelBuilder setCountry(String country) {
    _country = country;
    return this;
  }

  AddressModelBuilder setDepartment(String department) {
    _department = department;
    return this;
  }

  AddressModelBuilder setCity(String city) {
    _city = city;
    return this;
  }

  AddressModelBuilder setComplement(String complement) {
    _complement = complement;
    return this;
  }

  AddressModel build() {
    return AddressModel(
      id: _id,
      country: _country ?? '',
      department: _department ?? '',
      city: _city ?? '',
      complement: _complement ?? '',
    );
  }
}
