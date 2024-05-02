import 'package:flutter/material.dart';
import 'package:proplay/models/schedule.model.dart';

class ScheduleForm {
  String? name;
  String? address;
  double? amount;
  int? day;
  TimeOfDay? time;
  int? group;
  int? numberOfPlayers;
  int? openDay;
  TimeOfDay? openTime;

  Schedule save() {
    return Schedule(
      id: 0,
      name: name!,
      address: address!,
      day: day!,
      time: time!,
      amount: amount,
      progroup: group!,
      numberOfPlayers: numberOfPlayers!,
      openTime: openTime!,
      openDay: openDay!,
    );
  }
}
