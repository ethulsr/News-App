// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:news_today/models/news_models.dart';
import 'package:news_today/widgets/news_list_items.dart';

class NewsList extends StatelessWidget {
  final List<NewsArticle> news;

  NewsList({required this.news});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: news.length,
      itemBuilder: (context, index) {
        return NewsListItem(article: news[index]);
      },
    );
  }
}
