import 'package:json_annotation/json_annotation.dart';
import 'package:proplay/models/user.model.dart';
part 'groupuser.model.g.dart';

@JsonSerializable()
class GroupUser {
  final int id;
  final int group;
  @JsonKey(includeToJson: false)
  final User user;
  @JsonKey(name: 'user_id')
  final int userId;
  @JsonKey(fromJson: _roleFromJson, toJson: _roleToJson)
  final GroupUserRole role;

  GroupUser({
    this.id = 0,
    required this.group,
    required this.user,
    required this.role,
    required this.userId,
  });

  factory GroupUser.fromJson(Map<String, dynamic> json) =>
      _$GroupUserFromJson(json);
  Map<String, dynamic> toJson() => _$GroupUserToJson(this);
}

enum GroupUserRole {
  owner,
  admin,
  member,
}

GroupUserRole _roleFromJson(String role) {
  switch (role) {
    case 'owner':
      return GroupUserRole.owner;
    case 'admin':
      return GroupUserRole.admin;
    default:
      return GroupUserRole.member;
  }
}

String _roleToJson(GroupUserRole role) {
  switch (role) {
    case GroupUserRole.owner:
      return 'owner';
    case GroupUserRole.admin:
      return 'admin';
    default:
      return 'member';
  }
}
