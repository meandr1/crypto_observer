import 'package:cached_network_image/cached_network_image.dart';
import 'package:crypto_observer/models/coin.dart';
import 'package:flutter/material.dart';

class CoinInfoWidget extends StatelessWidget {
  const CoinInfoWidget({super.key, required this.coin});
  final Coin coin;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 20, right: 10),
          width: 150,
          height: 150,
          child: CachedNetworkImage(
              imageUrl: coin.fullImageUrl,
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) =>
                  Image.asset('assets/images/no_coin_img.png')),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Name:", style: theme.textTheme.labelSmall),
            const SizedBox(height: 8),
            Text("Full name:", style: theme.textTheme.labelSmall),
            const SizedBox(height: 8),
            Text("Price:", style: theme.textTheme.labelSmall),
          ],
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(coin.name, style: theme.textTheme.bodyMedium),
                Text(
                  coin.fullName,
                  style: theme.textTheme.bodyMedium
                      ?.copyWith(overflow: TextOverflow.ellipsis),
                ),
                Text(
                  '${num.parse(coin.price.toStringAsFixed(6))} \$',
                  style: theme.textTheme.labelSmall?.copyWith(
                      color: Colors.white,
                      height: 2.2,
                      overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
