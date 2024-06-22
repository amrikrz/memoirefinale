import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sportapplication/projects/get_plan_coach_buy.dart';
import 'package:sportapplication/screens_client/programe_item.dart';

class PlanBuyed extends StatefulWidget {
  const PlanBuyed({Key? key}) : super(key: key);

  @override
  State<PlanBuyed> createState() => _PlanBuyedState();
}

class _PlanBuyedState extends State<PlanBuyed> {

  List<PlanCoach2UserModel> checkouts = [];

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<String> getUid() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String uid =  prefs.getString('userId')??"";

    return uid;
  }

  Future<List<PlanCoach2UserModel>> getData() async{
    String uid = await getUid();
    QuerySnapshot<Map<String,dynamic>> dato = await firestore.collection("Sportifs").doc(uid).collection("plans").get();

    dato.docs.forEach((data){
      PlanCoach2UserModel model = PlanCoach2UserModel(title: data["name"], subtitle: data["subtitle"], categorie: data["categorie"], niveau: data["niveau"], prix:  data["prix"], profile: data["profile"], fullname: data["fullname"], planUid: data["planID"], coachUid:   data["coachID"], image:data["image"]);
      checkouts.add(model);
    });


    return checkouts;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<PlanCoach2UserModel>>(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot<List<PlanCoach2UserModel>> snapshot) {
          if(snapshot.connectionState == ConnectionState.done){
            return snapshot.data?.isEmpty??true?Center(child: Text("Aucun Plans")):
                ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context,position)=>ProgrameItem(plan: snapshot.data![position],showIcon: false,));
          }
          return Center(child: CircularProgressIndicator(),);
      },

       );
  }
}
