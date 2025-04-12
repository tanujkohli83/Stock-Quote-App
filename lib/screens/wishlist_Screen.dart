import 'package:flutter/material.dart';
import '../utils/wishlist_manager.dart';
import 'details_screen.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My Wishlist")),
      body: wishlist.isEmpty
          ? Center(child: Text("No stocks in wishlist"))
          : ListView.builder(
              itemCount: wishlist.length,
              itemBuilder: (context, index) {
                final symbol = wishlist[index];
                return ListTile(
                  title: Text(symbol),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetailsScreen(symbol: symbol),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
