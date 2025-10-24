import 'package:users_dvp_app/domain/entities/address_entity.dart';
import 'package:users_dvp_app/domain/models/address_model.dart';

class AddressMapper {
  static AddressEntity toEntity(AddressModel model) {
    return AddressEntity(
      city: model.city,
      country: model.country,
      department: model.department,
      complement: model.complement,
    );
  }

  static AddressModel toModel(AddressEntity entity) {
    return AddressModel(
      city: entity.city ?? '',
      country: entity.country ?? '',
      department: entity.department ?? '',
      complement: entity.complement ?? '',
    );
  }

  static List<AddressEntity> toAddressEntityList(List<AddressModel> models) {
    return models.map((model) => toEntity(model)).toList();
  }

  static List<AddressModel> toAddressModelList(List<AddressEntity> entities) {
    return entities.map((entity) => toModel(entity)).toList();
  }
}
