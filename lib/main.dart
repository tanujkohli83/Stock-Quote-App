import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'providers/stock_provider.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => StockProvider(),
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: const Color(0xFFFED9B7),
          scaffoldBackgroundColor: const Color(0xFFFED9B7),
          appBarTheme: const AppBarTheme(backgroundColor: Color(0xFFFED9B7)),

        ),
        debugShowCheckedModeBanner: false,
        title: 'Stock Quote App',
        home: HomeScreen(),
      ),
    );
  }
}
