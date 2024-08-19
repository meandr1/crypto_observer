part of 'details_cubit.dart';

enum DetailsStatus { initial, loading, success, error }

class DetailsState extends Equatable {
  final DetailsStatus status;
  final Coin? coin;

  const DetailsState({
    required this.status,
    this.coin,
  });

  factory DetailsState.initial() {
    return const DetailsState(
      status: DetailsStatus.initial,
    );
  }

  DetailsState copyWith({
    DetailsStatus? status,
    Coin? coin,
  }) {
    return DetailsState(
      coin: coin ?? this.coin,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [status, coin];
}
