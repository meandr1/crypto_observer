import 'package:cached_network_image/cached_network_image.dart';
import 'package:crypto_observer/app_constants.dart';
import 'package:crypto_observer/feature/details/cubit/details_cubit.dart';
import 'package:crypto_observer/feature/widgets/coin_chart.dart';
import 'package:crypto_observer/models/coin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CoinTile extends StatelessWidget {
  const CoinTile({super.key, required this.coin});

  final Coin coin;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      leading: CachedNetworkImage(
          imageUrl: coin.fullImageUrl,
          placeholder: (context, url) => const CircularProgressIndicator(),
          errorWidget: (context, url, error) =>
              Image.asset('assets/images/no_coin_img.png')),
      title: Text(
        coin.name,
        style: theme.textTheme.bodyMedium,
      ),
      subtitle: Text(
        '${num.parse(coin.price.toStringAsFixed(6))} \$',
        style: theme.textTheme.labelSmall,
      ),
      trailing:
          CoinChart(coin: coin, showTitle: false, interval: CoinHistory.weekly),
      onTap: () {
        context.read<DetailsCubit>().addCoin(coin);
        context.go('/DetailsScreen');
      },
    );
  }
}
