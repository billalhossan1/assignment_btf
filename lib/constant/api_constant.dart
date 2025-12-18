class ApiConstant {
  ApiConstant._privateConstructor();
  static final ApiConstant _instance = ApiConstant._privateConstructor();
  static ApiConstant get instance => _instance;

  // News API Configuration
  final String newsApiBaseUrl = "https://newsapi.org/v2";
  // TODO: Add your News API key here (Get free key from https://newsapi.org)
  final String newsApiKey = "YOUR_NEWS_API_KEY_HERE";

  // News API Endpoints
  final String topHeadlines = "/top-headlines";
  final String everything = "/everything";
}
