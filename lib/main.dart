import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'providers/stock_provider.dart';

void main() async {
  // await dotenv.load();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => StockProvider(),
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: Color(0xFFFED9B7),
          scaffoldBackgroundColor: Color(0xFFFED9B7),
          appBarTheme: AppBarTheme(backgroundColor: Color(0xFFFED9B7)),

        ),
        debugShowCheckedModeBanner: false,
        title: 'Stock Quote App',
        home: HomeScreen(),
      ),
    );
  }
}
