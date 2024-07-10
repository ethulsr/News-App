// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_declarations

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:news_today/models/news_models.dart';
import 'package:news_today/screens/news_details_screen.dart';

class NewsCarousel extends StatelessWidget {
  final List<NewsArticle> articles;
  final String title;

  NewsCarousel({super.key, required this.articles, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        SizedBox(height: 10),
        CarouselSlider(
          options: CarouselOptions(
            height: 400.0,
            enlargeCenterPage: true,
            enableInfiniteScroll: false,
            autoPlay: true,
          ),
          items: articles.map((article) {
            return Builder(
              builder: (BuildContext context) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            NewsDetailScreen(article: article),
                      ),
                    );
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 6,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildImage(article),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            article.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            article.description,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            article.publishedAt.split('T')[0],
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.brown,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildImage(NewsArticle article) {
    final String imageUrl = article.imageUrl.isNotEmpty ? article.imageUrl : '';
    final String placeholderAsset = 'assets/Placeholder.png';

    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(15),
        topRight: Radius.circular(15),
      ),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: double.infinity,
        height: 170,
        fit: BoxFit.cover,
        placeholder: (context, url) => Image.asset(
          placeholderAsset,
          width: double.infinity,
          height: 200,
          fit: BoxFit.cover,
        ),
        errorWidget: (context, url, error) => Image.asset(
          placeholderAsset,
          width: double.infinity,
          height: 200,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
