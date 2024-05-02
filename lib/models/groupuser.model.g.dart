// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'groupuser.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupUser _$GroupUserFromJson(Map<String, dynamic> json) => GroupUser(
      id: json['id'] as int? ?? 0,
      group: json['group'] as int,
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      role: _roleFromJson(json['role'] as String),
      userId: json['user_id'] as int,
    );

Map<String, dynamic> _$GroupUserToJson(GroupUser instance) => <String, dynamic>{
      'id': instance.id,
      'group': instance.group,
      'user_id': instance.userId,
      'role': _roleToJson(instance.role),
    };
