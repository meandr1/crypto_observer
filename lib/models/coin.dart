class Coin {
  final String name;
  final String fullName;
  final String imageUrl;
  final double price;
  final List<Map<int, num>>? hourly;
  final List<Map<int, num>>? monthly;

  Coin(
      {this.hourly,
      this.monthly,
      required this.name,
      required this.imageUrl,
      required this.fullName,
      required this.price});

  factory Coin.fromJSON(Map<String, dynamic> json) {
    return Coin(
      name: json['CoinInfo']['Name'],
      fullName: json['CoinInfo']['FullName'],
      imageUrl: json['CoinInfo']['ImageUrl'] ?? '',
      price: json['RAW']?['USD']?['PRICE'] ?? 0.0,
    );
  }

  String get fullImageUrl => 'https://www.cryptocompare.com$imageUrl';

  Coin copyWith({
    String? name,
    String? fullName,
    String? imageUrl,
    double? price,
    List<Map<int, num>>? hourly,
    List<Map<int, num>>? monthly,
  }) {
    return Coin(
      name: name ?? this.name,
      fullName: fullName ?? this.fullName,
      imageUrl: imageUrl ?? this.imageUrl,
      price: price ?? this.price,
      hourly: hourly ?? this.hourly,
      monthly: monthly ?? this.monthly,
    );
  }
}
