import 'package:hasteh_core/hasteh_core.dart';

import 'config/app.dart';
import 'config/database.dart';


void main() async {
  final config = HastehConfig({
    ...appConfig,
    ...databaseConfig,
  });

  final app = HastehApp(config: config);

  // ادامه setup (http server، moduleها، ...)
  await app.run();

  // برای نگه داشتن برنامه در حال اجرا
  print('برای خروج Ctrl+C را فشار دهید');
  await Future.delayed(Duration(days: 365)); // نگه داشتن برنامه به مدت طولانی
}
