abstract class Request<R> {}

abstract class RequestHandler<T extends Request<R>, R> {
  Future<R> handle(T request);
}
