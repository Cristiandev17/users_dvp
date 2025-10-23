import 'package:dart_mediatr/dart_mediatr.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupMediator() {
  final mediator = Mediator();

  //Register handlers

  //Register queries

  getIt.registerSingleton<Mediator>(mediator);
}
