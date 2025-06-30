import 'package:equatable/equatable.dart';
import 'package:news_app/features/home/data/models/source_model.dart';
import 'package:news_app/features/home/domain/entitiy/article_entity.dart';

class ArticleModel extends Equatable {
  final SourceModel source;
  final String? author;
  final String title;
  final String? description;
  final String url;
  final String? urlToImage;
  final String publishedAt;
  final String? content;

  const ArticleModel({
    required this.source,
    this.author,
    required this.title,
    this.description,
    required this.url,
    this.urlToImage,
    required this.publishedAt,
    this.content,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      source: SourceModel.fromJson(json['source']),
      author: json['author'],
      title: json['title'] ?? '',
      description: json['description'],
      url: json['url'],
      urlToImage: json['urlToImage'],
      publishedAt: json['publishedAt'],
      content: json['content'],
    );
  }

  ArticleEntity toEntity() {
    return ArticleEntity(
      source: source.toEntity(),
      author: author,
      title: title,
      description: description,
      url: url,
      urlToImage: urlToImage,
      publishedAt: DateTime.parse(publishedAt),
    );
  }

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
