part of 'splash_cubit.dart';

enum SplashStatus { initial, success, error }

class SplashState extends Equatable {
  final SplashStatus status;
  final List<Coin> coins;

  const SplashState({
    required this.coins,
    required this.status,
  });

  factory SplashState.initial() {
    return const SplashState(
      coins: [],
      status: SplashStatus.initial,
    );
  }

  SplashState copyWith({SplashStatus? status, List<Coin>? coins}) {
    return SplashState(
      coins: coins ?? this.coins,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [status, coins];
}
