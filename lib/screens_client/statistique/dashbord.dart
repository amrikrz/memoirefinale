import 'package:flutter/material.dart';
import 'package:sportapplication/screens_client/statistique/addweight.dart';
import 'package:sportapplication/screens_client/statistique/history.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weighty'),
        actions: [
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.black,
            ),
            onPressed: () {
            Navigator.push(
                context,
              MaterialPageRoute(builder:(context) => AddWeightScreen(), ) ,
              );
            
            },
          ),

          IconButton(
            icon: Icon(
              Icons.history,
              color: Colors.black,
            ),
            onPressed: () {
            Navigator.push(
                context,
              MaterialPageRoute(builder:(context) => HistoryScreen(), ) ,
              );
            
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [


            _buildCurrentWeightCard(),
            SizedBox(height: 20),
            _buildStatisticsCard(),
            SizedBox(height: 20),
            _buildWeightGraph(),
        

            
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentWeightCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Current Weight'),
            Text(
              '93.1 KG',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            Text('Start: 100.0 KG, Goal: 90.0 KG'),
          ],
        ),
      ),
    );
  }

  Widget _buildStatisticsCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Statistics'),
            Text('69% Completed'),
            Text('6.90 KG Total Lost'),
            Text('3.10 KG Left to Go'),
          ],
        ),
      ),
    );
  }

  Widget _buildWeightGraph() {
    // Placeholder for the weight graph
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text('Weight Graph Placeholder'),
      ),
    );

  }
}
/*

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class MyWeightData {
  final String date;
  final double weight;
  final double height;

  MyWeightData({required this.date, required this.weight, required this.height});

  factory MyWeightData.fromSnapshot(DataSnapshot snapshot) {
    return MyWeightData(
      date: snapshot.key!,
      weight: snapshot.value['weight'],
      height: snapshot.value['height'],
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weight Analysis',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
//  final databaseReference = FirebaseDatabase.instance.reference();
  List<MyWeightData> weightData = [];

  double calculateBmi(double weight, double height) {
    return weight / (height / 100) * (height / 100);
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    final weightSnapshot = await databaseReference.child('weights').get();
    final heightSnapshot = await databaseReference.child('heights').get();
    if (weightSnapshot.exists && heightSnapshot.exists) {
      weightData.clear();
      /*for (DataSnapshot ds in weightSnapshot.children) {
        weightData.add(MyWeightData.fromSnapshot(ds));
      }*/
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weight Analysis'),
      ),
      body: weightData.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: weightData.length,
              itemBuilder: (context, index) {
                final entry = weightData[index];
                final bmi = calculateBmi(entry.weight, entry.height);
                return ListTile(
                  title: Text(entry.date),
                  subtitle: Text('Weight: ${entry.weight}kg, Height: ${entry.height}cm, BMI: ${bmi.toString}'));},),);}}
*/