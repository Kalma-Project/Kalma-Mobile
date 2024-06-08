import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_ta/config/endpoints.dart';
import 'dart:developer';

import 'package:flutter_ta/config/token/constants.dart';
import 'package:flutter_ta/main.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;

  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  late Dio dio;
  final List<Cookie> _cookies = [];

  ApiService._internal() {
    dio = Dio(BaseOptions(
      baseUrl: BASE_URL,
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
    ));

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (RequestOptions options, RequestInterceptorHandler handler) async {
        String? token = await _secureStorage.read(key: accessToken);
        options.headers.addAll({
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
          "Accept-Language": "id"
        });
        if (token != null && !options.extra.containsKey('retry')) {
          log('token still exist...');
        }
        return handler.next(options);
      },

      onResponse: (Response response, ResponseInterceptorHandler handler) {
        return handler.next(response);
      },

      onError: (DioException error, ErrorInterceptorHandler handler) async {
        if (error.response?.statusCode == 401 && !error.requestOptions.extra.containsKey('retry')) {
          String? refreshToken = await _secureStorage.read(key: refresh_token);
          if (refreshToken != null) {
            bool tokenRefreshed = await _refreshToken();
            if (tokenRefreshed) {
              final opts = error.requestOptions;
              String? newToken = await _secureStorage.read(key: accessToken);
              if (newToken != null) {
                opts.headers["Authorization"] = "Bearer $newToken";
                opts.extra['retry'] = true;
                try {
                  final cloneReq = await dio.request(
                    opts.path,
                    options: Options(
                      method: opts.method,
                      headers: opts.headers,
                      extra: opts.extra,
                    ),
                    data: opts.data,
                    queryParameters: opts.queryParameters,
                  );
                  return handler.resolve(cloneReq);
                } catch (e) {
                  log('Exception during retry: $e');
                  return handler.reject(e as DioException);
                }
              } else {
                log('New token was null after refresh');
              }
            } else {
              await clearTokens();
            }
          } else {
            log('no token found');
            await clearTokens();
            navigatorKey.currentState?.pushNamed('/login');
          }
        }
        return handler.next(error);
      },
    ));
  }

  void storeCookies(Response response) async {
    final setCookieHeaders = response.headers[HttpHeaders.setCookieHeader];
    if (setCookieHeaders != null) {
      for (var value in setCookieHeaders) {
        final cookie = Cookie.fromSetCookieValue(value);

        List<String> parts = cookie.toString().split(';');
        String tokenPart = parts.firstWhere((part) => part.trim().startsWith('refreshToken='));
        String refreshToken = tokenPart.split('=')[1];

        _cookies.removeWhere((c) => c.name == cookie.name);
        _cookies.add(cookie);
        await _secureStorage.write(key: refresh_token, value: refreshToken);

        log('refresh token successfully obtained and saved');
      }
    }
  }

  Future<bool> _refreshToken() async {
    log('Attempting to refresh token...');
    try {
      String? refreshToken = await _secureStorage.read(key: refresh_token);
      final response = await dio.get(
          get_refresh_token,
        options: Options(
          headers: {
            'Cookie': 'refreshToken=$refreshToken'
          }
        )
      );

      if (response.statusCode == 200) {
        final body = response.data;
        if (body['is_success'] == true) {
          String newAccessToken = body['access_token'];
          await _secureStorage.write(key: accessToken, value: newAccessToken);
          log('Token refreshed successfully: $newAccessToken');

          return true;
        } else {
          log('Failed to refresh token: ${body['message']}');
        }
      } else {
        log('Failed to refresh token: Server error with status code ${response.statusCode}');
      }
    } catch (e) {
      log('Exception occurred during token refresh: $e');
    }
    return false;
  }

  Future<void> clearTokens() async {
    await _secureStorage.delete(key: accessToken);
    await _secureStorage.delete(key: refresh_token);
    _cookies.clear();
    log('Tokens and cookies cleared');
  }
}