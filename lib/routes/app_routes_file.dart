import 'package:assignment_btf/routes/app_routes.dart';
import 'package:assignment_btf/routes/bindings/auth_binding.dart';
import 'package:assignment_btf/routes/bindings/navigation_screen_binding.dart';
import 'package:assignment_btf/routes/bindings/splash_screen_binding.dart';
import 'package:assignment_btf/routes/internet_check_middle_ware.dart';
import 'package:assignment_btf/screens/about_us_screen/about_us_screen.dart';
import 'package:assignment_btf/screens/app_navigation_screen/app_navigation_screen.dart';
import 'package:assignment_btf/screens/auth_all_screens/change_password_screen/change_password_screen.dart';
import 'package:assignment_btf/screens/auth_all_screens/forgot_screen/forgot_screen.dart';
import 'package:assignment_btf/screens/auth_all_screens/login_screen/login_screen.dart';
import 'package:assignment_btf/screens/auth_all_screens/otp_verification_screen/otp_verification_screen.dart';
import 'package:assignment_btf/screens/auth_all_screens/sign_up_screen/sign_up_screen.dart';
import 'package:assignment_btf/screens/error_screen/error_screen.dart';
import 'package:assignment_btf/screens/not_found_screen/not_found_screen.dart';
import 'package:assignment_btf/screens/privacy_policy_screen/privacy_policy_screen.dart';
import 'package:assignment_btf/screens/splash_screen/splash_screen.dart';
import 'package:assignment_btf/screens/terms_and_conditions_screen/terms_and_conditions_screen.dart';
import 'package:assignment_btf/screens/main_navigation/main_navigation_screen.dart';
import 'package:get/get.dart';

List<GetPage> appRootRoutesFile = <GetPage>[
  /////////////////  splash screen start
  GetPage(
    name: AppRoutes.instance.initial,
    binding: SplashScreenBinding(),
    page: () => const SplashScreen(),
  ),
  GetPage(
    name: AppRoutes.instance.errorScreen,
    binding: SplashScreenBinding(),
    page: () => const ErrorScreen(),
  ),
  GetPage(
    name: AppRoutes.instance.notFoundScreen,
    binding: SplashScreenBinding(),
    page: () => const NotFoundScreen(),
  ),
  ///////////////////////  auth all start
  GetPage(
    name: AppRoutes.instance.loginScreen,
    binding: AuthBinding(),
    page: () => const LoginScreen(),
    middlewares: [InternetCheckMiddleWare()],
  ),
  GetPage(
    name: AppRoutes.instance.forgotScreen,
    binding: AuthBinding(),
    page: () => const ForgotScreen(),
    middlewares: [InternetCheckMiddleWare()],
  ),
  GetPage(
    name: AppRoutes.instance.signUpScreen,
    binding: AuthBinding(),
    page: () => const SignUpScreen(),
    middlewares: [InternetCheckMiddleWare()],
  ),
  GetPage(
    name: AppRoutes.instance.otpVerificationScreen,
    binding: AuthBinding(),
    page: () => const OtpVerificationScreen(),
    middlewares: [InternetCheckMiddleWare()],
  ),
  GetPage(
    name: AppRoutes.instance.changePasswordScreen,
    binding: AuthBinding(),
    page: () => const ChangePasswordScreen(),
    middlewares: [InternetCheckMiddleWare()],
  ),
  ///////////////////////  auth all end
  /////////////////////  app base start
  GetPage(
    name: AppRoutes.instance.appNavigationScreen,
    binding: NavigationScreenBinding(),
    page: () => const AppNavigationScreen(),
    middlewares: [InternetCheckMiddleWare()],
  ),
  GetPage(
    name: AppRoutes.instance.termsAndConditions,
    binding: NavigationScreenBinding(),
    page: () => const TermsAndConditionsScreen(),
    middlewares: [InternetCheckMiddleWare()],
  ),
  GetPage(
    name: AppRoutes.instance.privacyPolicy,
    binding: NavigationScreenBinding(),
    page: () => const PrivacyPolicyScreen(),
    middlewares: [InternetCheckMiddleWare()],
  ),
  GetPage(
    name: AppRoutes.instance.aboutUs,
    binding: NavigationScreenBinding(),
    page: () => const AboutUsScreen(),
    middlewares: [InternetCheckMiddleWare()],
  ),
  /////////////////////  app base end
  /////////////////////  main navigation
  GetPage(
    name: AppRoutes.instance.mainNavigationScreen,
    page: () => const MainNavigationScreen(),
  ),
];
