import 'package:dartz/dartz.dart';
import 'package:news_app/core/error/failure.dart';
import 'package:news_app/features/home/domain/entitiy/article_entity.dart';
import 'package:news_app/features/home/domain/repository/news_repository.dart';

class GetNewsUseCase {
  final NewsRepository repository;

  GetNewsUseCase(this.repository);

  Future<Either<Failure, List<ArticleEntity>>> call() {
    return repository.getNews();
  }
}
