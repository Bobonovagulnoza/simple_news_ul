import 'package:dartz/dartz.dart';
import 'package:news_app/core/error/failure.dart';
import 'package:news_app/features/home/domain/entitiy/article_entity.dart';

abstract class NewsRepository {
  Future<Either<Failure, List<ArticleEntity>>> getNews();
}
