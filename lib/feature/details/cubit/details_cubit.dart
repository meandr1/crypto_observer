import 'package:crypto_observer/managers/data_manager_interface.dart';
import 'package:crypto_observer/models/coin.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'details_state.dart';

class DetailsCubit extends Cubit<DetailsState> {
  final IDataManager _dataManager;

  DetailsCubit(this._dataManager) : super(DetailsState.initial());

  void addCoin(Coin coin) {
    emit(state.copyWith(coin: coin));
    if (coin.hourly?.isEmpty ?? true) {
      updateCoinDailyData();
    }
  }

  void updateCoinDailyData() async {
    emit(state.copyWith(status: DetailsStatus.loading));
    try {
      final coin = await _dataManager.getDailyDataForCoin(state.coin!);
      emit(state.copyWith(status: DetailsStatus.success, coin: coin));
    } catch (e) {
      emit(state.copyWith(status: DetailsStatus.error));
    }
  }
}
