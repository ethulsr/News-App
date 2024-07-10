// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_declarations, avoid_print

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:news_today/models/news_models.dart';
import 'package:news_today/screens/news_details_screen.dart';

class NewsListItem extends StatelessWidget {
  final NewsArticle article;

  NewsListItem({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NewsDetailScreen(article: article),
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImage(),
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
                  color: Colors.grey[600],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    article.publishedAt.split('T')[0],
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 14,
                    color: Colors.grey[600],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    final String imageUrl = article.imageUrl.isNotEmpty ? article.imageUrl : '';
    final String placeholderAsset = 'assets/Placeholder.png';

    print('Image URL: $imageUrl');

    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(15),
        topRight: Radius.circular(15),
      ),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: double.infinity,
        height: 200,
        fit: BoxFit.cover,
        placeholder: (context, url) => Image.asset(
          placeholderAsset,
          width: double.infinity,
          height: 200,
          fit: BoxFit.cover,
        ),
        errorWidget: (context, url, error) {
          print('Error loading image: $error');
          return Image.asset(
            placeholderAsset,
            width: double.infinity,
            height: 200,
            fit: BoxFit.cover,
          );
        },
      ),
    );
  }
}
