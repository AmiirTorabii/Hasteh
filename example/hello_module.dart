import 'dart:io';
import 'package:hasteh_core/hasteh_core.dart';
import 'package:hasteh_http/hasteh_http.dart';

class HelloModule extends HastehModule {
  @override
  Future<void> init(HastehApp app) async {
    final httpServer = app.container.resolve<HastehHttpServer>();

    // Middleware global
    httpServer.use((req, next) async {
      print('[Global Middleware] ${req.method} ${req.uri.path}');
      await next();
    });

    // تعریف گروه route برای users
    final userGroup = RouteGroup(prefix: '/users', middlewares: [
      (req, next) async {
        print('[UserGroup Middleware] ${req.uri.path}');
        await next();
      }
    ]);

    userGroup.addRoute('GET', '/:id', (req, res) async {
      res.json({'userId': req.pathParams['id']});
    });

    userGroup.addRoute('GET', '/all', (req, res) async {
      res.json({'users': ['Alice', 'Bob', 'Charlie']});
    });

    // اضافه کردن گروه به router
    httpServer.router.addGroup(userGroup);

    // Route ساده مستقل
    httpServer.registerRoute('GET', '/hello', (req, res) async {
      res.json({'message': 'Hello Hasteh!'});
    });
  }
}
