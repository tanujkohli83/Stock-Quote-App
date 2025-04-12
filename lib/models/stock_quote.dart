class StockQuote {
  final double currentPrice;
  final double change;
  final double percentChange;

  StockQuote({required this.currentPrice, required this.change, required this.percentChange});

  factory StockQuote.fromJson(Map<String, dynamic> json) {
    return StockQuote(
      currentPrice: json['c']?.toDouble() ?? 0.0,
      change: json['d']?.toDouble() ?? 0.0,
      percentChange: json['dp']?.toDouble() ?? 0.0,
    );
  }
}
