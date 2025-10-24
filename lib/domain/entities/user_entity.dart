import 'package:isar/isar.dart';
import 'package:users_dvp_app/domain/entities/address_entity.dart';

part 'user_entity.g.dart';

@Collection()
class UserEntity {
  @Index()
  Id? id = Isar.autoIncrement;
  String? name;
  DateTime? birthDate;
  String? lastName;
  List<AddressEntity> addresses = [];

  UserEntity({this.id, this.name, this.birthDate, this.lastName, this.addresses = const []}) {
    id = id;
    name = name;
    birthDate = birthDate;
    lastName = lastName;
    addresses = addresses;
  }
}
