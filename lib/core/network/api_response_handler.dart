import 'dart:convert';

import '../basic_features.dart';
import '../storage/preference_storage.dart';
import '../utils/enum.dart';
import '../utils/extension.dart';
import '../utils/logger_util.dart';
import 'api_result.dart';
import 'api_result_constant.dart';
import 'base_response_model_entity.dart';
import 'network_result.dart';

APIResult<T> getAPIResultFromNetwork<T>(
  NetworkResult networkResult,
  T Function(dynamic json) converter,
) {
  switch (networkResult.networkResultType) {
    case NetworkResultType.error:
      var baseJson = json.decode(networkResult.result!);
      BaseResponseModel baseResponse = BaseResponseModel.fromJson(baseJson);
      return APIResult.failure(baseResponse.message,
          result: baseResponse.result);
    case NetworkResultType.noInternet:
      return APIResult.noInternet();
    case NetworkResultType.timeOut:
      AppUtils.showToast("Request timeOut");
      logger.w("user timeOut");
      return APIResult.timeOut();
    case NetworkResultType.unauthorised:
      PreferenceStorage.clearStorage();


      return APIResult.sessionExpired();

    case NetworkResultType.notFound:
      PreferenceStorage.clearStorage();
      return APIResult.userUnauthorised();
    case NetworkResultType.cacheError:
      return APIResult.failure(AppString.error);
    case NetworkResultType.success:
    default:
      {
        if (networkResult.result.isNullOrEmpty()) {
          logger.w("user isNullOrEmpty");
          return APIResult.failure("");
        }
        try {
          var baseJson = json.decode(networkResult.result!);
          BaseResponseModel baseResponse = BaseResponseModel.fromJson(baseJson);
          // BaseResponseModel baseResponseEntity = JsonConvert.fromJsonAsT(baseJson);
          if (baseResponse.status == APIResultConstant.error) {
            logger.w("user-- ERROR");
            return APIResult.failure(
              baseResponse.message.orEmpty(),
            );
          } else if (baseResponse.status ==
              APIResultConstant.userUnauthorised) {
            logger.w("user unautorized");
            // navigateToPageAndRemoveAllPage(GlobalVariable.navigatorKey.currentContext!, LOGIN_ROUTE,);
            return APIResult.userUnauthorised();
          } else if (baseResponse.status == APIResultConstant.userDeleted) {
            logger.w("user USER_DELETED");
            return APIResult.userUnauthorised();
          } else {
            if (kDebugMode) {
              print("Inside success");
            }
            if (baseResponse.result != null) {
              if (baseResponse.result.runtimeType != String) {
                T? responseModel = converter(baseResponse.result);

                return APIResult.success(
                    baseResponse.message.orEmpty(), responseModel);
              }
              return APIResult.success(
                  baseResponse.message.orEmpty(), baseResponse.result);
            } else {
              return APIResult.success(baseResponse.message.orEmpty(), null);
            }
          }
        } catch (e) {
          logger.w("result failure catch $e");
          // FirebaseCrashlytics.instance.recordError(e, s);
          return APIResult.failure(AppString.error);
        }
      }
  }
}

APIResult<T> getAPIResultFromNetworkWithoutBase<T>(
  NetworkResult networkResult,
  T Function(dynamic json) converter,
) {
  switch (networkResult.networkResultType) {
    case NetworkResultType.error:
      return APIResult.failure(AppString.error);
    case NetworkResultType.noInternet:
      return APIResult.noInternet();
    case NetworkResultType.unauthorised:
      return APIResult.userUnauthorised();
    case NetworkResultType.notFound:
      return APIResult.userDeleted();
    case NetworkResultType.success:
    default:
      {
        if (networkResult.result.isNullOrEmpty()) {
          return APIResult.failure("");
        }
        try {
          if (networkResult.result != null) {
            var baseJson = json.decode(networkResult.result!);
            T? responseModel = converter(baseJson);
            return APIResult.success(
              "",
              responseModel,
            );
          } else {
            return APIResult.success("", null);
          }
        } catch (e) {
          //FirebaseCrashlytics.instance.recordError(e, s);
          return APIResult.failure(e.toString());
        }
      }
  }
}

// APIResult<T> getAPIResultFromNetwork<T>(NetworkResult networkResult) {
//   switch (networkResult.networkResultType) {
//     case NetworkResultType.ERROR:
//       final ErrorResponse model =
//       ApiUtil.instance.jsonConverter(ErrorResponse(), networkResult.result.toString());
//       return APIResult.failure(model.message , result: networkResult.result.toString());
//     case NetworkResultType.NO_INTERNET:
//       return APIResult.noInternet();
//     case NetworkResultType.UNAUTHORISED:
//       StartupService.remove();
//       // navigateToPageAndRemoveAllPage(
//       //   GlobalVariable.navigatorKey.currentContext!,
//       //   DEACTIVE_ROUTE,
//       // );
//       /// todo ask
//       return APIResult.sessionExpired();

//     case NetworkResultType.NOTFOUND:
//       StartupService.remove();
//       // navigateToPageAndRemoveAllPage(
//       // GlobalVariable.navigatorKey.currentContext!,
//       // DEACTIVE_ROUTE,
//       // );
//       ///todo ask
//       return APIResult.userUnauthorised();
//     case NetworkResultType.CACHEERROR:
//       return APIResult.failure(AppString.ERROR);
//     case NetworkResultType.TIMEOUT:
//       return APIResult.failure(AppString.requestTimeout);
//     case NetworkResultType.SUCCESS:
//     default:
//       {
//         if (networkResult.result.isNullOrEmpty()) {
//           logger.w("user isNullOrEmpty");
//           return APIResult.failure("");
//         }
//         try {
//           return APIResult.success(null, networkResult.result.toString());
//         } catch (e, s) {
//           logger.w("result failure catch");
//           // FirebaseCrashlytics.instance.recordError(e, s);
//           return APIResult.failure(AppString.ERROR);
//         }
//       }
//   }
// }

// APIResult<T> getAPIResultFromNetworkWithoutBase<T>(
//     NetworkResult networkResult) {
//   switch (networkResult.networkResultType) {
//     case NetworkResultType.ERROR:
//       return APIResult.failure(AppString.ERROR);
//     case NetworkResultType.NO_INTERNET:
//       return APIResult.noInternet();
//     case NetworkResultType.UNAUTHORISED:
//       return APIResult.userUnauthorised();
//     case NetworkResultType.NOTFOUND:
//       return APIResult.userDeleted();
//     case NetworkResultType.SUCCESS:
//     default:
//       {
//         if (networkResult.result.isNullOrEmpty()) {
//           return APIResult.failure("", result: networkResult.result);
//         }
//         try {
//           if (networkResult.result != null) {
//             // var baseJson = json.decode(networkResult.result!);
//             // T? responseModel = JsonConvert.fromJsonAsT<T>(baseJson);
//             return APIResult.success(
//               "",
//               networkResult.result.toString(),
//             );
//           } else {
//             return APIResult.success("", null);
//           }
//         } catch (e, s) {
//           //FirebaseCrashlytics.instance.recordError(e, s);
//           return APIResult.failure(e.toString());
//         }
//       }
//   }
// }
