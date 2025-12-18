import 'package:flutter/material.dart';
import 'package:assignment_btf/constant/app_theme.dart';
import 'package:assignment_btf/controllers/theme_controller.dart';
import 'package:assignment_btf/routes/app_routes.dart';
import 'package:assignment_btf/routes/app_routes_file.dart';
import 'package:assignment_btf/screens/error_screen/error_screen.dart';
import 'package:get/get.dart';

GlobalKey<NavigatorState>? appNavigatorStateKey = GlobalKey<NavigatorState>();

class MainEntryApp extends StatelessWidget {
  const MainEntryApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize theme controller
    final themeController = Get.put(ThemeController());

    return Obx(
      () => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        defaultTransition: Transition.zoom,
        initialRoute: AppRoutes.instance.initial,
        getPages: appRootRoutesFile,
        theme: AppTheme.instance.lightTheme,
        darkTheme: AppTheme.instance.darkTheme,
        themeMode: themeController.themeMode.value,
        enableLog: true,
        defaultGlobalState: true,
        transitionDuration: const Duration(milliseconds: 300),
        navigatorKey: appNavigatorStateKey,
        builder: (context, child) {
          ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
            return const ErrorScreen();
          };
          if (child != null) {
            return child;
          }
          return const SizedBox();
        },
      ),
    );
  }
}
