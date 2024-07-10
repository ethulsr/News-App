// ignore_for_file: prefer_const_constructors_in_immutables, avoid_print

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_today/models/news_models.dart';
import 'package:news_today/utils/apptheme.dart';

class NewsDetailScreen extends StatelessWidget {
  final NewsArticle article;

  NewsDetailScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: apptheme.scaffoldColor,
      appBar: AppBar(
        backgroundColor: apptheme.secondaryColor,
        iconTheme: IconThemeData(color: Colors.grey),
        title: Text(
          article.title,
          style: TextStyle(color: Colors.grey[400]),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImageWidget(),
            SizedBox(height: 28),
            Text(
              article.title,
              style: GoogleFonts.acme(
                  textStyle: TextStyle(fontSize: 28, color: Colors.yellow)),
            ),
            SizedBox(height: 36),
            Text(article.description,
                style: GoogleFonts.abel(
                    textStyle: TextStyle(fontSize: 20, color: Colors.white))),
            SizedBox(height: 44),
            Text('Published at: ${article.publishedAt}',
                style:
                    GoogleFonts.acme(textStyle: TextStyle(color: Colors.grey))),
          ],
        ),
      ),
    );
  }

  Widget _buildImageWidget() {
    if (article.imageUrl.isNotEmpty && article.imageUrl.startsWith('http')) {
      return Image.network(
        article.imageUrl,
        errorBuilder: (context, error, stackTrace) {
          print('Failed to load image: $error');
          return _buildPlaceholderImageFromAsset();
        },
        width: double.infinity,
        height: 200,
        fit: BoxFit.cover,
      );
    } else {
      return _buildPlaceholderImageFromAsset();
    }
  }

  Widget _buildPlaceholderImageFromAsset() {
    return Container(
      width: double.infinity,
      height: 200,
      color: Colors.white,
      child: Image.asset(
        'assets/Placeholder.png',
        width: double.infinity,
        height: 200,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          print('Failed to load placeholder image: $error');
          return Icon(Icons.error_outline, size: 64, color: Colors.red);
        },
      ),
    );
  }
}
