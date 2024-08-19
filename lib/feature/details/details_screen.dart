import 'package:crypto_observer/app_constants.dart';
import 'package:crypto_observer/feature/details/cubit/details_cubit.dart';
import 'package:crypto_observer/feature/details/widgets/coin_info_widget.dart';
import 'package:crypto_observer/feature/home/cubit/home_cubit.dart';
import 'package:crypto_observer/feature/widgets/coin_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DetailsCubit, DetailsState>(
      listener: (context, state) {
        if (state.status == DetailsStatus.success) {
          context.read<HomeCubit>().updateCoin(state.coin!);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () => context.go('/HomeScreen'),
            ),
            centerTitle: true,
            title: Text('${state.coin?.fullName} charts'),
          ),
          body: DefaultTabController(
            initialIndex: 1,
            length: 3,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CoinInfoWidget(coin: state.coin!),
                Padding(
                  padding: const EdgeInsets.only(
                      bottom: 20, left: 10, right: 10, top: 10),
                  child: TabBar(
                    dividerColor: Colors.transparent,
                    indicatorPadding:
                        const EdgeInsets.symmetric(horizontal: -15),
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.white,
                    tabs: const [
                      Tab(text: 'Hourly', height: 30),
                      Tab(text: 'Weekly', height: 30),
                      Tab(text: 'Monthly', height: 30)
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      state.status == DetailsStatus.loading
                          ? const Center(child: CircularProgressIndicator())
                          : Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, bottom: 30, top: 60),
                              child: CoinChart(
                                coin: state.coin!,
                                interval: CoinHistory.hourly,
                                showTitle: true,
                              ),
                            ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, bottom: 30, top: 60),
                        child: CoinChart(
                          coin: state.coin!,
                          interval: CoinHistory.weekly,
                          showTitle: true,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, bottom: 30, top: 60),
                        child: CoinChart(
                          coin: state.coin!,
                          interval: CoinHistory.monthly,
                          showTitle: true,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
