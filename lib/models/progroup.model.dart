import 'package:json_annotation/json_annotation.dart';
part 'progroup.model.g.dart';

@JsonSerializable()
class ProGroup {
  final int id;
  final String name;
  final String? image;
  final String code;
  @JsonKey(name: 'users_count', includeToJson: false)
  final int usersCount;
  @JsonKey(includeToJson: false)
  final String created;
  @JsonKey(includeToJson: false)
  final String modified;

  ProGroup({
    this.id = 0,
    required this.name,
    this.image,
    this.code = '',
    this.usersCount = 0,
    this.created = '',
    this.modified = '',
  });

  factory ProGroup.fromJson(Map<String, dynamic> json) =>
      _$ProGroupFromJson(json);
  Map<String, dynamic> toJson() => _$ProGroupToJson(this);
}
