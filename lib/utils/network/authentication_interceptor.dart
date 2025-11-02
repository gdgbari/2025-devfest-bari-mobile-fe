import 'package:devfest_bari_2025/data.dart';
import 'package:devfest_bari_2025/utils.dart';
import 'package:dio/dio.dart';

class AuthenticationInterceptor extends InterceptorsWrapper {
  final AuthenticationService _authenticationService;
  static const String _retryKey = 'auth_retry_count';
  static const int _maxRetries = 5;

  AuthenticationInterceptor(this._authenticationService);

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      // Check if a retry has already been made for this request
      final retryCount = (err.requestOptions.extra[_retryKey] as int?) ?? 0;
      
      if (retryCount >= _maxRetries) {
        // If we've already made the maximum number of retries, propagate the error
        return super.onError(err, handler);
      }

      // Attempt to update the token
      try {
        await _authenticationService.updateToken(forceRefresh: true);
        
        // Verify that the token has actually been updated
        final currentToken = HttpClient().dio.options.headers['Authorization'];
        if (currentToken == null || !currentToken.toString().startsWith('Bearer ')) {
          // If the token is not present after the update,
          // it means the user is no longer authenticated
          return super.onError(err, handler);
        }
      } catch (_) {
        // If the refresh fails, propagate the original error
        return super.onError(err, handler);
      }
      
      try {
        // Create a copy of the headers without Authorization to use the globally updated one
        final updatedHeaders = Map<String, dynamic>.from(err.requestOptions.headers);
        updatedHeaders.remove('Authorization');
        
        // Update the extra with the retry counter
        final updatedExtra = Map<String, dynamic>.from(err.requestOptions.extra);
        updatedExtra[_retryKey] = retryCount + 1;
        
        final response = await HttpClient().dio.request(
          err.requestOptions.path,
          options: Options(
            method: err.requestOptions.method,
            headers: updatedHeaders,
            extra: updatedExtra,
          ),
          cancelToken: err.requestOptions.cancelToken,
          data: err.requestOptions.data,
          queryParameters: err.requestOptions.queryParameters,
        );
        return handler.resolve(response);
      } on DioException catch (e) {
        // If the retry request receives a 401 again, propagate the error without further retries
        return super.onError(e, handler);
      } catch (_) {
        return handler.reject(err);
      }
    } else {
      super.onError(err, handler);
    }
  }
}
