import 'package:crypto_observer/app_constants.dart';
import 'package:crypto_observer/feature/home/cubit/home_cubit.dart';
import 'package:crypto_observer/feature/home/widgets/coin_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Top Currencies List'),
      ),
      body: RefreshIndicator(
        onRefresh: () async => context.read<HomeCubit>().updateCoinsList(),
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state.coins.isNotEmpty) {
              return ListView.separated(
                cacheExtent: cacheExtent,
                padding: const EdgeInsets.all(16),
                itemCount: state.coins.length,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, i) {
                  final coin = state.coins[i];
                  return CoinTile(coin: coin);
                },
              );
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Something went wrong',
                      style: theme.textTheme.headlineMedium,
                    ),
                    Text(
                      'Please try again later',
                      style: theme.textTheme.labelSmall?.copyWith(fontSize: 16),
                    ),
                    const SizedBox(height: 30),
                    TextButton(
                      onPressed: () =>
                          context.read<HomeCubit>().updateCoinsList(),
                      child: const Text('Try again'),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
