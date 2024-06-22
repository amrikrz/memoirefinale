import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sportapplication/projects/salle_item_for_demande.dart';

import '../coach/models/exercice_object.dart';


class SalleCoachForDemande extends StatefulWidget {
  bool isDemanded;
  ExerciceObject salle;
  SalleCoachForDemande({Key? key,this.isDemanded = false,required this.salle}) : super(key: key);

  @override
  State<SalleCoachForDemande> createState() => _SalleItemForDemandeState();
}

class _SalleItemForDemandeState extends State<SalleCoachForDemande> {

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<String> getUid() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String uid =  prefs.getString('userId')??"";

    return uid;
  }

  String idc = "";
  String ids = "";
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        height: 70,
        width: 70,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          image: DecorationImage(image: NetworkImage(widget.salle.image))
        ),
      ),
      title: Text(widget.salle.name,),
      trailing: !widget.isDemanded?IconButton(onPressed: () async{
        String uid = await getUid();
        Map<String,dynamic> data = {
          "status":"wait",
          "fullname":widget.salle.name,
          "profileImage":widget.salle.image,
          "salleID":widget.salle.uid
        };
        await firestore.collection("Entraineurs").doc(uid).collection("demandes").add(data).then((value){
          idc = value.id;
        });
        DocumentSnapshot<Map<String, dynamic>> d = await firestore.collection("Entraineurs").doc(uid).get();

        Map<String,dynamic> dc = d.data()?? {};
        Map<String,dynamic> to = {
          "user":uid,
          "role":"coach",
          "fullname":dc["businessName"],
          "image":dc['storeImage']
        };

        await firestore.collection("Responsables").doc(widget.salle.uid).collection("demandes").add(to).then((value){
          ids = value.id;
        });

        setState(() {
          widget.isDemanded = !widget.isDemanded;
        });

      }, icon: const Icon(Icons.add)):IconButton(onPressed: () async{
        String uid = await getUid();

        await firestore.collection("Entraineurs").doc(uid).collection("demandes").where("salleID",isEqualTo: widget.salle.uid).get().then((value) async{
          await value.docs.first.reference.delete();
        });
        await firestore.collection("Responsables").doc(widget.salle.uid).collection("demandes").where("user",isEqualTo: uid).where("role",isEqualTo: "coach").get().then((value) async{
          await value.docs.first.reference.delete();
        });


        setState(() {
          widget.isDemanded = !widget.isDemanded;
        });
      }, icon:const Icon(Icons.close,color: Colors.redAccent,)),
    );
  }
}
