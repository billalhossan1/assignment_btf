import 'package:assignment_btf/models/news_model.dart';
import 'package:assignment_btf/services/api/news_api_service.dart';
import 'package:assignment_btf/utils/error_log.dart';
import 'package:get/get.dart';

class NewsController extends GetxController {
  final _newsApiService = NewsApiService.instance;

  // Reactive news list
  final RxList<NewsModel> articles = <NewsModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool isRefreshing = false.obs;
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchNews();
  }

  // Fetch news articles
  Future<void> fetchNews({
    String country = 'us',
    String category = 'general',
  }) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final fetchedArticles = await _newsApiService.fetchTopHeadlines(
        country: country,
        category: category,
        pageSize: 50,
      );

      articles.value = fetchedArticles;

      if (articles.isEmpty) {
        errorMessage.value = 'No articles found';
      }
    } catch (e) {
      errorLog("NewsController fetchNews", e);
      errorMessage.value =
          'Failed to load news. Please check your internet connection and API key.';
    } finally {
      isLoading.value = false;
    }
  }

  // Refresh news (pull to refresh)
  Future<void> refreshNews() async {
    try {
      isRefreshing.value = true;
      errorMessage.value = '';

      final fetchedArticles = await _newsApiService.fetchTopHeadlines(
        country: 'us',
        category: 'general',
        pageSize: 50,
      );

      articles.value = fetchedArticles;

      if (articles.isEmpty) {
        errorMessage.value = 'No articles found';
      }
    } catch (e) {
      errorLog("NewsController refreshNews", e);
      errorMessage.value = 'Failed to refresh news';
    } finally {
      isRefreshing.value = false;
    }
  }

  // Search news
  Future<void> searchNews(String query) async {
    if (query.trim().isEmpty) {
      fetchNews();
      return;
    }

    try {
      isLoading.value = true;
      errorMessage.value = '';

      final fetchedArticles = await _newsApiService.searchNews(
        query: query,
        pageSize: 50,
      );

      articles.value = fetchedArticles;

      if (articles.isEmpty) {
        errorMessage.value = 'No articles found for "$query"';
      }
    } catch (e) {
      errorLog("NewsController searchNews", e);
      errorMessage.value = 'Failed to search news';
    } finally {
      isLoading.value = false;
    }
  }

  // Retry loading news
  void retry() {
    fetchNews();
  }
}
