// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Session _$SessionFromJson(Map<String, dynamic> json) => Session(
      id: json['id'] as int,
      schedule: json['schedule'] as int,
      amount: stringToDouble(json['amount'] as String?),
      address: json['address'] as String,
      date: DateTime.parse(json['date'] as String),
    );

Map<String, dynamic> _$SessionToJson(Session instance) => <String, dynamic>{
      'id': instance.id,
      'schedule': instance.schedule,
      'amount': doubleToString(instance.amount),
      'address': instance.address,
      'date': instance.date.toIso8601String(),
    };
