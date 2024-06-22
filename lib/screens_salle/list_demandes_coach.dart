import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ajouter_salle/demande_salle_item.dart';
import 'list_demande_clients.dart';

class ListDemandesCoach extends StatefulWidget {
  const ListDemandesCoach({Key? key}) : super(key: key);

  @override
  State<ListDemandesCoach> createState() => _ListDemandesCoachState();
}

class _ListDemandesCoachState extends State<ListDemandesCoach> {

  Future<String> getUid() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String uid =  prefs.getString('userId')??"";
    return uid;
  }

  Future<List<DemandeSalleItemModel>> getData() async{
    List<DemandeSalleItemModel> list = [];

    String uid = await getUid();

    FirebaseFirestore firestore = FirebaseFirestore.instance;


    QuerySnapshot<Map<String, dynamic>> data = await firestore.collection("Responsables").doc(uid).collection("demandes").where("role",isEqualTo: "coach").get();

    for (var element in data.docs) {
      list.add(DemandeSalleItemModel(fullname: element["fullname"], image: element["image"], uid: element["user"],coach: true));
    }


    return list;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<DemandeSalleItemModel>>(
      future: getData(),
      builder: (BuildContext context, AsyncSnapshot<List<DemandeSalleItemModel>> snapshot) {
        if(snapshot.connectionState == ConnectionState.done){
          return snapshot.data?.isEmpty??true? Center(child: Text("Aucun Demande"),):ListView.builder(
            itemCount: snapshot.data?.length??0,
            itemBuilder: (context,position)=>DemandeSalleItem(model: snapshot.data![position],ontap: (){
              setState(() {

              });
            },),);
        }
        return Center(child: CircularProgressIndicator(),);
      },

    );
  }
}
