class StockInfo {
  final String symbol;
  final String name;
  final String currency;

  StockInfo({
    required this.symbol,
    required this.name,
    required this.currency,
  });

  factory StockInfo.fromJson(Map<String, dynamic> json) {
    return StockInfo(
      symbol: json['symbol'] ?? '',
      name: json['name'] ?? '',
      currency: json['currency'] ?? '',
    );
  }
}
