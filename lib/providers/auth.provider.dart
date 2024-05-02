import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:proplay/forms/login.form.dart';
import 'package:proplay/models/token.model.dart';
import 'package:proplay/models/user.model.dart';
import 'package:proplay/services/auth.service.dart';

class AuthProvider extends ChangeNotifier {
  Token? token;
  User? me;

  bool loggedIn;

  AuthProvider({
    this.token,
    this.loggedIn = false,
  }) {
    if (loggedIn) {
      setMe();
      notifyListeners();
    }
  }

  Future<bool> login(LoginForm login) async {
    final authService = AuthService();
    final t = await authService.create(login);
    token = t;
    loggedIn = token != null;
    if (t == null) return false;
    authService.store(t);
    await setMe();
    notifyListeners();
    return true;
  }

  User? localMe() {
    final box = Hive.box<User>('me');
    final user = box.isNotEmpty ? box.getAt(0) : null;
    return user;
  }

  Future<User?> repositoryMe() async {
    final authService = AuthService();
    final user = authService.me();
    return user;
  }

  Future<User?> getMe() async {
    var user = localMe();
    user ??= await repositoryMe();
    return user;
  }

  setMe() async {
    final user = await getMe();
    if (user != null) storeMe(user);
    me = user;
  }

  updateMe(User user) async {
    me = user;
    notifyListeners();
  }

  storeMe(User user) async {
    final box = Hive.box<User>('me');
    box.isEmpty ? await box.add(user) : await box.putAt(0, user);
  }
}
