import 'dart:convert';

import 'package:proplay/config.dart';
import 'package:http/http.dart' as http;
import 'package:proplay/models/progroup.model.dart';
import 'package:proplay/services/auth.service.dart';

class ProGroupService {
  final authService = AuthService();

  Future<Map<String, String>> authHeaders() async {
    final token = await authService.retrieve();
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${token?.access}'
    };
    return headers;
  }

  Future<List<ProGroup>> list({Map<String, dynamic>? filters}) async {
    final url =
        Uri.parse('$apiUrl/progroups/').replace(queryParameters: filters);
    final res = await http.get(
      url,
      headers: await authHeaders(),
    );
    final List list = jsonDecode(res.body);
    final groups = list.map((j) => ProGroup.fromJson(j)).toList();
    return groups;
  }

  Future<ProGroup> retrieve(int id, {Map<String, dynamic>? filters}) async {
    final url =
        Uri.parse('$apiUrl/progroups/$id/').replace(queryParameters: filters);
    final res = await http.get(
      url,
      headers: await authHeaders(),
    );
    final j = jsonDecode(res.body);
    final group = ProGroup.fromJson(j);
    return group;
  }

  Future<ProGroup> store(ProGroup group) async {
    final url = Uri.parse('$apiUrl/progroups/');
    final res = await http.post(
      url,
      headers: await authHeaders(),
      body: jsonEncode(group),
    );
    final j = jsonDecode(res.body);
    return ProGroup.fromJson(j);
  }
}
