class NewsArticle {
  final String title;
  final String description;
  final String url;
  final String imageUrl;
  final String publishedAt;
  final String content;
  final String category;

  NewsArticle({
    required this.title,
    required this.description,
    required this.url,
    required this.imageUrl,
    required this.publishedAt,
    required this.content,
    required this.category,
  });

  factory NewsArticle.fromJson(Map<String, dynamic> json, String category) {
    return NewsArticle(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      url: json['url'] ?? '',
      imageUrl: json['urlToImage'] ?? '',
      publishedAt: json['publishedAt'] ?? '',
      content: json['content'] ?? '',
      category: category, // Manually assign the category
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'url': url,
      'urlToImage': imageUrl,
      'publishedAt': publishedAt,
      'content': content,
      'category': category,
    };
  }
}
