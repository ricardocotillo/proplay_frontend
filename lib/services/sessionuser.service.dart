import 'dart:convert';

import 'package:proplay/config.dart';
import 'package:proplay/models/sessionuser.model.dart';
import 'package:proplay/services/auth.service.dart';
import 'package:http/http.dart' as http;

class SessionUserService {
  final authService = AuthService();

  Future<Map<String, String>> authHeaders() async {
    final token = await authService.retrieve();
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${token?.access}'
    };
    return headers;
  }

  Future<List<SessionUser>> list(Map<String, dynamic>? filters) async {
    final url =
        Uri.parse('$apiUrl/session-users/').replace(queryParameters: filters);
    final res = await http.get(
      url,
      headers: await authHeaders(),
    );
    final List list = jsonDecode(res.body);
    return list.map((j) => SessionUser.fromJson(j)).toList();
  }

  Future<SessionUser> create(SessionUser sessionUser) async {
    final url = Uri.parse('$apiUrl/session-users/');
    final res = await http.post(
      url,
      body: jsonEncode(sessionUser),
      headers: await authHeaders(),
    );
    final j = jsonDecode(res.body);
    return SessionUser.fromJson(j);
  }
}
