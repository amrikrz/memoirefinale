import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart'; 
import 'package:sportapplication/screens_client/statistique/addweight.dart';
import 'package:sportapplication/screens_client/statistique/history.dart';

class Statistique extends StatefulWidget {
  @override
  _StatistiqueState createState() => _StatistiqueState();
}

class _StatistiqueState extends State<Statistique>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Poids'),
            Tab(text: 'Hauteur'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          WeightTab(), 
          HeightTab(), 
        ],
      ),
    );
  }
}

class WeightTab extends StatefulWidget { 
  @override
  _WeightTabState createState() => _WeightTabState();
}

class _WeightTabState extends State<WeightTab> {
  // Sample weight data (replace with your actual data)
  List<_ChartData> chartData = [
    _ChartData(DateTime(2023, 10, 26), 70.5),
    _ChartData(DateTime(2023, 10, 27), 70.0),
    _ChartData(DateTime(2023, 10, 28), 69.8),
    _ChartData(DateTime(2023, 10, 29), 70.2),
    _ChartData(DateTime(2023, 10, 30), 70.1),
    _ChartData(DateTime(2023, 10, 31), 69.9),
    // ... add more data points
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(16.0),
                child: SfCartesianChart(
                  title: ChartTitle(text: 'Suivi du poids quotidien'),
                  primaryXAxis: CategoryAxis(
                    // Display only the day of the month
                  //  labelFormatter: (value) => DateFormat('dd').format(value as DateTime),
                    // Enable minor grid lines
                    majorGridLines: MajorGridLines(width: 0),
                  //  minorGridLines: MinorGridLines(width: 0),
                  ),
                  primaryYAxis: NumericAxis(
                    title: AxisTitle(text: 'Poids (kg)'),
                    // Enable minor grid lines
                    majorGridLines: MajorGridLines(width: 0),
                    minorGridLines: MinorGridLines(width: 0),
                  ),
                  /*series: <ChartSeries<_ChartData, String>>[
                    LineSeries<_ChartData, String>(
                      dataSource: chartData,
                      // X-value mapper (day of the month)
                      xValueMapper: (_ChartData data, _) => DateFormat('dd').format(data.date),
                      // Y-value mapper (weight)
                      yValueMapper: (_ChartData data, _) => data.weight,
                      // Set the color of the line
                      color: Colors.blue,
                    ),
                  ],*/
                ),
              ),
            ),
            // Button to navigate to AddWeightScreen for adding weight data
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddWeightScreen()),
                  );
                },
                child: Text('Ajouter du poids'),
              ),
            ),
            // Display weight history (consider using HistoryScreen)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HistoryScreen()),
                  );
                },
                child: Text('Afficher l\'historique du poids'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HeightTab extends StatefulWidget {
  @override
  _HeightTabState createState() => _HeightTabState();
}

class _HeightTabState extends State<HeightTab> {
  final TextEditingController _heightController = TextEditingController();

  @override
  void dispose() {
    _heightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _heightController,
              decoration: InputDecoration(
                labelText: 'Enter Height (cm)',
              ),
              keyboardType: TextInputType.number,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                // Handle height saving or updating logic
                // For example, you can store the height in a variable or database
                print("Height: ${_heightController.text}");
              },
              child: Text('Save Height'),
            ),
          ),
        ],
      ),
    );
  }
}

// Data class for the chart data
class _ChartData {
  _ChartData(this.date, this.weight);

  final DateTime date;
  final double weight;
}