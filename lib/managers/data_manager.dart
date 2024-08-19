import 'package:crypto_observer/app_constants.dart';
import 'package:crypto_observer/managers/data_manager_interface.dart';
import 'package:crypto_observer/models/coin.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DataManager implements IDataManager {
  static final DataManager _singleton = DataManager._internal();
  static final apiKey = dotenv.get('API_KEY');

  factory DataManager() => _singleton;

  DataManager._internal();

  @override
  Future<List<Coin>> getCoinsList() async {
    final List<Coin> coins = [];
    final url =
        "$coinsTopListUrl?limit=$coinsPerRequest&tsym=USD&api_key=$apiKey";
    final response = await Dio().get(url);
    if (response.statusCode == 200) {
      List jsonData = response.data['Data'];
      coins.addAll(jsonData.map((e) => Coin.fromJSON(e)));
    }
    return coins;
  }

  @override
  Future<List<Coin>> getMonthlyDataForEachListCoin(List<Coin> coins) async {
    final List<Coin> updatedCoins =
        await Future.wait([...coins].map((el) => getMonthlyDataForCoin(el)));
    return updatedCoins;
  }

  @override
  Future<Coin> getMonthlyDataForCoin(Coin coin) async {
    final url =
        "$dailyCoinHistoryUrl?limit=30&fsym=${coin.name}&tsym=USD&api_key=$apiKey";
    final response = await Dio().get(url);
    if (response.statusCode == 200) {
      final List jsonData = response.data['Data']['Data'].reversed.toList();
      List<Map<int, num>> monthlyData =
          jsonData.map((e) => {e['time'] as int: e['close'] as num}).toList();
      return coin.copyWith(monthly: monthlyData);
    }
    return coin;
  }

  @override
  Future<Coin> getDailyDataForCoin(Coin coin) async {
    final url =
        "$hourlyCoinHistoryUrl?limit=24&fsym=${coin.name}&tsym=USD&api_key=$apiKey";
    final response = await Dio().get(url);
    if (response.statusCode == 200) {
      final List jsonData = response.data['Data']['Data'].reversed.toList();
      List<Map<int, num>> hourlyData =
          jsonData.map((e) => {e['time'] as int: e['close'] as num}).toList();
      return coin.copyWith(hourly: hourlyData);
    }
    return coin;
  }
}
