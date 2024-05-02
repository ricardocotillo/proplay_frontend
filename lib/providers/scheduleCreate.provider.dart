import 'package:flutter/material.dart';
import 'package:proplay/forms/schedule.form.dart';
import 'package:proplay/models/schedule.model.dart';
import 'package:proplay/services/schedule.service.dart';

class ScheduleCreateProvider with ChangeNotifier {
  ScheduleCreateProvider({required int groupId}) {
    form.group = groupId;
  }
  final form = ScheduleForm();
  final service = ScheduleService();
  final timeController = TextEditingController();
  final openTimeController = TextEditingController();

  set name(String? v) => form.name = v;
  set amount(String? v) => form.amount = double.tryParse(v ?? '');
  set address(String? v) => form.address = v;
  set openDay(int? v) => form.openDay = v;
  set openTime(TimeOfDay? v) {
    if (v != null) {
      form.openTime = v;
      openTimeController.text =
          '${form.openTime?.hour.toString().padLeft(2, '0')}:${form.openTime?.minute.toString().padLeft(2, '0')}';
      notifyListeners();
    }
  }

  set time(TimeOfDay? v) {
    if (v != null) {
      form.time = v;
      timeController.text =
          '${form.time?.hour.toString().padLeft(2, '0')}:${form.time?.minute.toString().padLeft(2, '0')}';
      notifyListeners();
    }
  }

  set day(int? v) {
    form.day = v;
    notifyListeners();
  }

  set numberOfPlayers(String? v) =>
      form.numberOfPlayers = int.tryParse(v ?? '');

  int? get day => form.day;
  TimeOfDay? get time => form.time;
  int? get openDay => form.openDay;
  TimeOfDay? get openTime => form.openTime;

  Future<Schedule> create() {
    final s = form.save();
    return service.create(s);
  }
}
