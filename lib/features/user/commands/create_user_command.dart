import 'package:users_dvp_app/core/failures/failure.dart';
import 'package:users_dvp_app/core/mediator/mediator_handler.dart';
import 'package:users_dvp_app/domain/models/user_model.dart';

class CreateUserCommand extends Request<Result<bool>> {
  final UserModel user;

  CreateUserCommand({required this.user});
}
