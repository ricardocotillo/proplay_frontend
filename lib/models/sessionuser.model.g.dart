// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sessionuser.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SessionUser _$SessionUserFromJson(Map<String, dynamic> json) => SessionUser(
      id: json['id'] as int,
      session: json['session'] as int,
      userId: json['user_id'] as int,
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      order: json['order'] as int,
      paid: json['paid'] as bool? ?? false,
      assisted: json['assisted'] as bool? ?? false,
      late: json['late'] as bool? ?? false,
    );

Map<String, dynamic> _$SessionUserToJson(SessionUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'session': instance.session,
      'user_id': instance.userId,
      'order': instance.order,
    };
