import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:users_dvp_app/core/mediatr/mediator.dart';
import 'package:users_dvp_app/domain/entities/user_entity.dart';

Future<void> setupInjection() async {
  final getIt = GetIt.instance;

  //Register Mediator
  setupMediator();

  final directory = await getApplicationDocumentsDirectory();

  final isar = await Isar.open([UserEntitySchema], directory: directory.path, inspector: true);

  getIt.registerSingleton<Isar>(isar);
}
