import 'package:hasteh_core/hasteh_core.dart';
import 'package:hasteh_http/hasteh_http.dart';
import 'hello_module.dart';

Future<void> main() async {
  final app = HastehApp();

  // DI
  app.container.register(HastehHttpServer());

  // Module
  app.register(HelloModule());

  await app.run();

  // Start server
  final httpServer = app.container.resolve<HastehHttpServer>();
  await httpServer.start(port: 8080);
}
