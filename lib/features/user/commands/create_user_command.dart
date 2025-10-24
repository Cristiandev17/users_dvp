import 'package:dart_mediatr/dart_mediatr.dart';
import 'package:users_dvp_app/domain/models/user_model.dart';

class CreateUserCommand extends ICommand<Future<bool>> {
  final UserModel user;

  CreateUserCommand({required this.user});
}
