import 'package:json_annotation/json_annotation.dart';

part 'info_entity.g.dart';

@JsonSerializable()
class Info {
  final int? pages;
  
  Info({
    this.pages,
  });

  factory Info.fromJson(Map<String, dynamic> json) => _$InfoFromJson(json);
}
