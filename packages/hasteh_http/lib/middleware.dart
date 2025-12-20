import 'dart:io';

typedef Middleware = Future<void> Function(HttpRequest request, Next next);
typedef Next = Future<void> Function();

class MiddlewarePipeline {
  final List<Middleware> _middlewares = [];

  void use(Middleware m) => _middlewares.add(m);

  Future<void> execute(HttpRequest req, Future<void> Function() finalHandler) async {
    var index = -1;
    Future<void> next() async {
      index++;
      if (index < _middlewares.length) {
        await _middlewares[index](req, next);
      } else {
        await finalHandler();
      }
    }
    await next();
  }
}
