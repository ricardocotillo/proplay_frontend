// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Schedule _$ScheduleFromJson(Map<String, dynamic> json) => Schedule(
      id: json['id'] as int,
      name: json['name'] as String,
      address: json['address'] as String,
      amount: stringToDouble(json['amount'] as String?),
      day: json['day'] as int,
      time: timeFromJson(json['time'] as String),
      progroup: json['progroup'] as int,
      numberOfPlayers: json['number_of_players'] as int,
      openDay: json['open_day'] as int,
      openTime: timeFromJson(json['open_time'] as String),
    );

Map<String, dynamic> _$ScheduleToJson(Schedule instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'address': instance.address,
      'amount': doubleToString(instance.amount),
      'day': instance.day,
      'time': timeToJson(instance.time),
      'progroup': instance.progroup,
      'number_of_players': instance.numberOfPlayers,
      'open_day': instance.openDay,
      'open_time': timeToJson(instance.openTime),
    };
