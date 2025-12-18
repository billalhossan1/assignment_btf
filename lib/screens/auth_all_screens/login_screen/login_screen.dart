import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:assignment_btf/constant/app_assert_image.dart';
import 'package:assignment_btf/constant/app_colors.dart';
import 'package:assignment_btf/routes/app_routes.dart';
import 'package:assignment_btf/screens/auth_all_screens/login_screen/controller/login_screen_controller.dart';
import 'package:assignment_btf/utils/app_size.dart';
import 'package:assignment_btf/utils/gap.dart';
import 'package:assignment_btf/widgets/app_image/app_image.dart';
import 'package:assignment_btf/widgets/buttons/app_button.dart';
import 'package:assignment_btf/widgets/inputs/app_input_widget.dart';
import 'package:assignment_btf/widgets/texts/app_text.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: LoginScreenController(),
      builder: (controller) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSize.width(value: 20.0)),
              child: SizedBox(
                width: AppSize.size.width,
                child: Form(
                  key: controller.formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      spacing: AppSize.height(value: 30),
                      children: [
                        Gap(height: AppSize.height(value: 10)),
                        AppImage(path: AppAssertImage.instance.logo, width: AppSize.size.width * 0.6),

                        Column(
                          children: [
                            AppText(data: "Welcome!", fontSize: 40, fontWeight: FontWeight.w500),

                            AppText(data: "Sign in to continue", fontSize: 25, fontWeight: FontWeight.w200),
                            Gap(height: AppSize.height(value: 20)),
                          ],
                        ),

                        SizedBox(
                          height: AppSize.size.height * 0.3,
                          child: Column(
                            children: [
                              AppInputWidget(
                                controller: controller.emailTextEditingController,
                                borderColor: AppColors.instance.boxBg,
                                labelText: "Email",
                                hintText: "Enter your email",
                                keyboardType: TextInputType.emailAddress,
                                isEmail: true,
                                prefix: Icon(Icons.email_outlined, color: AppColors.instance.dark200),
                              ),
                              Gap(height: AppSize.height(value: 20)),
                              AppInputWidget(
                                controller: controller.passwordTextEditingController,
                                borderColor: AppColors.instance.boxBg,
                                labelText: "Password",
                                hintText: "Enter your password",
                                isPassWord: true,
                                textInputAction: TextInputAction.done,
                                maxLines: 1,
                                prefix: Icon(Icons.lock_outline, color: AppColors.instance.dark200),
                              ),
                              Gap(height: AppSize.height(value: 20)),
                              Align(
                                alignment: Alignment.centerRight,
                                child: GestureDetector(
                                  onTap: () {
                                    Get.toNamed(AppRoutes.instance.forgotScreen);
                                  },
                                  child: AppText(data: "Forgot Password?", color: AppColors.instance.primary500, fontWeight: FontWeight.bold, fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            AppButton(
                              title: "Login",
                              onTap: () {
                                controller.checkValidation();
                              },
                            ),

                            Gap(height: AppSize.height(value: 20)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AppText(data: "Don't have an account? ", color: AppColors.instance.dark200, fontSize: 16),
                                GestureDetector(
                                  onTap: () {
                                    Get.toNamed(AppRoutes.instance.signUpScreen);
                                  },
                                  child: AppText(data: "Sign up", color: AppColors.instance.primary500, fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Gap(height: AppSize.height(value: 50)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
