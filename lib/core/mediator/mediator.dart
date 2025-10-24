import 'package:get_it/get_it.dart';
import 'mediator_handler.dart';

final getIt = GetIt.instance;

/// Mediator para manejar Commands y Queries.
class Mediator {
  Future<R> send<T extends Request<R>, R>(T request) async {
    // Busca el handler registrado para este tipo de request
    final handler = getIt<RequestHandler<T, R>>();
    return await handler.handle(request);
  }
}
