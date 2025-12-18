import 'package:flutter/material.dart';
import 'package:assignment_btf/constant/app_colors.dart';
import 'package:assignment_btf/screens/auth_all_screens/change_password_screen/controller/change_password_screen_controller.dart';
import 'package:assignment_btf/utils/app_size.dart';
import 'package:assignment_btf/utils/gap.dart';
import 'package:assignment_btf/widgets/buttons/app_button.dart';
import 'package:assignment_btf/widgets/inputs/app_input_widget.dart';
import 'package:assignment_btf/widgets/texts/app_text.dart';
import 'package:get/get.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: ChangePasswordScreenController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(title: AppText(data: "Change Password", fontSize: 20), centerTitle: true),

          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: AppSize.width(value: 20.0)),
            child: Form(
              key: controller.formKey,
              child: Column(
                children: [
                  Gap(height: 20),
                  AppInputWidget(
                    controller: controller.oldPasswordTextEditingController,
                    borderColor: AppColors.instance.boxBg,
                    labelText: "Old Password",
                    isPassWord: true,

                    maxLines: 1,
                    prefix: Icon(Icons.lock_outline, color: AppColors.instance.dark200),
                  ),
                  Gap(height: 20),
                  AppInputWidget(
                    controller: controller.newPasswordTextEditingController,
                    borderColor: AppColors.instance.boxBg,
                    labelText: "New Password",
                    isPassWord: true,

                    maxLines: 1,
                    prefix: Icon(Icons.lock_outline, color: AppColors.instance.dark200),
                  ),
                  Gap(height: 20),
                  AppInputWidget(
                    isPassWordSecondValidation: true,
                    isPassWordSecondValidationController: controller.newPasswordTextEditingController,
                    controller: controller.confirmPasswordTextEditingController,
                    borderColor: AppColors.instance.boxBg,
                    labelText: "Confirm New Password",
                    isPassWord: true,
                    textInputAction: TextInputAction.done,
                    maxLines: 1,
                    prefix: Icon(Icons.lock_outline, color: AppColors.instance.dark200),
                  ),
                ],
              ),
            ),
          ),

          bottomNavigationBar: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSize.width(value: 20.0)),
              child: AppButton(
                title: "Submit",
                onTap: () {
                  controller.checkData();
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
