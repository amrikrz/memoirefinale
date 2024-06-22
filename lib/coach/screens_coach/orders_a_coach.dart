import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sportapplication/coach/models/order_item.dart';

import '../models/plan_object.dart';

class OrdersACoach extends StatefulWidget {
  const OrdersACoach({Key? key}) : super(key: key);

  @override
  State<OrdersACoach> createState() => _OrdersACoachState();
}

class _OrdersACoachState extends State<OrdersACoach> {

  Future<String> getUid() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String uid =  prefs.getString('userId')??"";
    return uid;
  }

  Future<List<PlanObject>> getData() async{
    List<PlanObject> list = [];
    String uid = await getUid();
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    QuerySnapshot<Map<String, dynamic>> dat = await firestore.collection("Sell").where("coachID",isEqualTo: uid).get();
    for (var data in dat.docs) {
      PlanObject model = PlanObject(name: data["name"], description: data["subtitle"], categorie: data["categorie"], niveau: data["niveau"], prix:  data["prix"], uid: data["planID"], image:data["image"]);
      list.add(model);
    }return list;
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<PlanObject>>(
      future: getData(),
      builder: (BuildContext context, AsyncSnapshot<List<PlanObject>> snapshot) {
        if(snapshot.connectionState == ConnectionState.done){
          return snapshot.data?.isEmpty??true?Center(child: Text("Aucun Order"),):
              ListView.builder(
                  itemCount: snapshot.data?.length??0,
                  itemBuilder: (context,position)=>OrderItem(plan: snapshot.data![position]));
        }
        return Center(child: CircularProgressIndicator(),);
      },

    );
  }
}
