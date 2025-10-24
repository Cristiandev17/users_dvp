import 'package:dart_mediatr/dart_mediatr.dart';
import 'package:users_dvp_app/domain/mappers/user_mapper.dart';
import 'package:users_dvp_app/domain/repositories/user_repository.dart';
import 'package:users_dvp_app/features/user/commands/create_user_command.dart';

class CreateUserCommandHandler extends ICommandHandler<CreateUserCommand, Future<bool>> {
  final UserRepository _userRepository;

  CreateUserCommandHandler(this._userRepository);

  @override
  Future<bool> handle(CreateUserCommand request) async {
    final userEntity = UserMapper.toEntity(request.user);
    return await _userRepository.addUser(userEntity);
  }
}
