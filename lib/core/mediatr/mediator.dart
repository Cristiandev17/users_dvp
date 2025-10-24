import 'package:dart_mediatr/dart_mediatr.dart';
import 'package:get_it/get_it.dart';
import 'package:users_dvp_app/domain/repositories/user_repository.dart';
import 'package:users_dvp_app/features/user/handlers/create_user_command_handler.dart';
import 'package:users_dvp_app/features/user/handlers/get_all_users_query_handler.dart';
import 'package:users_dvp_app/features/user/handlers/get_user_by_id_query_handler.dart';

final getIt = GetIt.instance;

void setupMediator() {
  final mediator = Mediator();

  // Register command handlers
  mediator.registerCommandHandler(CreateUserCommandHandler(getIt<UserRepository>()));

  // Register query handlers
  mediator.registerQueryHandler(GetAllUsersQueryHandler(getIt<UserRepository>()));
  mediator.registerQueryHandler(GetUserByIdQueryHandler(getIt<UserRepository>()));

  getIt.registerSingleton<Mediator>(mediator);
}
