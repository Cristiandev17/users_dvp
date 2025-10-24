import 'package:isar/isar.dart';

part 'address_entity.g.dart';

@embedded
class AddressEntity {
  String? complement;
  String? city;
  String? country;
  String? department;

  AddressEntity({this.complement, this.city, this.country, this.department}) {
    complement = complement;
    city = city;
    country = country;
    department = department;
  }
}
