import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_today/blocs/nav/navigation_bloc.dart';
import 'package:news_today/blocs/news/news_bloc.dart';
import 'package:news_today/models/news_models.dart';
import 'package:news_today/screens/categories_screen.dart';
import 'package:news_today/screens/news_search.dart';
import 'package:news_today/utils/apptheme.dart';
import 'package:news_today/utils/text.dart';
import 'package:news_today/widgets/bottom_nav_bar.dart';
import 'package:news_today/widgets/carousel_slider.dart';
import 'package:news_today/widgets/news_list_items.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: apptheme.scaffoldColor,
      appBar: AppBar(
        backgroundColor: apptheme.secondaryColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/NewsLogo5.png",
              width: 100,
            ),
            SizedBox(
              width: 10,
            ),
            ModifiedTexts(text: 'Today', color: Colors.yellow, size: 35),
          ],
        ),
      ),
      body: BlocBuilder<NavigationBloc, NavigationState>(
        builder: (context, state) {
          if (state is NavigationInitial) {
            return _buildScreen(0, context);
          } else if (state is NavigationSelected) {
            return _buildScreen(state.selectedIndex, context);
          } else {
            return Container();
          }
        },
      ),
      bottomNavigationBar: BlocBuilder<NavigationBloc, NavigationState>(
        builder: (context, state) {
          int currentIndex = 0;
          if (state is NavigationSelected) {
            currentIndex = state.selectedIndex;
          }
          return BottomNavBar(
            currentIndex: currentIndex,
            onTap: (index) {
              if (index == 2) {
                showSearch(context: context, delegate: NewsSearchDelegate())
                    .then((_) {
                  BlocProvider.of<NewsBloc>(context).add(ResetNews());
                  BlocProvider.of<NewsBloc>(context).add(FetchTopHeadlines());
                });
              } else {
                BlocProvider.of<NavigationBloc>(context).add(SelectTab(index));
                if (index == 0) {
                  BlocProvider.of<NewsBloc>(context).add(ResetNews());
                  BlocProvider.of<NewsBloc>(context).add(FetchTopHeadlines());
                }
              }
            },
          );
        },
      ),
    );
  }

  Widget _buildScreen(int index, BuildContext context) {
    switch (index) {
      case 0:
        return BlocBuilder<NewsBloc, NewsState>(
          builder: (context, state) {
            if (state is NewsInitial || state is NewsLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is NewsLoaded) {
              return buildNewsListView(context, state.news);
            } else if (state is NewsError) {
              return Center(child: Text(state.message));
            } else {
              return Container();
            }
          },
        );
      case 1:
        return CategoriesScreen();
      default:
        return Container();
    }
  }

  Widget buildNewsListView(BuildContext context, List<NewsArticle> news) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
              ),
              NewsCarousel(
                articles: news,
                title: '',
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: ModifiedTexts(
                  text: 'Recent News',
                  color: Colors.yellow,
                  size: 24,
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return NewsListItem(article: news[index]);
            },
            childCount: news.length,
          ),
        ),
      ],
    );
  }
}
