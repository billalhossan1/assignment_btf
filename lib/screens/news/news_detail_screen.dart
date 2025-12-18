import 'package:flutter/material.dart';
import 'package:assignment_btf/constant/app_colors.dart';
import 'package:assignment_btf/models/news_model.dart';
import 'package:assignment_btf/widgets/app_image/app_image.dart';
import 'package:assignment_btf/widgets/texts/app_text.dart';
import 'package:assignment_btf/utils/app_size.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';

class NewsDetailScreen extends StatelessWidget {
  const NewsDetailScreen({super.key, required this.article});

  final NewsModel article;

  Future<void> _openInBrowser() async {
    if (article.url == null) return;

    final uri = Uri.parse(article.url!);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  Future<void> _shareArticle() async {
    if (article.url == null) return;

    await Share.share(
      '${article.title}\n\n${article.url}',
      subject: article.title,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? AppColors.instance.dark900
          : AppColors.instance.white100,
      body: CustomScrollView(
        slivers: [
          // App bar with image
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            backgroundColor: isDark
                ? AppColors.instance.dark800
                : AppColors.instance.white50,
            leading: IconButton(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.instance.dark900.withOpacity(0.6),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.arrow_back,
                  color: AppColors.instance.white50,
                ),
              ),
              onPressed: () => Get.back(),
            ),
            actions: [
              IconButton(
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.instance.dark900.withOpacity(0.6),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.share, color: AppColors.instance.white50),
                ),
                onPressed: _shareArticle,
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background:
                  article.urlToImage != null && article.urlToImage!.isNotEmpty
                  ? Stack(
                      fit: StackFit.expand,
                      children: [
                        AppImage(
                          url: article.urlToImage!,
                          boxFit: BoxFit.cover,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                AppColors.instance.dark900.withOpacity(0.7),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  : Container(
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
                        size: 80,
                        color: AppColors.instance.primary.withOpacity(0.5),
                      ),
                    ),
            ),
          ),

          // Content
          SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(
                color: isDark
                    ? AppColors.instance.dark900
                    : AppColors.instance.white100,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(AppSize.width(value: 20.0)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Source and time
                    Row(
                      children: [
                        if (article.source?.name != null) ...[
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: AppSize.width(value: 12.0),
                              vertical: AppSize.height(value: 6.0),
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.instance.primary.withOpacity(
                                0.1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: AppText(
                              data: article.source!.name!,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppColors.instance.primary,
                            ),
                          ),
                          SizedBox(width: AppSize.width(value: 12.0)),
                        ],
                        AppText(
                          data: article.getFormattedDate(),
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: isDark
                              ? AppColors.instance.dark200
                              : AppColors.instance.dark300,
                        ),
                      ],
                    ),
                    SizedBox(height: AppSize.height(value: 16.0)),

                    // Title
                    AppText(
                      data: article.title ?? 'No title',
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: isDark
                          ? AppColors.instance.white200
                          : AppColors.instance.dark500,
                      maxLines: 10,
                    ),
                    SizedBox(height: AppSize.height(value: 12.0)),

                    // Author
                    if (article.author != null &&
                        article.author!.isNotEmpty) ...[
                      Row(
                        children: [
                          Icon(
                            Icons.person_outline,
                            size: 16,
                            color: isDark
                                ? AppColors.instance.dark200
                                : AppColors.instance.dark300,
                          ),
                          SizedBox(width: AppSize.width(value: 6.0)),
                          AppText(
                            data: 'By ${article.author}',
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: isDark
                                ? AppColors.instance.dark200
                                : AppColors.instance.dark300,
                          ),
                        ],
                      ),
                      SizedBox(height: AppSize.height(value: 16.0)),
                    ],

                    // Divider
                    Divider(
                      color: isDark
                          ? AppColors.instance.dark700
                          : AppColors.instance.white300,
                    ),
                    SizedBox(height: AppSize.height(value: 16.0)),

                    // Description
                    if (article.description != null &&
                        article.description!.isNotEmpty) ...[
                      AppText(
                        data: article.description!,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: isDark
                            ? AppColors.instance.white200
                            : AppColors.instance.dark500,
                        maxLines: 100,
                        height: 1.6,
                      ),
                      SizedBox(height: AppSize.height(value: 16.0)),
                    ],

                    // Content
                    if (article.content != null &&
                        article.content!.isNotEmpty) ...[
                      AppText(
                        data: article.content!,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: isDark
                            ? AppColors.instance.dark100
                            : AppColors.instance.dark400,
                        maxLines: 100,
                        height: 1.6,
                      ),
                      SizedBox(height: AppSize.height(value: 24.0)),
                    ],

                    // Read full article button
                    if (article.url != null) ...[
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: _openInBrowser,
                          icon: const Icon(Icons.open_in_new),
                          label: const Text('Read Full Article'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.instance.primary,
                            foregroundColor: AppColors.instance.white50,
                            padding: EdgeInsets.symmetric(
                              vertical: AppSize.height(value: 16.0),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ],
                    SizedBox(height: AppSize.height(value: 24.0)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
