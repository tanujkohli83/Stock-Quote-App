import 'package:flutter/material.dart';

class Cardwidget extends StatelessWidget {
  const Cardwidget({
    super.key,
    required this.ontap,
    required this.stockName,
    required this.stockSymbol,
  });

  final VoidCallback ontap;
  final String stockName;
  final String stockSymbol;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 10),
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Text(
                stockName,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (stockSymbol.isNotEmpty)
                Text(
                  stockSymbol,
                  style: const TextStyle(fontSize: 20, color: Colors.black),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
