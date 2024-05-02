import 'dart:convert';

import 'package:proplay/config.dart';
import 'package:proplay/models/session.model.dart';
import 'package:proplay/services/auth.service.dart';
import 'package:http/http.dart' as http;

class SessionService {
  final authService = AuthService();

  Future<Map<String, String>> authHeaders() async {
    final token = await authService.retrieve();
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${token?.access}'
    };
    return headers;
  }

  Future<List<Session>> list(Map<String, dynamic>? filters) async {
    final url =
        Uri.parse('$apiUrl/sessions/').replace(queryParameters: filters);
    final res = await http.get(
      url,
      headers: await authHeaders(),
    );
    final List list = jsonDecode(res.body);
    return list.map((j) => Session.fromJson(j)).toList();
  }

  Future<Session> retrieve(int id) async {
    final url = Uri.parse('$apiUrl/sessions/$id/');
    final res = await http.get(
      url,
      headers: await authHeaders(),
    );
    final j = jsonDecode(res.body);
    return Session.fromJson(j);
  }

  Future<Session> create(Session session) async {
    final url = Uri.parse('$apiUrl/sessions/');
    final res = await http.post(
      url,
      body: jsonEncode(session),
      headers: await authHeaders(),
    );
    final j = jsonDecode(res.body);
    return Session.fromJson(j);
  }
}
