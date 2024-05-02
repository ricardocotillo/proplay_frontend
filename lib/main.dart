import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:proplay/models/token.model.dart';
import 'package:proplay/models/user.model.dart';
import 'package:proplay/providers/auth.provider.dart';
import 'package:proplay/router.dart';
import 'package:proplay/utils/functions.dart';
import 'package:provider/provider.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  await Hive.openBox<User>('me');
  final token = await verifyUser();
  runApp(App(
    token: token,
  ));
}

class App extends StatelessWidget {
  App({
    super.key,
    this.token,
  }) : authProvider = AuthProvider(token: token, loggedIn: token != null);

  final Token? token;
  final AuthProvider authProvider;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final router = getRouter(authProvider);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => authProvider,
        ),
      ],
      child: MaterialApp.router(
        title: 'ProPlay',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routerConfig: router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
