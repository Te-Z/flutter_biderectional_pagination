import 'package:flutter_biderectional_pagination/data/entities/info_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'character_entity.g.dart';

@JsonSerializable()
class Character {
  final String name;

  Character({required this.name});

  factory Character.fromJson(Map<String, dynamic> json) =>
      _$CharacterFromJson(json);

  Map<String, dynamic> toJson() => _$CharacterToJson(this);
}

@JsonSerializable()
class CharacterPagination {
  final Info info;
  final List<Character> results;

  CharacterPagination({
    required this.info,
    required this.results,
  });

  factory CharacterPagination.fromJson(Map<String, dynamic> json) =>
      _$CharacterPaginationFromJson(json);
}
