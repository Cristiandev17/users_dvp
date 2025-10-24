import 'package:dart_mediatr/dart_mediatr.dart';
import 'package:users_dvp_app/core/constants/app_message.dart';
import 'package:users_dvp_app/core/failures/failure.dart';
import 'package:users_dvp_app/domain/mappers/user_mapper.dart';
import 'package:users_dvp_app/domain/models/user_model.dart';
import 'package:users_dvp_app/features/user/queries/get_all_users_query.dart';
import 'package:users_dvp_app/domain/repositories/user_repository.dart';

class GetAllUsersQueryHandler
    extends IQueryHandler<GetAllUsersQuery, Future<Result<List<UserModel>>>> {
  final UserRepository _userRepository;

  GetAllUsersQueryHandler(this._userRepository);

  @override
  Future<Result<List<UserModel>>> handle(GetAllUsersQuery request) async {
    final entities = await _userRepository.getAllUsers();

    if (entities.value?.isEmpty ?? true) {
      return Result.failure(DatabaseFailure(AppMessage.noUsersFound));
    }

    return Result.success(UserMapper.toModelList(entities.value!));
  }
}
