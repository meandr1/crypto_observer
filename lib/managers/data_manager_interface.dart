import 'package:crypto_observer/models/coin.dart';

abstract interface class IDataManager {
  Future<List<Coin>> getCoinsList();

  Future<List<Coin>> getMonthlyDataForEachListCoin(List<Coin> coins);

  Future<Coin> getMonthlyDataForCoin(Coin coin);

  Future<Coin> getDailyDataForCoin(Coin coin);
}
