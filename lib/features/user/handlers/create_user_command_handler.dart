import 'package:dart_mediatr/dart_mediatr.dart';
import 'package:users_dvp_app/core/failures/failure.dart';
import 'package:users_dvp_app/domain/mappers/user_mapper.dart';
import 'package:users_dvp_app/domain/repositories/user_repository.dart';
import 'package:users_dvp_app/features/user/commands/create_user_command.dart';

class CreateUserCommandHandler extends ICommandHandler<CreateUserCommand, Future<Result<bool>>> {
  final UserRepository _userRepository;

  CreateUserCommandHandler(this._userRepository);

  @override
  Future<Result<bool>> handle(CreateUserCommand request) async {
    final userEntity = UserMapper.toEntity(request.user);

    final result = await _userRepository.addUser(userEntity);

    if (!result.isFailure) {
      return result;
    }

    return Result.success(result.value!);
  }
}
