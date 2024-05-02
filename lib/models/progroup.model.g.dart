// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'progroup.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProGroup _$ProGroupFromJson(Map<String, dynamic> json) => ProGroup(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String,
      image: json['image'] as String?,
      code: json['code'] as String? ?? '',
      usersCount: json['users_count'] as int? ?? 0,
      created: json['created'] as String? ?? '',
      modified: json['modified'] as String? ?? '',
    );

Map<String, dynamic> _$ProGroupToJson(ProGroup instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'code': instance.code,
    };
