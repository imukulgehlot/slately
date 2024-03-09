import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../basic_features.dart';

class NoInternet {
  final Connectivity _connectivity = Connectivity();

  Future<ConnectivityResult> checkConnectivity() async {
    ConnectivityResult result = ConnectivityResult.none;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }

    return result;
  }
}

enum ConnectivityStatus { wifi, cellular, offline }

class ConnectivityService {
  // Create our public controller
  StreamController<ConnectivityStatus> connectionStatusController =
      StreamController<ConnectivityStatus>();

  ConnectivityService() {
    // Subscribe to the connectivity Chanaged Steam
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result != ConnectivityResult.none) {
        // ManageSubscription.instance.getRestorePurchases();
        //on regaining internet connection
      }
      connectionStatusController.add(_getStatusFromResult(result));
    });
  }

  // Convert from the third part enum to our own enum
  ConnectivityStatus _getStatusFromResult(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.mobile:
        return ConnectivityStatus.cellular;
      case ConnectivityResult.wifi:
        return ConnectivityStatus.wifi;
      case ConnectivityResult.none:
        return ConnectivityStatus.offline;
      default:
        return ConnectivityStatus.offline;
    }
  }

  static Future<bool> isConnected() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }
}

class NetworkErrorDialog extends StatelessWidget {
  const NetworkErrorDialog({Key? key, this.onPressed}) : super(key: key);

  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
                width: Dimensions.w200,
                child: Image.asset(ImageAsset.noConnection)),
            SizedBox(height: Dimensions.h32),
            Text(
              "Whoops!",
              style: fontStyleBold18,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: Dimensions.h16),
            Text(
              AppString.noInternetAvailable,
              style: fontStyleSemiBold14,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              AppString.checkYourConnectionAndTryAgain,
              style: fontStyleRegular14,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: Dimensions.h16),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                if (onPressed != null) {
                  onPressed!();
                }
              },
              child: const Text(AppString.ok),
            )
          ],
        ),
      ),
    );
  }
}
