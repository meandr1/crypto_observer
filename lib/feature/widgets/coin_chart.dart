import 'package:crypto_observer/app_colors.dart';
import 'package:crypto_observer/models/coin.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:crypto_observer/app_constants.dart';
import 'dart:async';
import 'package:intl/intl.dart';

class CoinChart extends StatefulWidget {
  const CoinChart(
      {super.key,
      required this.coin,
      required this.showTitle,
      required this.interval});

  final Coin coin;
  final CoinHistory interval;
  final bool showTitle;

  @override
  CoinChartState createState() => CoinChartState();
}

class CoinChartState extends State<CoinChart> {
  late List<Map<int, num>>? _data;
  final List<FlSpot> _allSpots = [];
  final List<FlSpot> _currentSpots = [];
  late Timer _timer;
  late int _animationInterval;
  late bool _isGrowth;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _getSpots();
    _isGrowth = _allSpots.first.y <= _allSpots.last.y;
    _animationInterval = _allSpots.length < 8
        ? chartAnimationInterval
        : chartAnimationInterval ~/ 4;
    if (_allSpots.length > 2) {
      _currentSpots.addAll(_allSpots.sublist(0, 2));
      _currentIndex = 2;
    }
    _timer =
        Timer.periodic(Duration(milliseconds: _animationInterval), (timer) {
      if (_currentIndex < _allSpots.length) {
        setState(() {
          _currentSpots.add(_allSpots[_currentIndex]);
          _currentIndex++;
        });
      } else {
        _timer.cancel();
      }
    });
  }

  void _getSpots() {
    switch (widget.interval) {
      case CoinHistory.hourly:
        _data = widget.coin.hourly;
        break;
      case CoinHistory.weekly:
        _data = widget.coin.monthly?.sublist(0, 7);
        break;
      case CoinHistory.monthly:
        _data = widget.coin.monthly;
        break;
    }
    if (_data != null) {
      for (int i = _data!.length - 1; i >= 0; i--) {
        _allSpots.add(FlSpot((_data!.length - 1 - i).toDouble(),
            _data![i].values.first.toDouble()));
      }
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentColor = _isGrowth ? growColor : declineColor;
    return AspectRatio(
      aspectRatio: 1.8,
      child: LineChart(
        LineChartData(
          lineBarsData: [
            LineChartBarData(
              spots: _currentSpots,
              isCurved: true,
              color: currentColor,
              dotData: const FlDotData(show: false),
              barWidth: 1,
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  colors: [currentColor.withOpacity(0.1), currentColor],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
          ],
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: widget.showTitle,
                reservedSize: 40,
                interval: 1,
                getTitlesWidget: _getTitlesWidget,
              ),
            ),
            leftTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          gridData: const FlGridData(show: false),
          borderData: FlBorderData(show: false),
          backgroundColor: Colors.transparent,
        ),
      ),
    );
  }

  Widget _getTitlesWidget(double value, TitleMeta meta) {
    final int index = _data!.length - 1 - value.toInt();
    final int? timestamp = _data?.asMap()[index]?.keys.first;
    if (timestamp == null) {
      return const SizedBox.shrink();
    }
    final date = DateFormat('dd MMM')
        .format(DateTime.fromMillisecondsSinceEpoch(timestamp * 1000));
    final hour = DateFormat('HH:mm')
        .format(DateTime.fromMillisecondsSinceEpoch(timestamp * 1000));
    if (widget.interval == CoinHistory.weekly) {
      return Text(
        date.toString(),
        style: Theme.of(context).textTheme.labelSmall?.copyWith(fontSize: 10),
      );
    } else if (widget.interval == CoinHistory.monthly) {
      if (index % 5 == 0) {
        return Text(
          date.toString(),
          style: Theme.of(context).textTheme.labelSmall?.copyWith(fontSize: 10),
        );
      } else {
        return const SizedBox.shrink();
      }
    } else {
      if (index % 3 == 0) {
        return Text(
          hour.toString(),
          style: Theme.of(context).textTheme.labelSmall?.copyWith(fontSize: 10),
        );
      } else {
        return const SizedBox.shrink();
      }
    }
  }
}
