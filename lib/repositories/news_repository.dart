import 'package:news_today/models/news_models.dart';

import '../api/news_api.dart';

class NewsRepository {
  final NewsApi newsApi = NewsApi();

  Future<List<NewsArticle>> fetchTopHeadlines() async {
    return await newsApi.fetchTopHeadlines();
  }

  Future<List<NewsArticle>> fetchCategoryNews(String category) async {
    return await newsApi.fetchCategoryNews(category);
  }

  Future<List<NewsArticle>> searchNews(String query) async {
    return await newsApi.searchNews(query);
  }
}
