import 'package:go_router/go_router.dart';
import 'package:proplay/controllers/group.controller.dart';
import 'package:proplay/forms/login.form.dart';
import 'package:proplay/providers/auth.provider.dart';
import 'package:proplay/providers/scheduleCreate.provider.dart';
import 'package:proplay/views/group.view.dart';
import 'package:proplay/views/groupCreate.view.dart';
import 'package:proplay/views/home.view.dart';
import 'package:proplay/views/login.view.dart';
import 'package:proplay/views/schedule.view.dart';
import 'package:proplay/views/scheduleCreate.view.dart';
import 'package:proplay/views/userEdit.view.dart';
import 'package:provider/provider.dart';

GoRouter getRouter(AuthProvider authProvider) {
  return GoRouter(
    routes: [
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) {
          final authProvider =
              Provider.of<AuthProvider>(context, listen: false);
          return HomeView(id: authProvider.me?.id ?? 0);
        },
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => Provider(
          create: (_) => LoginForm(),
          child: LoginView(),
        ),
      ),
      GoRoute(
        path: '/groups/create',
        name: 'group-create',
        builder: (context, state) => GroupCreateView(),
      ),
      GoRoute(
        path: '/groups/:id',
        name: 'group',
        builder: (context, state) => ChangeNotifierProvider(
          create: (_) => GroupController(),
          child: GroupView(
            id: int.parse(state.pathParameters['id'] ?? '0'),
          ),
        ),
      ),
      GoRoute(
        path: '/schedules/add',
        name: 'schedule-add',
        builder: (context, state) {
          return ChangeNotifierProvider(
            create: (_) => ScheduleCreateProvider(
                groupId: int.parse(state.uri.queryParameters['group'] ?? '0')),
            child: ScheduleCreateView(),
          );
        },
      ),
      GoRoute(
        path: '/schedules/:id',
        name: 'schedule',
        builder: (context, state) => ScheduleView(
          id: int.parse(state.pathParameters['id'] ?? '0'),
        ),
      ),
      GoRoute(
        path: '/edit',
        name: 'user-edit',
        builder: (context, state) => const UserEditView(),
      )
    ],
    redirect: (context, state) {
      final loggedIn = Provider.of<AuthProvider>(
        context,
        listen: false,
      ).loggedIn;
      final loggingIn = state.fullPath == '/login';
      if (!loggedIn) return loggingIn ? null : state.namedLocation('login');
      if (loggingIn) return state.namedLocation('home');
      return null;
    },
  );
}
