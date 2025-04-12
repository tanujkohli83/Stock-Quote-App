import 'package:flutter/material.dart';
import '../models/stock_quote.dart';
import '../services/stock_service.dart';

class StockProvider extends ChangeNotifier {
  final StockService _service = StockService();
  StockQuote? _stock;
  bool _isLoading = false;
  String _error = '';

  StockQuote? get stock => _stock;
  bool get isLoading => _isLoading;
  String get error => _error;

  Future<void> fetchStock(String symbol) async {
    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      final result = await _service.fetchQuote(symbol);
      if (result != null) {
        _stock = result;
      } else {
        _error = 'Stock not found';
      }
    } catch (e) {
      _error = 'Error: ${e.toString()}';
    }

    _isLoading = false;
    notifyListeners();
  }
}
