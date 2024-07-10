import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:news_today/models/news_models.dart';
import 'package:news_today/repositories/news_repository.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsRepository newsRepository;

  NewsBloc({required this.newsRepository}) : super(NewsInitial()) {
    on<FetchTopHeadlines>(_fetchTopHeadlines);
    on<SearchNews>(_searchNews);
    on<FetchCategoryNews>(_fetchCategoryNews);
    on<ResetNews>(_resetNews);
  }

  Future<void> _fetchTopHeadlines(
      FetchTopHeadlines event, Emitter<NewsState> emit) async {
    try {
      emit(NewsLoading());
      final news = await newsRepository.fetchTopHeadlines();
      emit(NewsLoaded(news, selectedCategory: ''));
    } catch (e) {
      emit(NewsError("Failed to fetch news: $e"));
    }
  }

  Future<void> _fetchCategoryNews(
      FetchCategoryNews event, Emitter<NewsState> emit) async {
    try {
      emit(NewsLoading());
      final news = await newsRepository.fetchCategoryNews(event.category);
      emit(NewsLoaded(news, selectedCategory: event.category));
    } catch (e) {
      emit(NewsError("Failed to fetch category news: $e"));
    }
  }

  Future<void> _searchNews(SearchNews event, Emitter<NewsState> emit) async {
    try {
      emit(NewsLoading());
      final news = await newsRepository.searchNews(event.query);
      emit(NewsLoaded(news, selectedCategory: ''));
    } catch (e) {
      emit(NewsError("Failed to search news: $e"));
    }
  }

  void _resetNews(ResetNews event, Emitter<NewsState> emit) {
    emit(NewsInitial());
    add(FetchTopHeadlines());
  }
}
