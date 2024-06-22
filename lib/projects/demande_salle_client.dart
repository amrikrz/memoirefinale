
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sportapplication/coach/models/exercice_object.dart';
import 'package:sportapplication/projects/salle_item_for_demande.dart';

class DemandeSalleClient extends StatefulWidget {
  const DemandeSalleClient({Key? key}) : super(key: key);

  @override
  State<DemandeSalleClient> createState() => _DemandeSalleClientState();
}

class _DemandeSalleClientState extends State<DemandeSalleClient> {

  Future<String> getUid() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String uid =  prefs.getString('userId')??"";

    return uid;
  }

  Future<List<ExerciceObject>> getData() async{
    List<ExerciceObject> list = [];
    List<String> salleuids = [];
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    String uid = await getUid();
    try {
      QuerySnapshot<Map<String, dynamic>> data = await firestore.collection(
          "Responsables").get();
      QuerySnapshot<Map<String, dynamic>> seconddata = await firestore
          .collection("Sportifs").doc(uid).collection("demandes").get();


      seconddata.docs.forEach((demandes) {
        if (!salleuids.contains(demandes["salleID"])) {
          debugPrint("here add");
          list.add(ExerciceObject(name: demandes["fullname"],
              subtitle: '',
              image: demandes["profileImage"],
              uid: demandes["salleID"],
              pereUid: demandes["status"]));
          salleuids.add(demandes["salleID"]);
        }
      });
      data.docs.forEach((salle) {
        if (!salleuids.contains(salle.id)) {
          list.add(ExerciceObject(name: salle["fullname"],
              subtitle: '',
              image: salle["profileImage"],
              uid: salle.id,
              pereUid: "none"));
          salleuids.add(salle.id);
        }
      });
    }catch(e){

    }




    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Demande Salle"),
      ),
      body: FutureBuilder<List<ExerciceObject>>(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot<List<ExerciceObject>> snapshot) {
          if(snapshot.connectionState == ConnectionState.done){
            
            return snapshot.data?.isEmpty??true?Center(child: Text("Aucun Salle"),):
            ListView.builder(
                itemCount: snapshot.data?.length??0,
                itemBuilder: (context,position)=>SalleItemForDemande(salle: snapshot.data![position],isDemanded: snapshot.data![position].pereUid=="wait",)
            );
          }
          return const Center(child: CircularProgressIndicator(),);
        },

      ),
    );
  }
}
