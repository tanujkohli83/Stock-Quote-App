import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_quote_app/models/stock_quote.dart';
import '../providers/stock_provider.dart';
import '../widgets/cardWidget.dart';
import 'details_screen.dart';
import 'wishlist_Screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();
  List<StockQuote> _filteredStocks = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<StockProvider>(context, listen: false);
      provider.loadStocks().then((_) {
        setState(() {
          _filteredStocks = provider.stocks;
        });
      });
    });
  }

  void _searchStock(String query) {
    final provider = Provider.of<StockProvider>(context, listen: false);
    if (query.isEmpty) {
      setState(() {
        _filteredStocks = provider.stocks;
      });
    } else {
      final filtered =
          provider.stocks
              .where(
                (stock) =>
                    stock.symbol.toLowerCase().contains(query.toLowerCase()),
              )
              .toList();
      setState(() {
        _filteredStocks = filtered;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<StockProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Stock Quote App'),
        titleTextStyle: const TextStyle(
          fontSize: 28,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        actions: [
          IconButton(
            icon: Image.asset(
              "assets/icons8-refresh-90.png",
              height: 30,
              width: 30,
            ),
            onPressed: () {
              provider.loadStocks().then((_) {
                _searchStock(_controller.text);
              });
            },
          ),
          IconButton(
            icon: Image.asset("assets/wishlist.png", height: 30, width: 30),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const WishlistScreen()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Enter Stock Symbol (e.g. AAPL)',
                hintStyle: const TextStyle(color: Colors.black, fontSize: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                fillColor: Colors.white,
                filled: true,
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () => _searchStock(_controller.text),
                ),
              ),
              onChanged: _searchStock,
            ),
            const SizedBox(height: 20),
            provider.isLoading
                ? const CircularProgressIndicator()
                : provider.error.isNotEmpty
                ? Text(provider.error)
                : Expanded(
                  child:
                      _filteredStocks.isEmpty
                          ? const Text("No stock found")
                          : ListView.builder(
                            itemCount: _filteredStocks.length,
                            itemBuilder: (context, index) {
                              final stock = _filteredStocks[index];
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 6.0,
                                ),
                                child: Cardwidget(
                                  stockName: stock.name,
                                  stockSymbol: stock.symbol,
                                  ontap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (context) => DetailsScreen(
                                              symbol: stock.symbol,
                                            ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                ),
          ],
        ),
      ),
    );
  }
}
