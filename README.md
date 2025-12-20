# 🚀 Hasteh (هسته)

[English](#english) | [فارسی](#persian)

---

<a name="english"></a>
## English

**Hasteh** is a high-performance backend framework for Dart, designed with a focus on explicit architecture, modularity, and async-native execution. It enables developers to build scalable backend systems with predictable behavior and long-term maintainability.

### 🏗 project Structure

The project follows a monorepo structure using Dart packages:

-   **`hasteh_core`**: The heart of the framework.
    -   `HastehApp`: The main entry point for orchestrating the application.
    -   `DIContainer`: A simple and efficient Dependency Injection container.
    -   `HastehModule`: Abstract base for creating modular components.
-   **`hasteh_http`**: The web layer of the framework.
    -   `HastehHttpServer`: A modular HTTP server built on top of `dart:io`.
    -   `MiddlewarePipeline`: A powerful middleware system for request/response processing.
    -   `Router`: (In Development) A flexible routing system.

### 🛠 Key Features

-   **Modular Design**: Build your app using independent, reusable modules.
-   **Dependency Injection**: Built-in DI for managing service lifecycles.
-   **Middleware Support**: Easily plug in custom logic for every request.
-   **Async-Native**: Leverages Dart's asynchronous capabilities for maximum performance.

### 🚀 Quick Example

```dart
// Define a Module
class MyModule extends HastehModule {
  @override
  void init(HastehApp app) {
    print('MyModule initialized!');
  }
}

void main() async {
  final app = HastehApp();
  app.register(MyModule());
  
  await app.run();
}
```

---

<a name="persian"></a>
## فارسی (Persian)

**هسته (Hasteh)** یک فریم‌ورک بک‌اند با کارایی بالا برای زبان برنامه‌نویسی Dart است. این پروژه با تمرکز بر معماری صریح، ماژولار بودن و اجرای بومی به صورت ناهمگام (Async-native) طراحی شده است. هسته به برنامه‌نویسان اجازه می‌دهد سیستم‌های بک‌اند مقیاس‌پذیری با رفتار پیش‌بینی‌پذیر و قابلیت نگهداری طولانی‌مدت بسازند.

### 🏗 ساختار پروژه

پروژه از ساختار Monorepo با استفاده از پکیج‌های Dart استفاده می‌کند:

-   **`haseteh_core`**: قلب تپنده فریم‌ورک.
    -   `HastehApp`: نقطه شروع اصلی برای هماهنگ‌سازی اپلیکیشن.
    -   `DIContainer`: یک ظرف تزریق وابستگی (Dependency Injection) ساده و کارآمد.
    -   `HastehModule`: پایه انتزاعی برای ساخت کامپوننت‌های ماژولار.
-   **`hasteh_http`**: لایه وب فریم‌ورک.
    -   `HastehHttpServer`: یک سرور HTTP ماژولار ساخته شده روی `dart:io`.
    -   `MiddlewarePipeline`: یک سیستم Middleware قدرتمند برای پردازش درخواست و پاسخ.
    -   `Router`: (در حال توسعه) سیستم مسیریابی انعطاف‌پذیر.

### 🛠 ویژگی‌های کلیدی

-   **طراحی ماژولار**: اپلیکیشن خود را با استفاده از ماژول‌های مستقل و قابل استفاده مجدد بسازید.
-   **تزریق وابستگی (DI)**: دارای سیستم DI داخلی برای مدیریت چرخه حیات سرویس‌ها.
-   **پشتیبانی از Middleware**: امکان افزودن منطق سفارشی به سادگی برای هر درخواست.
-   **Async-Native**: بهره‌گیری کامل از قابلیت‌های غیرهمزمان Dart برای حداکثر کارایی.

### 🚀 مثال سریع

```dart
// تعریف یک ماژول
class MyModule extends HastehModule {
  @override
  void init(HastehApp app) {
    print('ماژول من آماده شد!');
  }
}

void main() async {
  final app = HastehApp();
  app.register(MyModule());
  
  await app.run();
}
```

---

### 📄 License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
