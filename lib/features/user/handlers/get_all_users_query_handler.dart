import 'package:dart_mediatr/dart_mediatr.dart';
import 'package:users_dvp_app/domain/mappers/user_mapper.dart';
import 'package:users_dvp_app/domain/models/user_model.dart';
import 'package:users_dvp_app/features/user/queries/get_all_users_query.dart';
import 'package:users_dvp_app/domain/repositories/user_repository.dart';

class GetAllUsersQueryHandler extends IQueryHandler<GetAllUsersQuery, Future<List<UserModel>>> {
  final UserRepository _userRepository;

  GetAllUsersQueryHandler(this._userRepository);

  @override
  Future<List<UserModel>> handle(GetAllUsersQuery request) async {
    final entities = await _userRepository.getAllUsers();

    return UserMapper.toModelList(entities);
  }
}
