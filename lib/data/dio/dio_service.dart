import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:helios/data/dio/error/error_exception_type.dart';
import 'package:helios/data/dio/interceptor/dio_interceptor.dart';
import 'package:helios/data/services/secure_storage_service.dart';

/// 토큰 타입 (헤더에 넣어줄지를 결정하는 타입)
enum TokenType { none, access, refresh, both }

/// 기본 URL
abstract class BaseURL {
  static const String dev = "http://34.47.125.196:3000/";
  static const String prod = "https://api.studychingu.com/";
  static const String weather = "https://api.weatherapi.com/v1/";
}

/// 네트워크 서비스
class DioService {
  static DioService? _defaultInstance;
  static final Map<String, DioService> _instances = {};

  late final Dio _dio;
  late final String _baseUrl;
  final SecureStorageService _storage = SecureStorageService();

  /// Factory method that returns appropriate instance based on base URL
  factory DioService({String? baseUrl}) {
    final targetUrl = baseUrl ?? _getDefaultBaseUrl();

    // If requesting the default instance and it exists, return it
    if (baseUrl == null && _defaultInstance != null) {
      return _defaultInstance!;
    }

    // Check if we already have an instance for this base URL
    if (_instances.containsKey(targetUrl)) {
      return _instances[targetUrl]!;
    }

    // Create new instance
    final instance = DioService._internal(baseUrl: targetUrl);

    // Store as default instance if no specific baseUrl was provided
    if (baseUrl == null) {
      _defaultInstance = instance;
    }

    // Store in instances map
    _instances[targetUrl] = instance;

    return instance;
  }

  /// Get the default instance (must be initialized first)
  static DioService get instance {
    if (_defaultInstance == null) {
      throw StateError(
        'DioService not initialized. Call DioService.initialize() first.',
      );
    }
    return _defaultInstance!;
  }

  // 생성자 (외부에서 인스턴스를 생성할 수 없음)
  DioService._internal({String? baseUrl}) {
    _baseUrl = _determineBaseUrl(baseUrl);

    _dio = Dio(
      BaseOptions(
        baseUrl: _baseUrl,
        connectTimeout: const Duration(seconds: 45),
        receiveTimeout: const Duration(seconds: 30),
        headers: {'Accept': 'application/json'},
      ),
    );

    _dio.interceptors.add(
      LogInterceptor(
        logPrint: (o) => debugPrint(o.toString()),
        requestBody: true,
        responseBody: true,
        requestHeader: true,
      ),
    );

    // 토큰 인터셉터
    _dio.interceptors.add(DioInterceptor(storage: _storage));
  }

  /// Get the default base URL based on environment configuration
  static String _getDefaultBaseUrl() {
    try {
      // Try to load from environment variables
      final envBaseUrl = dotenv.env['BASE_URL'];
      if (envBaseUrl != null && envBaseUrl.isNotEmpty) {
        return envBaseUrl;
      }
    } catch (e) {
      debugPrint('Error reading environment variables: $e');
    }

    // Check for debug mode to decide between dev and prod
    if (kDebugMode) {
      return BaseURL.dev;
    }

    // Default to production
    return BaseURL.prod;
  }

  /// Determine the base URL from environment variables or use the provided/default URL
  String _determineBaseUrl(String? providedBaseUrl) {
    // If a base URL is explicitly provided, use it
    if (providedBaseUrl != null && providedBaseUrl.isNotEmpty) {
      return providedBaseUrl;
    }

    return _getDefaultBaseUrl();
  }

  /// Get the current base URL
  String get baseUrl => _baseUrl;

  /// Initialize the service with environment variables (call this in main.dart)
  static Future<void> initialize({String? baseUrl}) async {
    try {
      await dotenv.load(fileName: ".env");
    } catch (e) {
      debugPrint('No .env file found or error loading it: $e');
    }

    // Initialize the default instance
    DioService(baseUrl: baseUrl);
  }

  // GET 요청
  Future<T> get<T>({
    required String path,
    Map<String, dynamic>? parameters,
    Options? options,
    TokenType tokenType = TokenType.none,
  }) async {
    try {
      // 토큰 타입에 따라 옵션 추가
      final Options? mergedOptions = _mergeOptionsWithTokenType(
        options: options,
        tokenType: tokenType,
      );

      final response = await _dio.get(
        path,
        queryParameters: parameters,
        options: mergedOptions,
      );
      return response.data as T;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // POST 요청
  Future<T> post<T>({
    required String path,
    dynamic data,
    Map<String, dynamic>? parameters,
    Options? options,
    TokenType tokenType = TokenType.none,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      // 토큰 타입에 따라 옵션 추가
      final Options? mergedOptions = _mergeOptionsWithTokenType(
        options: options,
        tokenType: tokenType,
      );

      final response = await _dio.post(
        path,
        data: data,
        queryParameters: parameters,
        options: mergedOptions,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data as T;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// PUT 요청
  Future<T> put<T>({
    required String path,
    dynamic data,
    Map<String, dynamic>? parameters,
    Options? options,
    TokenType tokenType = TokenType.none,
  }) async {
    try {
      // 토큰 타입에 따라 옵션 추가
      final Options? mergedOptions = _mergeOptionsWithTokenType(
        options: options,
        tokenType: tokenType,
      );

      final response = await _dio.put(
        path,
        data: data,
        queryParameters: parameters,
        options: mergedOptions,
      );
      return response.data as T;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// PATCH 요청
  Future<T> patch<T>({
    required String path,
    dynamic data,
    Map<String, dynamic>? parameters,
    Options? options,
    TokenType tokenType = TokenType.none,
  }) async {
    try {
      // 토큰 타입에 따라 옵션 추가
      final Options? mergedOptions = _mergeOptionsWithTokenType(
        options: options,
        tokenType: tokenType,
      );

      final response = await _dio.patch(
        path,
        data: data,
        queryParameters: parameters,
        options: mergedOptions,
      );
      return response.data as T;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// DELETE 요청
  Future<T> delete<T>({
    required String path,
    dynamic data,
    Map<String, dynamic>? parameters,
    Options? options,
    TokenType tokenType = TokenType.none,
  }) async {
    try {
      // 토큰 타입에 따라 옵션 추가
      final Options? mergedOptions = _mergeOptionsWithTokenType(
        options: options,
        tokenType: tokenType,
      );

      final response = await _dio.delete(
        path,
        queryParameters: parameters,
        data: data,
        options: mergedOptions,
      );
      return response.data as T;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// 파일 다운로드
  Future<void> download({
    required String url,
    required String savePath,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      await _dio.download(
        url,
        savePath,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  ///
  /// 토큰 타입에 따라 옵션 추가
  ///
  Options? _mergeOptionsWithTokenType({
    Options? options,
    required TokenType tokenType,
  }) {
    // 옵션이 없으면 새로운 옵션 생성
    final extra = Map<String, dynamic>.from(options?.extra ?? {});

    switch (tokenType) {
      case TokenType.access:
        extra['requiresAccessToken'] = true;
        break;
      case TokenType.refresh:
        extra['requiresRefreshToken'] = true;
        break;
      case TokenType.both:
        extra['requiresAccessToken'] = true;
        extra['requiresRefreshToken'] = true;
        break;
      case TokenType.none:
        return options;
    }

    return Options(
      method: options?.method,
      sendTimeout: options?.sendTimeout,
      receiveTimeout: options?.receiveTimeout,
      extra: extra,
      headers: options?.headers,
      responseType: options?.responseType,
      contentType: options?.contentType,
      validateStatus: options?.validateStatus,
      receiveDataWhenStatusError: options?.receiveDataWhenStatusError,
      followRedirects: options?.followRedirects,
      maxRedirects: options?.maxRedirects,
      requestEncoder: options?.requestEncoder,
      responseDecoder: options?.responseDecoder,
    );
  }

  // 에러 핸들링
  Exception _handleError(DioException error) {
    // 토큰 누락 에러 처리
    if (error.error is TokenMissingException) {
      return error.error as TokenMissingException;
    }

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return TimeoutException('요청이 시간 초과했습니다. (잠시 후 다시 시도해주세요)');

      case DioExceptionType.badResponse: // (200-299) 이외의 상태 코드 반환 시
        // 서버 응답에서 메시지 추출
        String responseMessage = '';

        try {
          final response = error.response?.data;
          if (response is Map<String, dynamic> && response['message'] != null) {
            responseMessage = response['message'].toString();
          }
        } catch (e) {
          responseMessage = '서버 오류가 발생했습니다. (잠시 후 다시 시도해주세요)';
        }

        return ServerException(
          responseMessage,
          statusCode: error.response?.statusCode,
        );
      default:
        return NetworkException('네트워킹 오류가 발생했습니다. (잠시 후 다시 시도해주세요)');
    }
  }
}
