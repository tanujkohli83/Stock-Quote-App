import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_quote_app/screens/wishlist_Screen.dart';
import '../providers/stock_provider.dart';
import '../widgets/cardWidget.dart';
import 'details_screen.dart';

class HomeScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

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
          Row(
            children: [
              TextButton(
                onPressed: () {},
                child: Image.asset(
                  "assets/icons8-refresh-90.png",
                  height: 30,
                  width: 30,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => WishlistScreen()),
                  );
                },
                child: Image.asset(
                  "assets/wishlist.png",
                  height: 30,
                  width: 30,
                ),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
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
                  fillColor: Colors.white, // Set the background color to white
                  filled: true, // Enable filling the background
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      // provider.fetchStock(_controller.text.trim().toUpperCase());
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),
              provider.isLoading
                  ? CircularProgressIndicator()
                  : provider.error.isNotEmpty
                  ? Text(provider.error)
                  : provider.stock != null
                  ? Column(
                    children: [
                      Text('Price: \$${provider.stock!.currentPrice}'),
                      Text(
                        'Change: ${provider.stock!.change} (${provider.stock!.percentChange}%)',
                      ),
                    ],
                  )
                  : Container(),
              for (int i = 0; i < 2; i++)
                Cardwidget(
                  ontap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => DetailsScreen(
                              symbol: 'STOCK${i + 1}', // Dummy symbol for now
                              // You can pass other parameters as needed
                            ),
                      ),
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
