import 'package:go_router/go_router.dart';
import 'package:users_dvp_app/core/constants/app_message.dart';
import 'package:users_dvp_app/presentation/router/route_names.dart';
import 'package:users_dvp_app/presentation/screens/add_user_screen.dart';
import 'package:users_dvp_app/presentation/screens/detail_user_screen.dart';
import 'package:users_dvp_app/presentation/screens/list_user_screen.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(path: RouteNames.listUser, builder: (context, state) => const ListUserScreen()),
    GoRoute(path: RouteNames.addUser, builder: (context, state) => AddUserScreen()),
    GoRoute(
      path: RouteNames.detailUser,
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>;
        final parameter = extra[AppMessage.parameterId] ?? 0;
        return DetailUserScreen(id: parameter);
      },
    ),
  ],
  initialLocation: '/',
);
