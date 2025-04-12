class StockQuote {
  final String symbol;
  final String name;
  final String currency;

  StockQuote({
    required this.symbol,
    required this.name,
    required this.currency,
  });

  factory StockQuote.fromJson(Map<String, dynamic> json) {
    return StockQuote(
      symbol: json['symbol'] ?? '',
      name: json['name'] ?? '',
      currency: json['currency'] ?? '',
    );
  }
}
