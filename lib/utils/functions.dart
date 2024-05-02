import 'package:proplay/models/token.model.dart';
import 'package:proplay/services/auth.service.dart';

Future<Token?> verifyUser() async {
  final authService = AuthService();
  final token = await authService.retrieve();
  if (token == null) return null;
  final ok = await authService.verify(token);
  if (ok) return token;
  final newToken = await authService.refresh(token);
  if (newToken == null) return null;
  return newToken;
}

String? doubleToString(double? d) => d?.toStringAsFixed(2);
double? stringToDouble(String? d) => double.tryParse(d ?? '');
