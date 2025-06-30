import 'package:equatable/equatable.dart';

import 'source_entity.dart';

class ArticleEntity extends Equatable {
  final SourceEntity source;
  final String? author;
  final String title;
  final String? description;
  final String url;
  final String? urlToImage;
  final DateTime publishedAt;

  const ArticleEntity({
    required this.source,
    this.author,
    required this.title,
    this.description,
    required this.url,
    this.urlToImage,
    required this.publishedAt,
  });

  @override
  List<Object?> get props => [
    source,
    author,
    title,
    description,
    url,
    urlToImage,
    publishedAt,
  ];
}
