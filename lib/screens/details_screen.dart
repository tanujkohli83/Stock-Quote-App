import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
    isWishlisted = isInWishlist(widget.symbol);
  }

  void _toggleWishlist() {
    toggleWishlist(widget.symbol);
    setState(() {
      isWishlisted = !isWishlisted;
    });
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
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Company: ${widget.symbol} Inc.',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            const Text('Current Price: \$123.45', style: TextStyle(fontSize: 18)),
            const Text('Day Change: +1.5%', style: TextStyle(fontSize: 18)),

            const SizedBox(height: 30),

            SizedBox(
              height: 250,
              child: StockChart(symbol: widget.symbol), // 👈 pass symbol here
            ),
          ],
        ),
      ),
    );
  }
}
