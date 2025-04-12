import 'package:flutter/material.dart';
import '../models/stock_quote.dart';
import '../services/stock_service.dart';

class StockProvider extends ChangeNotifier {
  List<StockQuote> _stocks = [];
  bool isLoading = false;
  String error = '';

  List<StockQuote> get stocks => _stocks;

  Future<void> loadStocks() async {
    isLoading = true;
    notifyListeners();
    try {
      final stockList = await StockService().fetchStockList();
      _stocks = stockList.toList(); 
      error = '';
    } catch (e) {
      print('Error loading stocks: $e');
      error = 'Failed to load stocks';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
