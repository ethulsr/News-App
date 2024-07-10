// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_today/models/news_models.dart';

class NewsApi {
  final String apiKey = '070f3141535e461d9195a669b892e8dd';
  final String baseUrl = 'https://newsapi.org/v2';

  Future<List<NewsArticle>> fetchTopHeadlines() async {
    try {
      final response = await http
          .get(Uri.parse('$baseUrl/top-headlines?country=us&apiKey=$apiKey'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return (data['articles'] as List)
            .map((article) => NewsArticle.fromJson(article, ''))
            .toList();
      } else {
        throw Exception('Failed to load top headlines: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception during fetchTopHeadlines: $e');
      throw Exception('Failed to load top headlines');
    }
  }

  Future<List<NewsArticle>> searchNews(String query) async {
    try {
      final response = await http
          .get(Uri.parse('$baseUrl/everything?q=$query&apiKey=$apiKey'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return (data['articles'] as List)
            .map((article) => NewsArticle.fromJson(article, query))
            .toList();
      } else {
        throw Exception('Failed to search news: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception during searchNews: $e');
      throw Exception('Failed to search news');
    }
  }

  Future<List<NewsArticle>> fetchCategoryNews(String category) async {
    try {
      final response = await http.get(Uri.parse(
          '$baseUrl/top-headlines?category=$category&apiKey=$apiKey'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return (data['articles'] as List)
            .map((article) => NewsArticle.fromJson(article, category))
            .toList();
      } else {
        throw Exception('Failed to load category news: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception during fetchCategoryNews: $e');
      throw Exception('Failed to load category news');
    }
  }
}
