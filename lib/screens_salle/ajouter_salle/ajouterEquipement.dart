import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sportapplication/coach/models/sportifs_item_model.dart';

import '../../coach/models/coach_item_model.dart';
import '../../coach/models/exercice_object.dart';

class ResponsableAjouterEquipement extends StatelessWidget {
  const ResponsableAjouterEquipement({super.key});

  Future<String> getUid() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String uid =  prefs.getString('userId')??"";
    return uid;
  }
  
  Future<List<ExerciceObject>> getData() async{
    List<ExerciceObject> list = [];
    String salleuid = await getUid();
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    QuerySnapshot<Map<String,dynamic>> data  = await firestore.collection("Members").where("salleID",isEqualTo: salleuid).where("role",isEqualTo: "sportif").get();
    debugPrint("total sportif : ${data.docs.length}");
    for (var element in data.docs) {
      debugPrint("sportif : ${element["user"]}");

      try {
        DocumentSnapshot<Map<String, dynamic>> d = await firestore.collection("Sportifs").doc(element["user"]).get();
        list.add(ExerciceObject(name: d.get("fullname"), subtitle: "", image: d.get("profileImage"), uid: d.id, pereUid: ""));

      }catch(e){
        debugPrint("error list : $e");
      }

    }
    debugPrint("sportif list : ${list.length}");

    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<ExerciceObject>>(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot<List<ExerciceObject>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          return snapshot.data?.isEmpty??true?Center(child: Text("Aucun Sportif"),):ListView.builder(
              itemCount: snapshot.data?.length??0,
              itemBuilder: (context,position)=>SportifsItemModel(exerciceObject:snapshot.data![position] )
          );
        },
      ),

    );
  }
}