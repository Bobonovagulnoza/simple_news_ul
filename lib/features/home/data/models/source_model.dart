import 'package:equatable/equatable.dart';
import 'package:news_app/features/home/domain/entitiy/source_entity.dart';

class SourceModel extends Equatable {
  final String? id;
  final String name;

  const SourceModel({this.id, required this.name});

  factory SourceModel.fromJson(Map<String, dynamic> json) {
    return SourceModel(id: json['id'], name: json['name'] ?? '');
  }

  SourceEntity toEntity() {
    return SourceEntity(id: id, name: name);
  }

  @override
  List<Object?> get props => [id, name];
}
