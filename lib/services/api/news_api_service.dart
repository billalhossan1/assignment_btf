import 'package:assignment_btf/constant/api_constant.dart';
import 'package:assignment_btf/models/news_model.dart';
import 'package:assignment_btf/utils/error_log.dart';
import 'package:dio/dio.dart';

class NewsApiService {
  NewsApiService._privateConstructor();
  static final NewsApiService _instance = NewsApiService._privateConstructor();
  static NewsApiService get instance => _instance;

  final Dio _dio = Dio();

  Future<List<NewsModel>> fetchTopHeadlines({
    String country = 'us',
    String category = 'general',
    int pageSize = 20,
  }) async {
    try {
      final url =
          '${ApiConstant.instance.newsApiBaseUrl}${ApiConstant.instance.topHeadlines}';

      final response = await _dio.get(
        url,
        queryParameters: {
          'country': country,
          'category': category,
          'pageSize': pageSize,
          'apiKey': ApiConstant.instance.newsApiKey,
        },
      );

      if (response.statusCode == 200) {
        final data = response.data;
        if (data['status'] == 'ok') {
          final articles = data['articles'] as List;
          return articles
              .map((article) => NewsModel.fromJson(article))
              .toList();
        } else {
          errorLog(
            "NewsApiService fetchTopHeadlines",
            "API returned error: ${data['message']}",
          );
          return [];
        }
      } else {
        errorLog(
          "NewsApiService fetchTopHeadlines",
          "HTTP ${response.statusCode}",
        );
        return [];
      }
    } on DioException catch (e) {
      errorLog(
        "NewsApiService fetchTopHeadlines DioException",
        e.message ?? "Unknown error",
      );
      rethrow;
    } catch (e) {
      errorLog("NewsApiService fetchTopHeadlines", e);
      rethrow;
    }
  }

  Future<List<NewsModel>> searchNews({
    required String query,
    String sortBy = 'publishedAt',
    int pageSize = 20,
  }) async {
    try {
      final url =
          '${ApiConstant.instance.newsApiBaseUrl}${ApiConstant.instance.everything}';

      final response = await _dio.get(
        url,
        queryParameters: {
          'q': query,
          'sortBy': sortBy,
          'pageSize': pageSize,
          'apiKey': ApiConstant.instance.newsApiKey,
        },
      );

      if (response.statusCode == 200) {
        final data = response.data;
        if (data['status'] == 'ok') {
          final articles = data['articles'] as List;
          return articles
              .map((article) => NewsModel.fromJson(article))
              .toList();
        } else {
          errorLog(
            "NewsApiService searchNews",
            "API returned error: ${data['message']}",
          );
          return [];
        }
      } else {
        errorLog("NewsApiService searchNews", "HTTP ${response.statusCode}");
        return [];
      }
    } on DioException catch (e) {
      errorLog(
        "NewsApiService searchNews DioException",
        e.message ?? "Unknown error",
      );
      rethrow;
    } catch (e) {
      errorLog("NewsApiService searchNews", e);
      rethrow;
    }
  }
}
