import 'dart:async';
import 'package:crypto_observer/app_constants.dart';
import 'package:crypto_observer/feature/home/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:crypto_observer/app_colors.dart';
import 'package:go_router/go_router.dart';
import 'package:crypto_observer/feature/splash/cubit/splash_cubit.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late final Timer animationTimer;
  bool _isTimerExpired = false;
  bool _isSplashSuccess = false;

  @override
  void initState() {
    super.initState();
    animationTimer =
        Timer(const Duration(milliseconds: splashScreenMinDuration), () {
      _isTimerExpired = true;
      _navigateIfReady();
    });
  }

  void _navigateIfReady() {
    if (_isTimerExpired && _isSplashSuccess) {
      context.go('/HomeScreen');
    }
  }

  @override
  void dispose() {
    animationTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocListener<SplashCubit, SplashState>(
      listener: (context, state) {
        if (state.status == SplashStatus.success) {
          _isSplashSuccess = true;
          context.read<HomeCubit>().addCoins(state.coins);
          _navigateIfReady();
        }
      },
      child: SizedBox.expand(
        child: Container(
          color: backgroundPrimary,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Loading coins data...',
                style: theme.textTheme.bodyMedium,
              ),
              Lottie.asset(
                'assets/animations/loading_animation.json',
                repeat: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
