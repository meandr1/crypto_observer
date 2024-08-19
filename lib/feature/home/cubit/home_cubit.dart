import 'package:crypto_observer/managers/data_manager_interface.dart';
import 'package:crypto_observer/models/coin.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final IDataManager _dataManager;

  HomeCubit(this._dataManager) : super(HomeState.initial());

  void addCoins(List<Coin> coins) {
    emit(state.copyWith(coins: coins));
  }

  void updateCoin(Coin coin) {
    final updatedList = [
      ...state.coins.map((el) => el.name == coin.name ? coin : el)
    ];
    emit(state.copyWith(coins: updatedList));
  }

  void updateCoinsList() async {
    try {
      final topCoinsList = await _dataManager.getCoinsList();
      final coins =
          await _dataManager.getMonthlyDataForEachListCoin(topCoinsList);
      emit(state.copyWith(status: HomeStatus.success, coins: coins));
    } catch (e) {
      emit(state.copyWith(status: HomeStatus.error));
    }
  }
}
