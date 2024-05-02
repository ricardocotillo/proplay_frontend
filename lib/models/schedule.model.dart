import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:proplay/utils/functions.dart';
part 'schedule.model.g.dart';

@JsonSerializable()
class Schedule {
  final int id;
  final String name;
  final String address;
  @JsonKey(fromJson: stringToDouble, toJson: doubleToString)
  final double? amount;
  final int day;
  @JsonKey(fromJson: timeFromJson, toJson: timeToJson)
  final TimeOfDay time;
  final int progroup;
  @JsonKey(name: 'number_of_players')
  final int numberOfPlayers;
  @JsonKey(name: 'open_day')
  final int openDay;
  @JsonKey(name: 'open_time', fromJson: timeFromJson, toJson: timeToJson)
  final TimeOfDay openTime;

  String get timeString =>
      '${time.hour.toString().padLeft(2, "0")}:${time.minute.toString().padLeft(2, "0")}';
  int get daysToNextSession => day - DateTime.now().weekday;
  DateTime get nextDate {
    final n = DateTime.now();
    final d = n.add(Duration(days: daysToNextSession));
    return DateTime(d.year, d.month, d.day, time.hour, time.minute);
  }

  String get dayString {
    switch (day) {
      case 1:
        return 'Lunes';
      case 2:
        return 'Martes';
      case 3:
        return 'Miércoles';
      case 4:
        return 'Jueves';
      case 5:
        return 'Vernes';
      case 6:
        return 'Sábado';
      default:
        return 'Domingo';
    }
  }

  Schedule({
    required this.id,
    required this.name,
    required this.address,
    this.amount,
    required this.day,
    required this.time,
    required this.progroup,
    required this.numberOfPlayers,
    required this.openDay,
    required this.openTime,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) =>
      _$ScheduleFromJson(json);
  Map<String, dynamic> toJson() => _$ScheduleToJson(this);
}

TimeOfDay timeFromJson(String v) {
  final t = v.split(':');
  return TimeOfDay(
    hour: int.parse(t[0]),
    minute: int.parse(t[1]),
  );
}

String timeToJson(TimeOfDay v) {
  return '${v.hour.toString().padLeft(2, "0")}:${v.minute.toString().padLeft(2, "0")}';
}
