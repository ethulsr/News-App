import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_today/blocs/news/news_bloc.dart';

import 'package:news_today/utils/apptheme.dart';
import '../widgets/news_list.dart';

class NewsSearchDelegate extends SearchDelegate {
  @override
  String get searchFieldLabel => 'Search News';

  @override
  TextStyle? get searchFieldStyle =>
      TextStyle(color: Colors.white, fontSize: 20);

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      appBarTheme: AppBarTheme(
        backgroundColor: apptheme.secondaryColor,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(color: Colors.white38, fontSize: 20),
        filled: true,
        fillColor: apptheme.secondaryColor,
        border: InputBorder.none,
      ),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear, color: Colors.white),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back, color: Colors.white),
      onPressed: () {
        close(context, null);
        BlocProvider.of<NewsBloc>(context).add(ResetNews());
        BlocProvider.of<NewsBloc>(context).add(FetchTopHeadlines());
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    context.read<NewsBloc>().add(SearchNews(query));
    return Scaffold(
      backgroundColor: apptheme.scaffoldColor,
      body: BlocBuilder<NewsBloc, NewsState>(
        builder: (context, state) {
          if (state is NewsLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is NewsLoaded) {
            return NewsList(news: state.news);
          } else if (state is NewsError) {
            return Center(child: Text(state.message));
          } else {
            return Container();
          }
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Scaffold(
      backgroundColor: apptheme.scaffoldColor,
      body: Center(
        child: Text(
          'Search for news articles',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
