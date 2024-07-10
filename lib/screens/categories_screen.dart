import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_today/blocs/news/news_bloc.dart';
import 'package:news_today/models/news_models.dart';
import 'package:news_today/utils/apptheme.dart';
import 'package:news_today/utils/text.dart';
import '../widgets/news_list.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  String _selectedCategory = '';
  final List<Map<String, String>> categories = [
    {'name': 'Politics', 'slug': 'politics'},
    {'name': 'Sports', 'slug': 'sports'},
    {'name': 'Technology', 'slug': 'technology'},
    {'name': 'Science', 'slug': 'science'},
    {'name': 'Health', 'slug': 'health'},
    {'name': 'Busines', 'slug': 'Business'},
    {'name': 'World News', 'slug': 'world'},
    {'name': 'Entertainment', 'slug': 'entertainment'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: apptheme.scaffoldColor,
      appBar: AppBar(
        title: ModifiedTexts(
          text: 'Select a Category',
          color: Colors.yellow,
          size: 20,
        ),
        backgroundColor: apptheme.scaffoldColor,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          SizedBox(
            height: 100,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: List.generate(
                  categories.length,
                  (index) {
                    final category = categories[index];
                    return _buildCategoryCard(
                      category['name']!,
                      category['slug']!,
                    );
                  },
                ),
              ),
            ),
          ),
          SizedBox(height: 16),
          Expanded(
            child: BlocBuilder<NewsBloc, NewsState>(
              builder: (context, state) {
                if (state is NewsInitial) {
                  return Center(child: Text('Please select a category.'));
                } else if (state is NewsLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is NewsLoaded) {
                  final filteredNews =
                      _filterNewsByCategory(state.news, _selectedCategory);
                  if (filteredNews.isEmpty) {
                    return Center(
                      child: Text(
                        'No articles available for this category.',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  }
                  return NewsList(news: filteredNews);
                } else if (state is NewsError) {
                  return Center(child: Text(state.message));
                } else {
                  return Container();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(String name, String category) {
    return GestureDetector(
      onTap: () {
        _selectCategory(category);
        _fetchCategoryNews(category);
      },
      child: Container(
        width: 140,
        margin: EdgeInsets.symmetric(horizontal: 4),
        child: Card(
          color: _selectedCategory == category
              ? Colors.yellow
              : apptheme.terinaryColor,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Center(
              child: Text(
                name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: _selectedCategory == category
                      ? Colors.black
                      : Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _selectCategory(String category) {
    setState(() {
      _selectedCategory = category;
    });
  }

  void _fetchCategoryNews(String category) {
    BlocProvider.of<NewsBloc>(context).add(FetchCategoryNews(category));
  }

  List<NewsArticle> _filterNewsByCategory(
      List<NewsArticle> news, String category) {
    return news
        .where((article) =>
            article.category.toLowerCase() == category.toLowerCase())
        .toList();
  }
}
