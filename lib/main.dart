
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'core/constants/app_utils.dart';
import 'core/utils/app_loader.dart';
import 'features/my_app.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializingInitials();

  Future.delayed(const Duration(milliseconds: 500), () => runApp(const MyApp()));
}


initializingInitials() async {
  await GetStorage.init();
  await Loader.instance.init();
  orientations();
  AppUtils.config();
}
