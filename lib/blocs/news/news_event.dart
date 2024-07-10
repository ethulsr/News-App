part of 'news_bloc.dart';

abstract class NewsEvent extends Equatable {
  const NewsEvent();

  @override
  List<Object> get props => [];
}

class FetchTopHeadlines extends NewsEvent {}

class FetchCategoryNews extends NewsEvent {
  final String category;

  const FetchCategoryNews(this.category);

  @override
  List<Object> get props => [category];
}

class SearchNews extends NewsEvent {
  final String query;

  const SearchNews(this.query);

  @override
  List<Object> get props => [query];
}

class ResetNews extends NewsEvent {}
