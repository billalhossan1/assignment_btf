import 'package:flutter/material.dart';
import 'package:assignment_btf/constant/app_colors.dart';
import 'package:assignment_btf/widgets/texts/app_text.dart';
import 'package:assignment_btf/utils/app_size.dart';

class EmptyStateWidget extends StatelessWidget {
  const EmptyStateWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.message,
    this.actionButton,
    this.iconSize = 80,
  });

  final IconData icon;
  final String title;
  final String message;
  final Widget? actionButton;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppSize.width(value: 24.0)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon with gradient background
            Container(
              padding: EdgeInsets.all(AppSize.width(value: 24.0)),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    AppColors.instance.primary.withOpacity(0.1),
                    AppColors.instance.primary.withOpacity(0.05),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Icon(
                icon,
                size: iconSize,
                color: AppColors.instance.primary.withOpacity(0.6),
              ),
            ),
            SizedBox(height: AppSize.height(value: 24.0)),

            // Title
            AppText(
              data: title,
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: isDark
                  ? AppColors.instance.white200
                  : AppColors.instance.dark500,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: AppSize.height(value: 12.0)),

            // Message
            AppText(
              data: message,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: isDark
                  ? AppColors.instance.dark200
                  : AppColors.instance.dark300,
              textAlign: TextAlign.center,
              maxLines: 3,
            ),

            // Action button (if provided)
            if (actionButton != null) ...[
              SizedBox(height: AppSize.height(value: 24.0)),
              actionButton!,
            ],
          ],
        ),
      ),
    );
  }
}
