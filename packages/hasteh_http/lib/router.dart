import 'middleware.dart';
import 'request_response.dart';

typedef Handler = Future<void> Function(HastehRequest req, HastehResponse res);

/// تعریف یک route
class RouteDefinition {
  final String method;
  final String path; // مثلا: /users/:id
  final Handler handler;
  final List<Middleware> middlewares;
  int _staticCount = 0; // برای اولویت دادن به مسیرهای ثابت

  RouteDefinition({
    required this.method,
    required this.path,
    required this.handler,
    this.middlewares = const [],
  });
}

/// گروه route برای ماژول‌ها یا prefix مشترک
class RouteGroup {
  final String prefix;
  final List<RouteDefinition> _routes = [];
  final List<Middleware> middlewares;

  RouteGroup({this.prefix = '', this.middlewares = const []});

  void addRoute(String method, String path, Handler handler, {List<Middleware> middlewares = const []}) {
    _routes.add(RouteDefinition(
      method: method,
      path: path,
      handler: handler,
      middlewares: middlewares,
    ));
  }

  /// برمی‌گرداند routeها با prefix و middlewareهای گروه ترکیب شده
  List<RouteDefinition> get routes =>
      _routes.map((r) {
        final fullPath = prefix + r.path;
        return RouteDefinition(
          method: r.method,
          path: fullPath,
          handler: r.handler,
          middlewares: [...middlewares, ...r.middlewares],
        );
      }).toList();
}

/// نتیجه match یک route
class RouteMatch {
  final RouteDefinition route;
  final Map<String, String> pathParams;

  RouteMatch(this.route, this.pathParams);
}

/// کلاس Router اصلی
class Router {
  final List<RouteDefinition> _routes = [];

  /// اضافه کردن یک route مستقل
  void addRoute(RouteDefinition route) {
    _routes.add(route);
  }

  /// اضافه کردن یک گروه route
  void addGroup(RouteGroup group) {
    _routes.addAll(group.routes);
  }

  /// جستجوی مسیر مناسب با اولویت static route
  RouteMatch? match(String method, String path) {
    List<_Candidate> candidates = [];

    for (var r in _routes) {
      if (r.method.toUpperCase() != method.toUpperCase()) continue;

      final routeParts = r.path.split('/').where((p) => p.isNotEmpty).toList();
      final pathParts = path.split('/').where((p) => p.isNotEmpty).toList();

      if (routeParts.length != pathParts.length) continue;

      final params = <String, String>{};
      bool matched = true;
      int staticCount = 0;

      for (int i = 0; i < routeParts.length; i++) {
        final routePart = routeParts[i];
        final pathPart = pathParts[i];

        if (routePart.startsWith(':')) {
          params[routePart.substring(1)] = pathPart;
        } else if (routePart != pathPart) {
          matched = false;
          break;
        } else {
          staticCount++;
        }
      }

      if (matched) {
        r._staticCount = staticCount;
        candidates.add(_Candidate(route: r, params: params));
      }
    }

    if (candidates.isEmpty) return null;

    // انتخاب route با بیشترین static segment
    candidates.sort((a, b) => b.route._staticCount.compareTo(a.route._staticCount));

    final best = candidates.first;
    return RouteMatch(best.route, best.params);
  }
}

/// کلاس کمکی برای مرتب‌سازی مسیرهای static
class _Candidate {
  final RouteDefinition route;
  final Map<String, String> params;

  _Candidate({required this.route, required this.params});
}
