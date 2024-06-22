import 'package:flutter/material.dart';
import 'package:sportapplication/screens_client/statistique/poid_statistique.dart';
import 'package:sportapplication/screens_client/statistique/taille_statistique.dart';
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
          PoidStatistique(),
          TailleStatistique(),
        ],
      ),
    );
  }
}
