import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import '../basic_features.dart';

class NoInterNetScreen extends StatefulWidget {
  const NoInterNetScreen({Key? key}) : super(key: key);

  @override
  State<NoInterNetScreen> createState() => _NoInterNetScreenState();
}

class _NoInterNetScreenState extends State<NoInterNetScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Container(
          padding: EdgeInsets.all(Dimensions.w20),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: Dimensions.w180,
                height: Dimensions.w180,
                child: Image.asset(ImageAsset.noConnection),
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: Dimensions.w15),
                child: Text(AppString.noInternetAvailable,
                    style: fontStyleRegular14),
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: Dimensions.w15),
                child: Text(AppString.checkYourConnectionAndTryAgain,
                    textAlign: TextAlign.center, style: fontStyleBold12),
              ),
              Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: Dimensions.w15),
                  child: MyButton(
                    onPressed: () async {
                      if (await isConnected()) {
                        _gotoHomePage();
                      } else {
                        AppUtils.showToast(AppString.noInternetAvailable);
                      }
                    },
                    title: AppString.retry,
                  ))
            ],
          ),
        ));
  }

  Future<void> _gotoHomePage() async {
    //Todo: give dashboard path
    // await navigateToPageAndRemoveAllPage(DASHBOARD_1);
  }

  Future<bool> isConnected() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }
}
