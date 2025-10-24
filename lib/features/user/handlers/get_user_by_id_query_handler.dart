import 'package:dart_mediatr/dart_mediatr.dart';
import 'package:users_dvp_app/domain/entities/user_entity.dart';
import 'package:users_dvp_app/domain/mappers/user_mapper.dart';
import 'package:users_dvp_app/domain/models/user_model.dart';
import 'package:users_dvp_app/features/user/queries/get_user_by_id_query.dart';
import 'package:users_dvp_app/domain/repositories/user_repository.dart';

class GetUserByIdQueryHandler implements IQueryHandler<GetUserByIdQuery, Future<UserModel>> {
  final UserRepository _userRepository;

  GetUserByIdQueryHandler(this._userRepository);

  @override
  Future<UserModel> handle(GetUserByIdQuery query) async {
    final entity = await _userRepository.getUserById(query.id);
    return UserMapper.toModel(entity ?? UserEntity());
  }
}
