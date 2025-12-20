library hasteh_core;

/// ============================
/// Hasteh Core - Initial Scaffold
/// ============================

import 'dart:async';

/// Abstract Module class - all modules extend this
abstract class HastehModule {
  /// Called when module is registered
  FutureOr<void> init(HastehApp app) {}
}

/// Simple DI container
class DIContainer {
  final Map<Type, dynamic> _services = {};

  void register<T>(T instance) {
    _services[T] = instance;
  }

  T resolve<T>() {
    final instance = _services[T];
    if (instance == null) {
      throw Exception('Service of type $T not found');
    }
    return instance as T;
  }
}

/// Core Hasteh Application
class HastehApp {
  final List<HastehModule> _modules = [];
  final DIContainer _container = DIContainer();

  /// Register a module
  void register(HastehModule module) {
    _modules.add(module);
  }

  /// Access DI container
  DIContainer get container => _container;

  /// Initialize modules
  Future<void> _initModules() async {
    for (var module in _modules) {
      await module.init(this);
    }
  }

  /// Run the app
  Future<void> run() async {
    print('🚀 HastehApp: Starting...');
    await _initModules();
    print('✅ HastehApp: All modules initialized');
    // TODO: Start HTTP server in hasteh_http package
  }

  /// Shutdown the app
  Future<void> shutdown() async {
    print('🛑 HastehApp: Shutting down...');
    // TODO: cleanup resources
  }
}
