import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../core/basic_features.dart';
import '../core/theme/app_theme_data.dart';
import 'admin/image_upload_screen.dart';
import 'home/home_screen.dart';
import 'home/view_wallpaper.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: (_, widget) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: GetMaterialApp(
                      builder: EasyLoading.init(
              builder: (context, child) => MediaQuery(
                data: MediaQuery.of(context)
                    .copyWith(textScaler: const TextScaler.linear(1.0)),
                child: child!,
              ),
            ),
            darkTheme: AppThemeData.darkTheme,
            defaultTransition: Transition.cupertino,
            themeMode: ThemeMode.dark,
            debugShowCheckedModeBanner: false,
            title: AppString.appName,
            home:  HomeScreen(),
          ),
        );
      },
    );
}
