import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<StockProvider>(context, listen: false).loadStocks();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<StockProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Stock Quote App'),
        titleTextStyle: TextStyle(
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
              provider.loadStocks();
            },
          ),
          IconButton(
            icon: Image.asset("assets/wishlist.png", height: 30, width: 30),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => WishlistScreen()),
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
                hintStyle: TextStyle(color: Colors.black, fontSize: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                fillColor: Colors.white,
                filled: true,
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {},
                ),
              ),
            ),
            const SizedBox(height: 20),
            provider.isLoading
                ? CircularProgressIndicator()
                : provider.error.isNotEmpty
                ? Text(provider.error)
                : Expanded(
                  child: ListView.builder(
                    itemCount: provider.stocks.length,
                    itemBuilder: (context, index) {
                      final stock = provider.stocks[index];
                      return Cardwidget(
                        stockName: stock.name,
                        stockSymbol: stock.symbol,
                        stockPrice: "",
                        ontap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) =>
                                      DetailsScreen(symbol: stock.symbol),
                            ),
                          );
                        },
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
