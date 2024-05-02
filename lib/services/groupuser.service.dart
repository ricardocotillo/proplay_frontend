import 'dart:convert';

import 'package:proplay/config.dart';
import 'package:proplay/models/groupuser.model.dart';
import 'package:proplay/services/auth.service.dart';
import 'package:http/http.dart' as http;

class GroupUserService {
  final authService = AuthService();

  Future<Map<String, String>> authHeaders() async {
    final token = await authService.retrieve();
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${token?.access}'
    };
    return headers;
  }

  Future<List<GroupUser>> list(Map<String, dynamic>? filters) async {
    final url =
        Uri.parse('$apiUrl/progroup-users/').replace(queryParameters: filters);
    final res = await http.get(
      url,
      headers: await authHeaders(),
    );
    final List list = jsonDecode(res.body);
    final groupUsers = list.map((j) => GroupUser.fromJson(j)).toList();
    return groupUsers;
  }

  Future<GroupUser> store(GroupUser groupUser) async {
    final url = Uri.parse('$apiUrl/progroup-users/');
    final res = await http.post(
      url,
      headers: await authHeaders(),
      body: jsonEncode(groupUser),
    );
    final j = jsonDecode(res.body);
    return GroupUser.fromJson(j);
  }
}
