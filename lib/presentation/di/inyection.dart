import 'package:dart_mediatr/dart_mediatr.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:users_dvp_app/core/mediatr/mediator.dart';
import 'package:users_dvp_app/core/utils/providers/implementations/snackbar_provider_impl.dart';
import 'package:users_dvp_app/core/utils/providers/snackbar_provider.dart';
import 'package:users_dvp_app/data/repositories/user_repository_impl.dart';
import 'package:users_dvp_app/domain/entities/user_entity.dart';
import 'package:users_dvp_app/domain/repositories/user_repository.dart';
import 'package:users_dvp_app/presentation/cubits/add_user/add_user_cubit.dart';
import 'package:users_dvp_app/presentation/cubits/detail_user/detail_user_cubit.dart';
import 'package:users_dvp_app/presentation/cubits/list_user/list_user_cubit.dart';

Future<void> setupInjection() async {
  final getIt = GetIt.instance;

  //Register Directory
  final directory = await getApplicationDocumentsDirectory();

  //Register Isar
  final isar = await Isar.open([UserEntitySchema], directory: directory.path, inspector: true);
  getIt.registerSingleton<Isar>(isar);

  //Register Repositories
  getIt.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(isar));

  //Register Mediator
  setupMediator();

  //Register Cubits
  getIt.registerLazySingleton<ListUserCubit>(() => ListUserCubit(getIt<Mediator>()));
  getIt.registerLazySingleton<AddUserCubit>(() => AddUserCubit(getIt<Mediator>()));
  getIt.registerLazySingleton<DetailUserCubit>(() => DetailUserCubit(getIt<Mediator>()));

  //Register Providers
  getIt.registerLazySingleton<SnackbarProvider>(() => SnackbarProviderImpl());
}
