import 'package:flutter/material.dart';
import 'package:assignment_btf/constant/app_colors.dart';
import 'package:assignment_btf/controllers/news_controller.dart';
import 'package:assignment_btf/screens/news/news_detail_screen.dart';
import 'package:assignment_btf/widgets/cards/news_card.dart';
import 'package:assignment_btf/widgets/empty_state/empty_state_widget.dart';
import 'package:assignment_btf/widgets/texts/app_text.dart';
import 'package:assignment_btf/utils/app_size.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final newsController = Get.put(NewsController());
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
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          data: 'Latest News',
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          color: isDark
                              ? AppColors.instance.white200
                              : AppColors.instance.dark500,
                        ),
                        SizedBox(height: AppSize.height(value: 4.0)),
                        AppText(
                          data: 'Stay updated with the latest headlines',
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: isDark
                              ? AppColors.instance.dark200
                              : AppColors.instance.dark300,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // News list
            Expanded(
              child: Obx(() {
                // Loading state
                if (newsController.isLoading.value) {
                  return Skeletonizer(
                    enabled: true,
                    child: ListView.builder(
                      padding: EdgeInsets.all(AppSize.width(value: 16.0)),
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.only(
                            bottom: AppSize.height(value: 16.0),
                          ),
                          height: 300,
                          decoration: BoxDecoration(
                            color: isDark
                                ? AppColors.instance.dark800
                                : AppColors.instance.white50,
                            borderRadius: BorderRadius.circular(16),
                          ),
                        );
                      },
                    ),
                  );
                }

                // Error state
                if (newsController.errorMessage.value.isNotEmpty) {
                  return EmptyStateWidget(
                    icon: Icons.error_outline,
                    title: 'Oops! Something went wrong',
                    message: newsController.errorMessage.value,
                    actionButton: ElevatedButton.icon(
                      onPressed: () => newsController.retry(),
                      icon: const Icon(Icons.refresh),
                      label: const Text('Try Again'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.instance.primary,
                        foregroundColor: AppColors.instance.white50,
                        padding: EdgeInsets.symmetric(
                          horizontal: AppSize.width(value: 24.0),
                          vertical: AppSize.height(value: 14.0),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  );
                }

                // Empty state
                if (newsController.articles.isEmpty) {
                  return EmptyStateWidget(
                    icon: Icons.article_outlined,
                    title: 'No News Available',
                    message: 'Pull down to refresh and load the latest news',
                  );
                }

                // News list with pull to refresh
                return RefreshIndicator(
                  onRefresh: () => newsController.refreshNews(),
                  color: AppColors.instance.primary,
                  child: ListView.builder(
                    padding: EdgeInsets.all(AppSize.width(value: 16.0)),
                    itemCount: newsController.articles.length,
                    itemBuilder: (context, index) {
                      final article = newsController.articles[index];
                      return NewsCard(
                        article: article,
                        onTap: () {
                          Get.to(
                            () => NewsDetailScreen(article: article),
                            transition: Transition.rightToLeft,
                          );
                        },
                      );
                    },
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
