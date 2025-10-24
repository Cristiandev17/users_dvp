import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:users_dvp_app/core/mediatr/mediator.dart';
import 'package:users_dvp_app/presentation/cubits/add_user/add_user_cubit.dart';
import 'package:users_dvp_app/presentation/cubits/detail_user/detail_user_cubit.dart';
import 'package:users_dvp_app/presentation/cubits/list_user/list_user_cubit.dart';
import 'package:users_dvp_app/presentation/di/inyection.dart';
import 'package:users_dvp_app/presentation/router/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupInjection();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<ListUserCubit>()),
        BlocProvider(create: (_) => getIt<AddUserCubit>()),
        BlocProvider(create: (_) => getIt<DetailUserCubit>()),
      ],
      child: MaterialApp.router(
        routerConfig: appRouter,
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.system,
      ),
    );
  }
}
