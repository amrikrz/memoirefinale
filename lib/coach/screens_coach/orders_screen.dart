




import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:intl/intl.dart';
import 'package:sportapplication/coach/models/order_item.dart';
import 'package:sportapplication/coach/screens_coach/orders_a_coach.dart';
import 'package:sportapplication/coach/screens_coach/salle_coach_accept.dart';
import 'package:sportapplication/projects/demande_salle_coach.dart';

class OrderScreen extends StatelessWidget {
  String formatedDate(date) {
    final outPutDateFormate = DateFormat('dd/MM/yyyy');

    final outPutDate = outPutDateFormate.format(date);

    return outPutDate;
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            title: Text(
              'My Orders',
              style: TextStyle(
                color: Colors.pinkAccent,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                letterSpacing: 5,
              ),
            ),
            bottom: TabBar(
                dividerHeight: 0,
                indicatorSize:TabBarIndicatorSize.tab,
                indicatorPadding: EdgeInsets.symmetric(horizontal: 10),
                tabs: [
              Tab(text: "Sportifs",),
              Tab(text: "Salles",)
            ]),
          ),
          body: const TabBarView(
            children: [
              OrdersACoach(),
              SalleCoachAccept()
            ]),
    ));
  }
}