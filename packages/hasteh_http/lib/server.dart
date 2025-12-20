import 'dart:io';
import 'middleware.dart';
import 'router.dart';
import 'request_response.dart';

class HastehHttpServer {
  final Router router = Router();
  final MiddlewarePipeline _pipeline = MiddlewarePipeline();

  void use(Middleware middleware) {
    _pipeline.use(middleware);
  }

  void registerRoute(String method, String path, Handler handler, {List<Middleware> middlewares = const []}) {
    router.addRoute(RouteDefinition(
      method: method,
      path: path,
      handler: handler,
      middlewares: middlewares,
    ));
  }

  Future<void> start({int port = 8080}) async {
    final server = await HttpServer.bind(InternetAddress.anyIPv4, port);
    print('🚀 Hasteh HTTP Server running on port $port');

    await for (var request in server) {
      final match = router.match(request.method, request.uri.path);

      final req = HastehRequest(request, pathParams: match?.pathParams ?? {});
      final res = HastehResponse(request.response);

      if (match == null) {
        res.text('Not Found', statusCode: 404);
        continue;
      }

      try {
        // اجرا middleware global و سپس route-specific
        await _pipeline.execute(request, () async {
          for (var m in match.route.middlewares) {
            await m(request, () async {});
          }
          await match.route.handler(req, res);
        });
      } catch (e, st) {
        print('❌ Error: $e\n$st');
        res.text('Internal Server Error', statusCode: 500);
      }
    }
  }
}
