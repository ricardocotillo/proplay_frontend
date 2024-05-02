import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user.model.g.dart';

@JsonSerializable()
@HiveType(typeId: 0)
class User {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String email;
  @JsonKey(name: 'first_name')
  @HiveField(2)
  final String firstName;
  @JsonKey(name: 'last_name')
  @HiveField(3)
  final String lastName;
  @HiveField(4)
  final String? image;

  User({
    this.id = 0,
    this.email = '',
    this.firstName = '',
    this.lastName = '',
    this.image,
  });

  String get fullName => '$firstName $lastName';

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
