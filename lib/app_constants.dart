export 'app_constants.dart';

enum CoinHistory { hourly, weekly, monthly }

const int coinsPerRequest = 15;
const String coinsTopListUrl =
    'https://min-api.cryptocompare.com/data/top/totaltoptiervolfull';
const String dailyCoinHistoryUrl =
    'https://min-api.cryptocompare.com/data/v2/histoday';
const String hourlyCoinHistoryUrl =
    'https://min-api.cryptocompare.com/data/v2/histohour';
const int splashScreenMinDuration = 2000; //milliseconds
const int chartAnimationInterval = 200; //milliseconds
const double cacheExtent = 3000; //pixels

