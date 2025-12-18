import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:assignment_btf/constant/app_assert_image.dart';
import 'package:assignment_btf/constant/app_colors.dart';
import 'package:assignment_btf/screens/auth_all_screens/forgot_screen/controller/forgot_screen_controller.dart';
import 'package:assignment_btf/screens/auth_all_screens/otp_verification_screen/controller/otp_related_function.dart';
import 'package:assignment_btf/utils/app_size.dart';
import 'package:assignment_btf/utils/gap.dart';
import 'package:assignment_btf/widgets/app_image/app_image.dart';
import 'package:assignment_btf/widgets/buttons/app_button.dart';
import 'package:assignment_btf/widgets/inputs/app_input_widget.dart';
import 'package:assignment_btf/widgets/inputs/formatter/otp_number_formatter.dart';
import 'package:assignment_btf/widgets/texts/app_text.dart';

class ForgotOtpInputScreen extends StatelessWidget {
  const ForgotOtpInputScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: ForgotScreenController(),
      builder: (controller) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSize.width(value: 20.0)),
          child: Column(
            children: [
              SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: AppSize.width(value: 20.0)),
                child: Form(
                  key: controller.formKey2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppImage(path: AppAssertImage.instance.otpVerification, width: AppSize.size.width * 0.8),

                      Column(
                        children: [
                          AppText(data: "Verify your account", fontSize: 25, fontWeight: FontWeight.w500),
                          Gap(height: 5),
                          AppText(data: "We've Sent a Code to ${OtpRelatedFunction().maskEmail(controller.emailController.text)}"),
                          Gap(height: 30),
                          AppInputWidget(
                            borderColor: AppColors.instance.primary300,
                            hintText: "_ _ _ _ _ _",
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.phone,
                            inputFormatters: [OtpNumberFormatter(), FilteringTextInputFormatter.digitsOnly],
                          ),
                          Gap(height: 10),
                          Obx(
                            () => RichText(
                              text: TextSpan(
                                text: "Resend code in ${OtpRelatedFunction().formatSecondFunction(controller.secondsRemaining.value)} ",
                                style: TextStyle(color: AppColors.instance.dark400, fontSize: 14),
                                children: [
                                  TextSpan(
                                    text: "Resend",
                                    style: TextStyle(color: controller.secondsRemaining.value > 0 ? AppColors.instance.dark400 : AppColors.instance.primary500),
                                    recognizer:
                                        TapGestureRecognizer()
                                          ..onTap = () {
                                            controller.reSendOtp();
                                          },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Gap(height: 50),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              Column(
                children: [
                  AppButton(
                    title: "Verify",
                    onTap: () {
                      controller.checkOtpFunction();
                    },
                  ),
                  Gap(height: 50),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
