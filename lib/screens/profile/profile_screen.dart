import 'package:flutter/material.dart';
import 'package:assignment_btf/constant/app_colors.dart';
import 'package:assignment_btf/controllers/theme_controller.dart';
import 'package:assignment_btf/widgets/buttons/flutter_switch.dart';
import 'package:assignment_btf/widgets/texts/app_text.dart';
import 'package:assignment_btf/utils/app_size.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.put(ThemeController());
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? AppColors.instance.dark900
          : AppColors.instance.white100,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: EdgeInsets.all(AppSize.width(value: 20.0)),
              decoration: BoxDecoration(
                color: isDark
                    ? AppColors.instance.dark800
                    : AppColors.instance.white50,
                boxShadow: [
                  BoxShadow(
                    color:
                        (isDark
                                ? AppColors.instance.dark900
                                : AppColors.instance.dark500)
                            .withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Profile avatar
                  Container(
                    padding: EdgeInsets.all(AppSize.width(value: 20.0)),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          AppColors.instance.primary,
                          AppColors.instance.primary.withOpacity(0.7),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Icon(
                      Icons.person,
                      size: 50,
                      color: AppColors.instance.white50,
                    ),
                  ),
                  SizedBox(height: AppSize.height(value: 16.0)),

                  // Name
                  AppText(
                    data: 'User Profile',
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: isDark
                        ? AppColors.instance.white200
                        : AppColors.instance.dark500,
                  ),
                  SizedBox(height: AppSize.height(value: 4.0)),

                  AppText(
                    data: 'Manage your preferences',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: isDark
                        ? AppColors.instance.dark200
                        : AppColors.instance.dark300,
                  ),
                ],
              ),
            ),

            // Settings list
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(AppSize.width(value: 16.0)),
                children: [
                  // Appearance section
                  _buildSectionTitle(context, 'Appearance'),
                  SizedBox(height: AppSize.height(value: 12.0)),

                  // Theme toggle
                  Obx(
                    () => _buildSettingTile(
                      context,
                      icon: Icons.dark_mode_outlined,
                      title: 'Dark Mode',
                      subtitle: 'Switch between light and dark theme',
                      trailing: FlutterSwitch(
                        width: 50,
                        height: 28,
                        toggleSize: 22,
                        value: themeController.isDarkMode.value,
                        borderRadius: 20,
                        padding: 3,
                        activeColor: AppColors.instance.primary,
                        inactiveColor: isDark
                            ? AppColors.instance.dark700
                            : AppColors.instance.dark200,
                        onToggle: (value) => themeController.toggleTheme(),
                      ),
                    ),
                  ),
                  SizedBox(height: AppSize.height(value: 24.0)),

                  // About section
                  _buildSectionTitle(context, 'About'),
                  SizedBox(height: AppSize.height(value: 12.0)),

                  _buildSettingTile(
                    context,
                    icon: Icons.info_outline,
                    title: 'App Version',
                    subtitle: '1.0.0',
                  ),

                  _buildSettingTile(
                    context,
                    icon: Icons.code,
                    title: 'Built with',
                    subtitle: 'Flutter & GetX',
                  ),

                  _buildSettingTile(
                    context,
                    icon: Icons.star_outline,
                    title: 'Features',
                    subtitle: 'Task Management • News Feed • Notifications',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: EdgeInsets.only(left: AppSize.width(value: 4.0)),
      child: AppText(
        data: title,
        fontSize: 13,
        fontWeight: FontWeight.w700,
        color: isDark ? AppColors.instance.dark200 : AppColors.instance.dark400,
      ),
    );
  }

  Widget _buildSettingTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: AppSize.height(value: 12.0)),
        padding: EdgeInsets.all(AppSize.width(value: 16.0)),
        decoration: BoxDecoration(
          color: isDark
              ? AppColors.instance.dark800
              : AppColors.instance.white50,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isDark
                ? AppColors.instance.dark700
                : AppColors.instance.white300,
          ),
        ),
        child: Row(
          children: [
            // Icon
            Container(
              padding: EdgeInsets.all(AppSize.width(value: 10.0)),
              decoration: BoxDecoration(
                color: AppColors.instance.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, size: 24, color: AppColors.instance.primary),
            ),
            SizedBox(width: AppSize.width(value: 16.0)),

            // Title and subtitle
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    data: title,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: isDark
                        ? AppColors.instance.white200
                        : AppColors.instance.dark500,
                  ),
                  SizedBox(height: AppSize.height(value: 4.0)),
                  AppText(
                    data: subtitle,
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: isDark
                        ? AppColors.instance.dark200
                        : AppColors.instance.dark300,
                    maxLines: 2,
                  ),
                ],
              ),
            ),

            // Trailing widget
            if (trailing != null) ...[
              SizedBox(width: AppSize.width(value: 12.0)),
              trailing,
            ],
          ],
        ),
      ),
    );
  }
}
