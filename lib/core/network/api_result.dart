import '../constants/app_string.dart';
import '../utils/enum.dart';

class APIResult<T> {
  late APIResultType apiResultType;
  String? message;
  T? result;

  APIResult.loading({this.result}) : assert(T != dynamic) {
    apiResultType = APIResultType.loading;
    message = AppString.loading;
  }

  APIResult.noInternet() : assert(T != dynamic) {
    apiResultType = APIResultType.noInternet;
    message = AppString.noInternetAvailable;
    result = null;
  }

  APIResult.success(this.message, this.result) : assert(T != dynamic) {
    apiResultType = APIResultType.success;
  }

  APIResult.failure(this.message, {this.result}) : assert(T != dynamic) {
    apiResultType = APIResultType.failure;
  }

  APIResult.userUnauthorised() : assert(T != dynamic) {
    apiResultType = APIResultType.unauthorised;
  }

  APIResult.timeOut() : assert(T != dynamic) {
    apiResultType = APIResultType.timeOut;
  }

  APIResult.userDeleted() : assert(T != dynamic) {
    apiResultType = APIResultType.notFound;
  }

  APIResult.sessionExpired() : assert(T != dynamic) {
    apiResultType = APIResultType.sessionExpired;
    message = AppString.sessionExpired;
    result = null;
  }

  static bool isLoading(APIResult? value) =>
      value != null && value.apiResultType == APIResultType.loading;

  @override
  String toString() {
    return 'APIResult{apiResultType: $apiResultType, message: $message, data: $result}';
  }
}
