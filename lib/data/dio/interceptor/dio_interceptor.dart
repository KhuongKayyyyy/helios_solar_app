import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:helios/core/constants/api_path.dart';
import 'package:helios/data/dio/dio_service.dart';
import 'package:helios/data/dio/error/error_exception_type.dart';
import 'package:helios/data/dtos/auth/token_reponse_dto.dart';
import 'package:helios/data/services/secure_storage_service.dart';

/// Interceptor for access token and refresh token logic
class DioInterceptor extends Interceptor {
  final SecureStorageService storage;

  DioInterceptor({required this.storage});

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      // Check if the request requires an access token
      if (options.extra['requiresAccessToken'] == true) {
        // Add access token to header
        final accessToken = await storage.get(SecureStorageKey.accessToken);
        options.headers['authorization'] = 'Bearer $accessToken';
      }

      // Check if the request requires a refresh token
      if (options.extra['requiresRefreshToken'] == true) {
        // Add refresh token to header
        final refreshToken = await storage.get(SecureStorageKey.refreshToken);
        options.headers['refreshToken'] = refreshToken;
      }

      // Pass the request to the next interceptor
      handler.next(options);
    } catch (e) {
      // If token is missing, throw an error
      handler.reject(
        DioException(
          requestOptions: options,
          error: TokenMissingException(
            'Access token or refresh token is missing',
          ),
          type: DioExceptionType.unknown,
        ),
      );
    }
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // If not a 401 error, use default error handling
    if (err.response?.statusCode != 401) {
      return super.onError(err, handler);
    }

    // Prevent infinite loop if already refreshing token
    if (err.requestOptions.path == ApiPath.accessByRefresh) {
      return handler.reject(
        DioException(
          requestOptions: err.requestOptions,
          error: TokenMissingException(
            'An error occurred during token refresh.',
          ),
          type: DioExceptionType.unknown,
        ),
      );
    }

    // Get refresh token
    final refreshToken = await storage.get(SecureStorageKey.refreshToken);

    // If refresh token is missing, throw an error
    if (refreshToken == null) {
      // Get.offAll(SignInScreen());

      return handler.reject(
        DioException(
          requestOptions: err.requestOptions,
          error: TokenMissingException('Refresh token is missing.'),
          type: DioExceptionType.unknown,
        ),
      );
    }

    // Create a new Dio instance
    final dio = Dio();
    dio.interceptors.add(
      LogInterceptor(
        logPrint: (o) => debugPrint(o.toString()),
        requestBody: true,
        responseBody: true,
        requestHeader: true,
      ),
    );

    try {
      // Request a new access token using the refresh token
      final response = await dio.post(
        '${BaseURL.prod}${ApiPath.accessByRefresh}',
        data: {'token': refreshToken},
      );

      // Save the new access token
      final responseMap = response.data['result']['accessToken'];
      final responseDTO = TokenResponseDTO.fromJson(responseMap);
      final newAccessToken = responseDTO.value;

      await storage.save(SecureStorageKey.accessToken, newAccessToken);

      // Add the new access token to the failed request
      final options = err.requestOptions;

      options.headers.addAll({'authorization': 'Bearer $newAccessToken'});

      // Retry the request
      final retryResponse = await dio.fetch(options);
      return handler.resolve(retryResponse); // Respond with the retried request
    } on DioException catch (_) {
      // If error occurs even after getting a new access token, refresh token is also expired
      // User needs to log in again
      await deleteToken();
      // Get.offAll(SignInScreen());
      return handler.reject(
        DioException(
          requestOptions: err.requestOptions,
          error: TokenMissingException('Token has expired.'),
          type: DioExceptionType.unknown,
        ),
      );
    }
  }

  ///
  /// Delete tokens == Logout
  ///
  Future<void> deleteToken() async {
    await Future.wait([
      storage.delete(SecureStorageKey.accessToken),
      storage.delete(SecureStorageKey.refreshToken),
    ]);
  }
}
