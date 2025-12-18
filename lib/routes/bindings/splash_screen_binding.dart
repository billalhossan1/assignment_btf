import 'package:get/get.dart';
import 'package:assignment_btf/screens/error_screen/controller/error_screen_controller.dart';
import 'package:assignment_btf/screens/not_found_screen/controller/not_found_screen_controller.dart';

import 'package:assignment_btf/screens/splash_screen/controller/splash_screen_controller.dart';

class SplashScreenBinding extends BindingsInterface {
  @override
  dependencies() {
    Get.lazyPut(() => SplashScreenController());
    Get.lazyPut(() => ErrorScreenController());
    Get.lazyPut(() => NotFoundScreenController());
  }
}
