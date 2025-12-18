import 'package:get/get.dart';
import 'package:assignment_btf/screens/about_us_screen/controller/about_us_screen_controller.dart';
import 'package:assignment_btf/screens/app_navigation_screen/controller/app_navigation_screen_controller.dart';
import 'package:assignment_btf/screens/privacy_policy_screen/controller/privacy_policy_screen_controller.dart';
import 'package:assignment_btf/screens/terms_and_conditions_screen/controller/terms_and_conditions_screen_controller.dart';

class NavigationScreenBinding extends BindingsInterface {
  @override
  dependencies() {
    Get.lazyPut(() => AppNavigationScreenController());
    Get.lazyPut(() => TermsAndConditionsScreenController());
    Get.lazyPut(() => PrivacyPolicyScreenController());
    Get.lazyPut(() => AboutUsScreenController());
  }
}
