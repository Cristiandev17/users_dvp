import 'package:isar/isar.dart';

part 'address_entity.g.dart';

@embedded
class AddressEntity {
  String? street;
  String? city;
  String? country;
  String? state;

  AddressEntity({this.street, this.city, this.country, this.state}) {
    street = street;
    city = city;
    country = country;
    state = state;
  }
}
