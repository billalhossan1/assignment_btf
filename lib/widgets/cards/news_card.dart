import 'package:flutter/material.dart';
import 'package:assignment_btf/constant/app_colors.dart';
import 'package:assignment_btf/models/news_model.dart';
import 'package:assignment_btf/widgets/texts/app_text.dart';
import 'package:assignment_btf/widgets/app_image/app_image.dart';
import 'package:assignment_btf/utils/app_size.dart';

class NewsCard extends StatelessWidget {
  const NewsCard({super.key, required this.article, required this.onTap});

  final NewsModel article;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: AppSize.height(value: 16.0)),
        decoration: BoxDecoration(
          color: isDark
              ? AppColors.instance.dark800
              : AppColors.instance.white50,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color:
                  (isDark
                          ? AppColors.instance.dark900
                          : AppColors.instance.dark500)
                      .withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              child:
                  article.urlToImage != null && article.urlToImage!.isNotEmpty
                  ? AppImage(
                      url: article.urlToImage!,
                      height: 200,
                      width: double.infinity,
                      boxFit: BoxFit.cover,
                    )
                  : Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.instance.primary.withOpacity(0.3),
                            AppColors.instance.primary.withOpacity(0.1),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Icon(
                        Icons.article_outlined,
                        size: 60,
                        color: AppColors.instance.primary.withOpacity(0.5),
                      ),
                    ),
            ),

            // Content
            Padding(
              padding: EdgeInsets.all(AppSize.width(value: 16.0)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Source and time
                  Row(
                    children: [
                      // Source
                      if (article.source?.name != null) ...[
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: AppSize.width(value: 10.0),
                            vertical: AppSize.height(value: 4.0),
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.instance.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: AppText(
                            data: article.source!.name!,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: AppColors.instance.primary,
                          ),
                        ),
                        SizedBox(width: AppSize.width(value: 8.0)),
                      ],

                      // Time
                      AppText(
                        data: article.getFormattedDate(),
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: isDark
                            ? AppColors.instance.dark200
                            : AppColors.instance.dark300,
                      ),
                    ],
                  ),
                  SizedBox(height: AppSize.height(value: 12.0)),

                  // Title
                  AppText(
                    data: article.title ?? 'No title',
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: isDark
                        ? AppColors.instance.white200
                        : AppColors.instance.dark500,
                    maxLines: 3,
                  ),
                  SizedBox(height: AppSize.height(value: 8.0)),

                  // Description
                  if (article.description != null &&
                      article.description!.isNotEmpty) ...[
                    AppText(
                      data: article.description!,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: isDark
                          ? AppColors.instance.dark200
                          : AppColors.instance.dark300,
                      maxLines: 2,
                    ),
                    SizedBox(height: AppSize.height(value: 12.0)),
                  ],

                  // Read more indicator
                  Row(
                    children: [
                      AppText(
                        data: 'Read more',
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.instance.primary,
                      ),
                      SizedBox(width: AppSize.width(value: 4.0)),
                      Icon(
                        Icons.arrow_forward,
                        size: 14,
                        color: AppColors.instance.primary,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
