import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stock_quote_app/widgets/stock_chart.dart';

class Cardwidget extends StatelessWidget {
  const Cardwidget({super.key, required this.ontap});

  final Function ontap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 450,
      width: double.infinity,
      child: GestureDetector(
        onTap: () => ontap(),
        child: Card(
          color: Colors.white,
          elevation: 3,
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StockChart(),
                const SizedBox(height: 20),
                Text("Stock Name",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text("Stock Price",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
