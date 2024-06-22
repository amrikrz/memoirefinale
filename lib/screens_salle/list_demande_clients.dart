import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sportapplication/screens_salle/ajouter_salle/demande_salle_item.dart';

class ListDemandeClients extends StatefulWidget {
  const ListDemandeClients({Key? key}) : super(key: key);

  @override
  State<ListDemandeClients> createState() => _ListDemandeClientsState();
}

class _ListDemandeClientsState extends State<ListDemandeClients> {

  Future<String> getUid() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String uid =  prefs.getString('userId')??"";
    return uid;
  }

  Future<List<DemandeSalleItemModel>> getData() async{
    List<DemandeSalleItemModel> list = [];
    
    String uid = await getUid();
    
    FirebaseFirestore firestore = FirebaseFirestore.instance;


    QuerySnapshot<Map<String, dynamic>> data = await firestore.collection("Responsables").doc(uid).collection("demandes").where("role",isEqualTo: "sportif").get();

    for (var element in data.docs) {
      list.add(DemandeSalleItemModel(fullname: element["fullname"], image: element["image"], uid: element["user"],coach: false));
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

class DemandeSalleItemModel{
  String fullname,image,uid;
  bool coach;

  DemandeSalleItemModel({required this.fullname,required this.image,required this.uid,required this.coach});
}
