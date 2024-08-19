import 'package:crypto_observer/managers/data_manager_interface.dart';
import 'package:crypto_observer/models/coin.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final IDataManager _dataManager;

  SplashCubit(this._dataManager) : super(SplashState.initial());

  void getCoinsList() async {
    try {
      final topCoinsList = await _dataManager.getCoinsList();
      final coins =
          await _dataManager.getMonthlyDataForEachListCoin(topCoinsList);
      emit(state.copyWith(status: SplashStatus.success, coins: coins));
    } catch (e) {
      emit(state.copyWith(status: SplashStatus.error));
    }
  }
}
