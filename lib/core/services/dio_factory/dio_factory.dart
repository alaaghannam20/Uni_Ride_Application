import 'package:dio/dio.dart';
import 'package:uni_ride_application/core/network/app_endpoints.dart';
import 'package:uni_ride_application/core/storage/app_prefs.dart';

class DioFactory {
  static Dio? _dioFactory;

  static Dio get dio {
    if (_dioFactory == null) {
      _dioFactory = Dio(
        BaseOptions(
          baseUrl: AppEndpoints.baseUrl,
          connectTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 30),
        ),
      );
      _dioFactory!.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            final token = AppPrefs.getToken();
            if (token != null) {
              options.headers['Authorization'] = 'Bearer $token';
            }
            handler.next(options);
          },
        ),
      );
    }
    return _dioFactory!;
  }

  //  POST method
  static Future<Response> post(String endpoint, {dynamic data, Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await dio.post(endpoint, data: data, queryParameters: queryParameters);
      return response;
    } catch (e) {
      throw Exception(_handleError(e));
    }
  }

  // GET method
  static Future<Response> get(String endpoint, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await dio.get(endpoint, queryParameters: queryParameters);
      return response;
    } catch (e) {
      throw Exception(_handleError(e));
    }
  }

  // Error Handler
  static String _handleError(dynamic e) {
    if (e is DioException) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        return 'Connection timeout, try again';
      }
      if (e.type == DioExceptionType.connectionError) {
        return 'No internet connection';
      }
      if (e.type == DioExceptionType.badResponse) {
        final data = e.response?.data;
        if (data is Map && data['message'] != null) return data['message'] as String;
        return 'Server error';
      }
      if (e.type == DioExceptionType.cancel) {
        return 'Request cancelled';
      }
    }
    return 'Unexpected error occurred';
  }
}