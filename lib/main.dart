import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_today/blocs/nav/navigation_bloc.dart';
import 'package:news_today/blocs/news/news_bloc.dart';
import 'package:news_today/repositories/news_repository.dart';
import 'package:news_today/screens/categories_screen.dart';
import 'package:news_today/screens/main_screen.dart';
import 'package:news_today/screens/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final NewsRepository newsRepository = NewsRepository();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NewsBloc>(
          create: (context) => NewsBloc(newsRepository: newsRepository)
            ..add(FetchTopHeadlines()),
        ),
        BlocProvider<NavigationBloc>(
          create: (context) => NavigationBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'News App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SplashScreen(),
        routes: {
          '/main': (context) => MainScreen(),
          '/categories': (context) => CategoriesScreen(),
        },
      ),
    );
  }
}
