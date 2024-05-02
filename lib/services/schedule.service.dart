import 'dart:convert';

import 'package:proplay/config.dart';
import 'package:proplay/models/schedule.model.dart';
import 'package:proplay/services/auth.service.dart';
import 'package:http/http.dart' as http;

class ScheduleService {
  final authService = AuthService();

  Future<Map<String, String>> authHeaders() async {
    final token = await authService.retrieve();
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${token?.access}'
    };
    return headers;
  }

  Future<Schedule> retrieve(int id) async {
    final url = Uri.parse('$apiUrl/schedules/$id/');
    final res = await http.get(url);
    final j = jsonDecode(res.body);
    return Schedule.fromJson(j);
  }

  Future<List<Schedule>> list(Map<String, dynamic>? filters) async {
    final url =
        Uri.parse('$apiUrl/schedules/').replace(queryParameters: filters);
    final res = await http.get(
      url,
      headers: await authHeaders(),
    );
    final l = jsonDecode(res.body);
    return (l as List).map((j) => Schedule.fromJson(j)).toList();
  }

  Future<Schedule> create(Schedule schedule) async {
    final url = Uri.parse('$apiUrl/schedules/');
    final res = await http.post(url,
        headers: await authHeaders(), body: jsonEncode(schedule));
    final j = jsonDecode(res.body);
    return Schedule.fromJson(j);
  }
}
