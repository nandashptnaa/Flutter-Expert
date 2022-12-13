import 'package:ditonton/ssl/ssl.dart';
import 'package:http/http.dart' as http;


class HttpSSL {
  static Future<http.Client> get _ssl async =>
      _client ??= await SslPinning.httpSsslClient();

  static http.Client? _client;
  static http.Client get client => _client ?? http.Client();

  static Future<void> init() async {
    _client = await _ssl;
  }
}