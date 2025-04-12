import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class StockData {
  final DateTime time;
  final double price;

  StockData(this.time, this.price);
}

class StockChart extends StatefulWidget {
  final String symbol;

  const StockChart({super.key, required this.symbol});

  @override
  State<StockChart> createState() => _StockChartState();
}

class _StockChartState extends State<StockChart> {
  List<StockData> _chartData = [];
  bool _isLoading = true;
  Color _lineColor = Colors.green;

  // ✅ Initialize zoomPanBehavior directly to avoid LateInitializationError
  final ZoomPanBehavior _zoomPanBehavior = ZoomPanBehavior(
    enablePinching: true,
    enablePanning: true,
    zoomMode: ZoomMode.x,
  );

  @override
  void initState() {
    super.initState();
    fetchChartData();
  }

  Future<void> fetchChartData() async {
    final url = Uri.parse(
      'https://api.twelvedata.com/time_series?symbol=${widget.symbol}&interval=1min&outputsize=30&apikey=dbdcc91bbd8f4feab4b4bb4d8d7c7807',
    );

    try {
      final response = await http.get(url);
      final data = json.decode(response.body);

      if (data['status'] == 'error') {
        throw Exception(data['message']);
      }

      final List<StockData> loadedData = [];

      for (var item in data['values']) {
        final time = DateTime.parse(item['datetime']);
        final price = double.tryParse(item['close']) ?? 0.0;
        loadedData.add(StockData(time, price));
      }

      loadedData.sort((a, b) => a.time.compareTo(b.time));

      final latest = loadedData.last.price;
      final previousClose = loadedData.first.price;

      setState(() {
        _chartData = loadedData;
        _lineColor = latest < previousClose ? Colors.red : Colors.green;
        _isLoading = false;
      });
    } catch (e) {
      print('Error loading chart data: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(child: CircularProgressIndicator())
        : Container(
          width: double.infinity,
          height: 400,
          child: SfCartesianChart(
            backgroundColor: Colors.white,
            plotAreaBorderWidth: 1,
            zoomPanBehavior: _zoomPanBehavior,
            tooltipBehavior: TooltipBehavior(enable: true),
            primaryXAxis: DateTimeAxis(
              edgeLabelPlacement: EdgeLabelPlacement.shift,
              dateFormat: DateFormat.Hm(),
              intervalType: DateTimeIntervalType.minutes,
              labelIntersectAction: AxisLabelIntersectAction.rotate45,
              majorGridLines: MajorGridLines(width: 0.5),
              axisLine: AxisLine(width: 1),
              labelStyle: TextStyle(fontSize: 12),
            ),
            primaryYAxis: NumericAxis(
              opposedPosition: true,
              majorGridLines: MajorGridLines(width: 0.5),
              axisLine: AxisLine(width: 1),
              labelStyle: TextStyle(fontSize: 12),
            ),
            series: <CartesianSeries>[
              LineSeries<StockData, DateTime>(
                dataSource: _chartData,
                xValueMapper: (StockData data, _) => data.time,
                yValueMapper: (StockData data, _) => data.price,
                color: _lineColor,
                width: 3,
                markerSettings: MarkerSettings(isVisible: true),
                dataLabelSettings: DataLabelSettings(isVisible: false),
              ),
            ],
          ),
        );
  }
}
