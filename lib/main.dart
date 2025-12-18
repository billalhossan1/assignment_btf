import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:assignment_btf/constant/app_colors.dart';
import 'package:assignment_btf/main_entry_app.dart';
import 'package:assignment_btf/services/connectivity_service/connectivity_service.dart';
import 'package:assignment_btf/services/notification/local_notification_service.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

String? userTimezone;
Future<void> main() async {
  //////////////  flutter binding initialize
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  ///////////// internet connectivity status check
  await ConnectivityService().initConnectivity();
  ///////////// devices orientation set
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  //////////// app navigation style set
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      systemNavigationBarColor: AppColors.instance.transparent,
      statusBarColor: AppColors.instance.transparent,
      systemNavigationBarDividerColor: Colors.transparent,
    ),
  );
  ////////////////  get storage
  await GetStorage.init();
  ///////////// internet connectivity status check
  Get.put(ConnectivityService());
  ///////////// initialize notification service
  await LocalNotificationService.instance.initialize();
  /////////  flutter main widget call
  // Get the user's current timezone dynamically
  userTimezone = await FlutterTimezone.getLocalTimezone();

  runApp(const MainEntryApp());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
