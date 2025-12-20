import 'dart:convert';
import 'dart:io';

class HastehRequest {
  final HttpRequest raw;
  final Map<String, String> pathParams;

  HastehRequest(this.raw, {this.pathParams = const {}});

  Map<String, String> get queryParams => raw.uri.queryParameters;

  Future<Map<String, dynamic>> json() async {
    final content = await utf8.decoder.bind(raw).join();
    if (content.isEmpty) return {};
    return jsonDecode(content) as Map<String, dynamic>;
  }

  String get method => raw.method;
  Uri get uri => raw.uri;
}

class HastehResponse {
  final HttpResponse raw;

  HastehResponse(this.raw);

  void json(Map<String, dynamic> data, {int statusCode = 200}) {
    raw
      ..statusCode = statusCode
      ..headers.contentType = ContentType.json
      ..write(jsonEncode(data))
      ..close();
  }

  void text(String data, {int statusCode = 200}) {
    raw
      ..statusCode = statusCode
      ..headers.contentType = ContentType.text
      ..write(data)
      ..close();
  }
}
