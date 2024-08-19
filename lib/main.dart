import 'dart:io';
import 'package:crypto_observer/app_theme.dart';
import 'package:crypto_observer/feature/details/cubit/details_cubit.dart';
import 'package:crypto_observer/feature/details/details_screen.dart';
import 'package:crypto_observer/feature/home/cubit/home_cubit.dart';
import 'package:crypto_observer/feature/home/home_screen.dart';
import 'package:crypto_observer/feature/splash/cubit/splash_cubit.dart';
import 'package:crypto_observer/feature/splash/splash_screen.dart';
import 'package:crypto_observer/managers/data_manager.dart';
import 'package:crypto_observer/utils/http_overrides.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [SystemUiOverlay.top],
  );
  HttpOverrides.global = HttpOverridesV2();
  await dotenv.load(fileName: 'lib/environment/keys.env');
  runApp(const MyApp());
}

final _router = GoRouter(
  initialLocation: '/SplashScreen',
  routes: [
    GoRoute(
      path: '/SplashScreen',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/HomeScreen',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/DetailsScreen',
      builder: (context, state) => const DetailsScreen(),
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SplashCubit>(
            create: (context) => SplashCubit(DataManager())..getCoinsList()),
        BlocProvider<HomeCubit>(create: (context) => HomeCubit(DataManager())),
        BlocProvider<DetailsCubit>(
            create: (context) => DetailsCubit(DataManager())),
      ],
      child: MaterialApp.router(
        theme: appTheme,
        routerConfig: _router,
      ),
    );
  }
}
