import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flicknest/core/utils/app_constants.dart';

class DioService {
  static final DioService _instance = DioService._internal();

  factory DioService() => _instance;

  DioService._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: _baseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        headers: {'Content-Type': 'application/json'},
      ),
    );

    _dio.interceptors.addAll([_requestInterceptor(), _responseInterceptor(), _errorInterceptor()]);
  }

  late final Dio _dio;
  final String _baseUrl = AppConstants.baseUrl;
  final String _apiKey = AppConstants.apiKey;
  String? _authToken = AppConstants.accessToken;

  /// Set the auth token after login or refresh
  void setAuthToken(String token) {
    _authToken = token;
  }

  /// Clear auth token on logout
  void clearAuthToken() {
    _authToken = null;
  }

  /// Public Dio getter if needed
  Dio get client => _dio;

  /// GET
  Future<Response> get(String path, {Map<String, dynamic>? query}) async {
    return await _dio.get(path, queryParameters: query);
  }

  /// POST
  Future<Response> post(String path, {dynamic data}) async {
    return await _dio.post(path, data: data);
  }

  /// PUT
  Future<Response> put(String path, {dynamic data}) async {
    return await _dio.put(path, data: data);
  }

  /// DELETE
  Future<Response> delete(String path, {dynamic data}) async {
    return await _dio.delete(path, data: data);
  }

  /// ----- INTERCEPTORS -----

  Interceptor _requestInterceptor() {
    return InterceptorsWrapper(
      onRequest: (options, handler) {
        log('[➡️] ${options.method} ${options.uri}');
        options.queryParameters['api_key'] = _apiKey;
        if (_authToken != null) {
          options.headers['Authorization'] = 'Bearer $_authToken';
        }
        return handler.next(options);
      },
    );
  }

  Interceptor _responseInterceptor() {
    return InterceptorsWrapper(
      onResponse: (response, handler) {
        log('[✅] ${response.statusCode} ${response.requestOptions.uri}');
        log('Response Data: ${response.data}');
        return handler.next(response);
      },
    );
  }

  Interceptor _errorInterceptor() {
    return InterceptorsWrapper(
      onError: (error, handler) {
        log('[⛔] ${error.type} | ${error.message}');
        if (error.response != null) {
          log('Error Response: ${error.response?.data}');
        }

        // Optional: Handle 401 Unauthorized here
        if (error.response?.statusCode == 401) {
          // Implement token refresh flow
        }

        return handler.next(error);
      },
    );
  }
}
