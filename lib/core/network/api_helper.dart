import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as network;

import '../constants/app_utils.dart';
import '../storage/preference_storage.dart';
import '../utils/extension.dart';
import '../utils/logger_util.dart';
import 'api_url.dart';
import 'network_result.dart';

class APIHelper {
  final bool _isDebug = kDebugMode;
  Map<String, String>? _headers;

  APIHelper._privateConstructor() {
    _createHeaders();
  }

  static final APIHelper _instance = APIHelper._privateConstructor();

  static APIHelper get instance => _instance;

  Future<NetworkResult> callPostApi(
      String path, dynamic params, bool isLoader) async {
    var callingURL = path;
    await _createHeaders();
    var parameter = json.encode(params);

    if (_isDebug) {
      timber("API URL -> $callingURL");
      timber("API Headers -> $_headers", usePrint: true);
      timber("API Parameters -> $parameter");
    }

    if (await isConnected()) {
      if (isLoader) {
        EasyLoading.show();
      }
      try {
        var resp = await network
            .post(Uri.parse(callingURL), body: parameter, headers: _headers)
            .timeout(const Duration(minutes: 1));
        EasyLoading.dismiss();

        if (_isDebug) logger.d("API ~~ Response -> ${jsonDecode(resp.body)}");
        if (resp.statusCode == 200 || resp.statusCode == 201) {
          logger.w("Status = 200 || 201");

          return Future.value(NetworkResult.success(resp.body));
        } else if (resp.statusCode == 401 || resp.statusCode == 403) {
          logger.w("Status = 401 || 403");

          return Future.value(NetworkResult.unAuthorised());
        } else {
          logger.w("Status = error");

          return Future.value(NetworkResult.error(resp.body));
        }
      } on TimeoutException {
        return Future.value(NetworkResult.timeout());
      } catch (e, s) {
        EasyLoading.dismiss();
        if (_isDebug) {
          timber(e);
          timber(s);
        } else {
          // FirebaseCrashlytics.instance.recordError(e, s);
        }
        return Future.value(NetworkResult.cacheError());
      }
    } else {
      // _showNoInternetDialog(0, path, params, isLoader);
      return Future.value(NetworkResult.noInternet());
    }
  }

  Future<NetworkResult> callGetApi(
      String path, dynamic params, bool isLoader,
      {Map<String, String>? customHeader}) async {
    var callingURL =
        Uri.parse(path).replace(queryParameters: params).toString();
    //Uri? uri;
    // final newURI = Uri().replace(queryParameters: params);
    await _createHeaders();
    if (_isDebug) {
      timber("API URL -> $callingURL");

      timber("API Headers -> ${customHeader ?? _headers}", usePrint: false);
    }

    if (await isConnected()) {
      if (isLoader) {
        EasyLoading.show();
      }
      try {
        var resp = await network
            .get(Uri.parse(callingURL), headers: customHeader ?? _headers)
            .timeout(const Duration(minutes: 1));

        if (_isDebug) timber("API Response -> ${resp.statusCode} ${resp.body}");
        EasyLoading.dismiss();

        logger.w(resp.statusCode);
        if (resp.statusCode == 200) {
          return Future.value(NetworkResult.success(resp.body));
        } else if (resp.statusCode == 401 || resp.statusCode == 403) {
          return Future.value(NetworkResult.unAuthorised());
        } else {
          return Future.value(NetworkResult.error(resp.body));
        }
      } on TimeoutException {
        return Future.value(NetworkResult.timeout());
      } catch (e, s) {
        EasyLoading.dismiss();
        if (_isDebug) {
          timber(e);
          timber(s);
        } else {
          // FirebaseCrashlytics.instance.recordError(e, s);
        }
        return Future.value(NetworkResult.cacheError());
      }
    } else {
      //  _showNoInternetDialog(1, path, params, isLoader);

      return Future.value(NetworkResult.noInternet());
    }
  }

  Future<NetworkResult> callPutApi(
      String path, dynamic params, bool isLoader) async {
    var callingURL =
        Uri.parse(path).replace(queryParameters: params).toString();
    //Uri? uri;
    // final newURI = Uri().replace(queryParameters: params);
    await _createHeaders();
    if (_isDebug) {
      timber("API URL -> $callingURL");
      timber("API Headers -> $_headers", usePrint: true);
    }

    if (await isConnected()) {
      if (isLoader) {
        EasyLoading.show();
      }
      try {
        var resp = await network.put(Uri.parse(callingURL), headers: _headers);
        if (_isDebug) timber("API Response -> ${resp.statusCode} ${resp.body}");
        EasyLoading.dismiss();

        logger.w(resp.statusCode);
        if (resp.statusCode == 200) {
          if (resp.body.startsWith("Message", 2)) {
            return Future.value(NetworkResult.error(resp.body));
          } else {
            return Future.value(NetworkResult.success(resp.body));
          }
        } else if (resp.statusCode == 401 || resp.statusCode == 403) {
          return Future.value(NetworkResult.unAuthorised());
        } else {
          return Future.value(NetworkResult.error(resp.body));
        }
      } catch (e, s) {
        EasyLoading.dismiss();
        if (_isDebug) {
          timber(e);
          timber(s);
        } else {
          // FirebaseCrashlytics.instance.recordError(e, s);
        }
        return Future.value(NetworkResult.cacheError());
      }
    } else {
      //  _showNoInternetDialog(1, path, params, isLoader);

      return Future.value(NetworkResult.noInternet());
    }
  }

  Future<NetworkResult> callPostMultiPart(
      String path, dynamic params, bool isLoader, String uploadFilePath,
      {String dataPathName = "data", String imagePathName = "image"}) async {
    var callingURL = path;
    /*  if (_notProperHeader())*/
    await _createHeadersForMultipart();

    var parameter = json.encode(params);
    if (_isDebug) {
      timber("API URL -> $callingURL");
      timber("API Headers -> $_headers");
      timber("API Parameters -> $parameter");
      timber("Selected Image Path -> $uploadFilePath");
    }

    if (await isConnected()) {
      if (isLoader) {
        EasyLoading.show();
      }
      FormData formData;
      if (uploadFilePath.isNotNullOrEmpty()) {
        formData = FormData.fromMap({
          dataPathName: parameter,
          imagePathName: await MultipartFile.fromFile(uploadFilePath)
        });
      } else {
        formData = FormData.fromMap({dataPathName: parameter});
      }

      timber(formData.fields.map((e) => timber("~~~~~~~~`${e.value}")));
      timber(formData.files.map((e) => timber("~~~~~~~~`${e.value.filename}")));
      try {
        var dio = Dio();
        var responseString = await dio.post(callingURL,
            data: formData,
            options:
                Options(headers: _headers, contentType: "application/json"));

        if (_isDebug) timber("API Response -> $responseString");

        EasyLoading.dismiss();
        if (responseString.statusCode == 200) {
          return Future.value(
              NetworkResult.success(json.encode(responseString.data)));
        } else if (responseString.statusCode == 401 ||
            responseString.statusCode == 403) {
          return Future.value(NetworkResult.unAuthorised());
        } else {
          return Future.value(
              NetworkResult.error(json.encode(responseString.data)));
        }
      } catch (e, s) {
        EasyLoading.dismiss();
        if (_isDebug) {
          timber(e);
          timber(s);
        } else {
          // FirebaseCrashlytics.instance.recordError(e, s);
        }
        return Future.value(NetworkResult.cacheError());
      }
    } else {
      return Future.value(NetworkResult.noInternet());
    }
  }

  Future<NetworkResult> callPostMultiPartForMultipleFiles(
      String path, List<String>? uploadFilePaths, bool isLoader,
      {String imagePathName = "personalPhotos"}) async {
    var callingURL = path;
    await _createHeadersForMultipart();

    if (_isDebug) {
      timber("API URL -> $callingURL");
      timber("API Headers -> $_headers", usePrint: true);
      timber("Selected Image Path -> $uploadFilePaths");
    }

    if (await isConnected()) {
      if (isLoader) {
        EasyLoading.show();
      }
      List<MultipartFile> multiPartList = [];

      if (!uploadFilePaths.isNullOrEmpty()) {
        multiPartList = [];

        for (int i = 0; i < uploadFilePaths!.length; i++) {
          var localPath = uploadFilePaths[i];
          if (!localPath.isNullOrEmpty()) {
            var multipartFile =
                await MultipartFile.fromFile(uploadFilePaths[i]);
            multiPartList.add(multipartFile);
          }
        }
      }

      try {
        var formData = FormData.fromMap({imagePathName: multiPartList});
        var dio = Dio();
        var responseString = await dio.post(callingURL,
            data: formData,
            options:
                Options(headers: _headers, contentType: "application/json"));

        if (_isDebug) timber("API Response -> $responseString");
        EasyLoading.dismiss();

        if (responseString.statusCode == 200) {
          return Future.value(
              NetworkResult.success(json.encode(responseString.data)));
        } else if (responseString.statusCode == 401 ||
            responseString.statusCode == 403) {
          return Future.value(NetworkResult.unAuthorised());
        } else {
          return Future.value(
              NetworkResult.error(json.encode(responseString.data)));
        }
      } catch (e, s) {
        EasyLoading.dismiss();
        if (_isDebug) {
          timber(e);
          timber(s);
        } else {
          // FirebaseCrashlytics.instance.recordError(e, s);
        }
        return Future.value(NetworkResult.cacheError());
      }
    } else {
      return Future.value(NetworkResult.noInternet());
    }
  }

  Future<NetworkResult> callPostMultiPartWithFromData(
      String path, FormData formData, bool isLoader,
      {String imagePathName = "image"}) async {
    var callingURL = path;
    /* if (_notProperHeader()) */
    await _createHeadersForMultipart();
    if (_isDebug) {
      timber("API URL -> $callingURL");
      timber("API Headers -> $_headers", usePrint: true);
      timber("API Parameters -> ${formData.fields}");
    }

    if (await isConnected()) {
      if (isLoader) {
        EasyLoading.show();
      }
      try {
        var dio = Dio();
        var responseString = await dio.post(callingURL,
            data: formData,
            options:
                Options(headers: _headers, contentType: "application/json"));

        if (_isDebug) timber("API Response -> $responseString");
        EasyLoading.dismiss();

        if (responseString.statusCode == 200) {
          return Future.value(
              NetworkResult.success(json.encode(responseString.data)));
        } else if (responseString.statusCode == 401 ||
            responseString.statusCode == 403) {
          return Future.value(NetworkResult.unAuthorised());
        } else {
          return Future.value(
              NetworkResult.error(json.encode(responseString.data)));
        }
      } catch (e, s) {
        EasyLoading.dismiss();
        if (_isDebug) {
          timber(e);
          timber(s);
        } else {
          // FirebaseCrashlytics.instance.recordError(e, s);
        }
        return Future.value(NetworkResult.cacheError());
      }
    } else {
      return Future.value(NetworkResult.noInternet());
    }
  }

  bool notProperHeader() =>
      _headers == null ||
      _headers!.isEmpty ||
      _headers?.containsKey(NetworkConstant.authorization) == false;

  Future<void> _createHeaders() async {
    String authToken = await PreferenceStorage.getToken();
    if (kDebugMode) {
      print("Api header auth token ===> $authToken");
    }

    if (authToken.isNotEmpty) {
      _headers = {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "device-type": Platform.isIOS ? "iOS" : "Android",
        "device-name": Platform.isIOS
            ? AppUtils.iosInfo?.name ?? ''
            : AppUtils.androidInfo?.model ?? '',
        NetworkConstant.authorization: NetworkConstant.bearer + authToken,
      };
    } else {
      _headers = {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "device-type": Platform.isIOS ? "iOS" : "Android",
        "device-name": Platform.isIOS
            ? AppUtils.iosInfo?.name ?? ''
            : AppUtils.androidInfo?.model ?? '',
        NetworkConstant.authorization: NetworkConstant.bearer + authToken,
      };
    }
  }

  Future<void> _createHeadersForMultipart() async {
    String authToken = await PreferenceStorage.getToken();
    if (authToken.isNotEmpty) {
      _headers = {
        "Content-Type": "multipart/form-data",
        // 'Accept': '*/*',
        "Accept": "application/json",
        "device-type": Platform.isIOS ? "iOS" : "Android",
        "device-name": Platform.isIOS
            ? AppUtils.iosInfo?.name ?? ''
            : AppUtils.androidInfo?.model ?? '',
        NetworkConstant.authorization: NetworkConstant.bearer + authToken,
      };
    } else {
      _headers = {
        // 'Accept': '*/*',
        "Accept": "application/json",
        "Content-Type": "multipart/form-data",
        "device-type": Platform.isIOS ? "iOS" : "Android",
        "device-name": Platform.isIOS
            ? AppUtils.iosInfo?.name ?? ''
            : AppUtils.androidInfo?.model ?? '',
        NetworkConstant.authorization: NetworkConstant.bearer + authToken,
      };
    }
  }

  Future<void> updateHeaders() async => await _createHeaders();

  Future<bool> isConnected() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  void makeHeaderNull() => _headers = null;
}
