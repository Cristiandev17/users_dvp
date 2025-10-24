import 'package:users_dvp_app/core/constants/app_message.dart';
import 'package:users_dvp_app/core/failures/failure.dart';
import 'package:users_dvp_app/core/mediator/mediator_handler.dart';
import 'package:users_dvp_app/domain/mappers/user_mapper.dart';
import 'package:users_dvp_app/domain/models/user_model.dart';
import 'package:users_dvp_app/features/user/queries/get_user_by_id_query.dart';
import 'package:users_dvp_app/domain/repositories/user_repository.dart';

class GetUserByIdQueryHandler implements RequestHandler<GetUserByIdQuery, Result<UserModel>> {
  final UserRepository _userRepository;

  GetUserByIdQueryHandler(this._userRepository);

  @override
  Future<Result<UserModel>> handle(GetUserByIdQuery request) async {
    final entity = await _userRepository.getUserById(request.id);
    if (entity.value == null) {
      return Result.failure(DatabaseFailure(AppMessage.noUserFound));
    }
    return Result.success(UserMapper.toModel(entity.value!));
  }
}
