import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:proplay/config.dart';
import 'package:proplay/forms/login.form.dart';
import 'package:proplay/models/token.model.dart';
import 'package:http/http.dart' as http;
import 'package:proplay/models/user.model.dart';

class AuthService {
  final storage = const FlutterSecureStorage();
  final headers = {
    'Content-Type': 'application/json',
  };

  Future<Map<String, String>> authHeaders() async {
    final h = headers;
    final token = await retrieve();
    h['Authorization'] = 'Bearer ${token?.access}';
    return h;
  }

  Future<bool> verify(Token token) async {
    final url = Uri.parse('$authUrl/jwt/verify/');
    final res = await http.post(
      url,
      headers: headers,
      body: jsonEncode({'token': token.access}),
    );
    return res.statusCode == 200;
  }

  Future<Token?> refresh(Token token) async {
    final url = Uri.parse('$authUrl/jwt/refresh/');
    final res = await http.post(
      url,
      headers: headers,
      body: jsonEncode({'refresh': token.refresh}),
    );
    if (res.statusCode == 401) return null;
    final j = jsonDecode(res.body);
    final newToken = Token(
      access: j['access'],
      refresh: token.refresh,
    );
    return newToken;
  }

  Future<Token?> create(LoginForm login) async {
    final url = Uri.parse('$authUrl/jwt/create/');
    final res = await http.post(
      url,
      headers: headers,
      body: jsonEncode(login),
    );
    if (res.statusCode == 401) return null;
    final j = jsonDecode(res.body);
    final token = Token.fromJson(j);
    return token;
  }

  Future<void> store(Token token) async {
    final s = jsonEncode(token);
    await storage.write(key: 'token', value: s);
  }

  Future<Token?> retrieve() async {
    final s = await storage.read(key: 'token');
    if (s == null) return null;
    final j = jsonDecode(s);
    final token = Token.fromJson(j);
    return token;
  }

  Future<User> me() async {
    final url = Uri.parse('$authUrl/users/me/');
    final res = await http.get(
      url,
      headers: await authHeaders(),
    );
    final j = jsonDecode(res.body);
    return User.fromJson(j);
  }

  Future<User> partialUpdate(Map<String, dynamic> fields) async {
    final url = Uri.parse('$authUrl/users/me/');
    final res = await http.patch(
      url,
      headers: await authHeaders(),
      body: jsonEncode(fields),
    );
    final j = jsonDecode(res.body);
    return User.fromJson(j);
  }
}
