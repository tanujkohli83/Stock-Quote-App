import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/stock_quote.dart';

class StockService {
  // final String _baseUrl = 'https://api.twelvedata.com/';

  final String _apiKey = "dbdcc91bbd8f4feab4b4bb4d8d7c7807";

  Future<List<StockQuote>> fetchStockList() async {
    // final url = Uri.parse('$_baseUrl/stocks?exchange=NASDAQ&apikey=$_apiKey');

    final url = Uri.parse('https://api.twelvedata.com/stocks?exchange=NASDAQ&apikey=$_apiKey');

    try {
      print("Fetching stock list from: $url");

      final response = await http.get(url);

      print("Status code: ${response.statusCode}");
      print("Raw response: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        if (jsonResponse.containsKey('data')) {
          final List<dynamic> data = jsonResponse['data'];
          print("Parsed stock data: $data");
          return data.map((item) => StockQuote.fromJson(item)).toList();
        } else if (jsonResponse.containsKey('status')) {
          // API error format
          throw Exception("API error: ${jsonResponse['message']}");
        } else {
          throw Exception("Unexpected API response format");
        }
      } else {
        throw Exception('Failed to load stock list with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception in fetchStockList: $e');
      rethrow;
    }
  }
}
