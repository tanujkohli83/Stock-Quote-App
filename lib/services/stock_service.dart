import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/stock_quote.dart';

class StockService {
  final String _baseUrl = 'https://api.twelvedata.com/';

  Future<StockQuote?> fetchQuote(String symbol) async {
    // final apiKey = dotenv.env['FINNHUB_API_KEY'];
    final String apiKey = "dbdcc91bbd8f4feab4b4bb4d8d7c7807" ;
    final url = Uri.parse('$_baseUrl/stocks?exchange=NASDAQ&apikey=$apiKey');

    final response = await http.get(url);
    if (response.statusCode == 200) {
      print(response);
      return StockQuote.fromJson(json.decode(response.body));
    } else {  
      return null;
    }
  }
}
