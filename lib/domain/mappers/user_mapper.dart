import 'package:users_dvp_app/domain/entities/user_entity.dart';
import 'package:users_dvp_app/domain/mappers/address_mapper.dart';
import 'package:users_dvp_app/domain/models/user_model.dart';

class UserMapper {
  static UserEntity toEntity(UserModel model) {
    return UserEntity(
      name: model.name,
      lastName: model.lastName,
      birthDate: DateTime.parse(model.birthDate),
      addresses: AddressMapper.toAddressEntityList(model.addresses ?? []),
    );
  }

  static UserModel toModel(UserEntity entity) {
    return UserModel.builder()
        .setId(entity.id ?? 0)
        .setName(entity.name ?? '')
        .setLastName(entity.lastName ?? '')
        .setBirthDate(entity.birthDate?.toString().split(' ')[0] ?? '')
        .addAddresses(AddressMapper.toAddressModelList(entity.addresses))
        .build();
  }

  static List<UserModel> toModelList(List<UserEntity> entities) {
    return entities.map((entity) => toModel(entity)).toList();
  }
}
