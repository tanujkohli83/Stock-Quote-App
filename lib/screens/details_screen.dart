import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../widgets/stock_chart.dart';
import '../utils/wishlist_manager.dart';

class DetailsScreen extends StatefulWidget {
  final String symbol;

  const DetailsScreen({super.key, required this.symbol});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  late bool isWishlisted;
  bool _isLoading = true;
  String companyName = '';
  String price = '';
  String change = '';
  String changePercent = '';
  String marketCap = '';
  String peRatio = '';
  String error = '';

  @override
  void initState() {
    super.initState();
    isWishlisted = isInWishlist(widget.symbol);
    fetchStockDetails();
  }

  void _toggleWishlist() {
    toggleWishlist(widget.symbol);
    setState(() {
      isWishlisted = !isWishlisted;
    });
  }

  Future<void> fetchStockDetails() async {
    final url = Uri.parse(
      'https://api.twelvedata.com/quote?symbol=${widget.symbol}&apikey=dbdcc91bbd8f4feab4b4bb4d8d7c7807',
    );

    try {
      final response = await http.get(url);
      final data = json.decode(response.body);

      if (data['status'] == 'error') {
        throw Exception(data['message']);
      }

      setState(() {
        companyName = data['name'] ?? '';
        price = data['close'] ?? 'N/A';
        change = data['change'] ?? '0.0';
        changePercent = data['percent_change'] ?? '0.0';
        marketCap = data['market_cap'] ?? 'N/A';
        peRatio = data['pe'] ?? 'N/A';
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        error = 'Error loading stock details';
        _isLoading = false;
      });
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: _toggleWishlist,
            icon: Image.asset(
              isWishlisted ? "assets/heart_red.png" : "assets/heart_black.png",
              height: 30,
              width: 30,
            ),
          ),
        ],
      ),
      body:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : error.isNotEmpty
              ? Center(child: Text(error))
              : Padding(
                padding: const EdgeInsets.all(16),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        companyName.isNotEmpty
                            ? '$companyName (${widget.symbol})'
                            : widget.symbol,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Current Price: \$$price',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Change: $change (${changePercent}%)',
                        style: TextStyle(
                          fontSize: 18,
                          color:
                              change.startsWith('-')
                                  ? Colors.red
                                  : Colors.green,
                        ),
                      ),

                      const SizedBox(height: 30),
                      SizedBox(
                        height: 300,
                        child: StockChart(symbol: widget.symbol),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Market Cap: $marketCap',
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'P/E Ratio: $peRatio',
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
    );
  }
}
