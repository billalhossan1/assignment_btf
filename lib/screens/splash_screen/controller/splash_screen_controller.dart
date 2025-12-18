import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:assignment_btf/routes/app_routes.dart';
import 'package:assignment_btf/services/storage_services/get_storage_services.dart';
import 'package:assignment_btf/utils/error_log.dart';

class SplashScreenController extends GetxController {
  ////////////  object
  GetStorageServices storageServices = GetStorageServices.instance;
  RxDouble animation = 0.0.obs;
  RxDouble animation2 = 0.0.obs;

  Future<void> onInitialDataLoadScreen() async {
    try {
      Future.delayed(Durations.medium1, () {
        animation.value = 1.0;
        animation2.value = 1.0;
      });

      var value = storageServices.getOnboardScreen();
      Future.delayed(Duration(seconds: 3), () {
        if (value) {
          Get.offAllNamed(AppRoutes.instance.appNavigationScreen);
        } else {
          Get.offAllNamed(AppRoutes.instance.wellCome);
        }
      });
    } catch (e) {
      errorLog("onInitialDataLoadScreen", e);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.offAllNamed(AppRoutes.instance.errorScreen);
      });
    }
  }

  @override
  void onInit() {
    onInitialDataLoadScreen();
    super.onInit();
  }
}
