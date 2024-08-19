part of 'home_cubit.dart';

enum HomeStatus { initial, loading, success, error }

class HomeState extends Equatable {
  final HomeStatus status;
  final List<Coin> coins;

  const HomeState({
    required this.status,
    required this.coins,
  });

  factory HomeState.initial() {
    return const HomeState(
      coins: [],
      status: HomeStatus.initial,
    );
  }

  HomeState copyWith({
    HomeStatus? status,
    List<Coin>? coins,
  }) {
    return HomeState(
      coins: coins ?? this.coins,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        status,
        coins,
      ];
}
