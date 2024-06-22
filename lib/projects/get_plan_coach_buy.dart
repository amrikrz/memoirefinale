import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetPlanCoachBuy{

  Future<String> getUid() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String uid =  prefs.getString('userId')??"";

    return uid;
  }

  Future<List<PlanCoach2UserModel>> getData() async{
    
    List<PlanWithoutCoach> list = [];
    List<PlanCoach2UserModel> flist = [];
    List<String> planUids = [];
    List<String> coachUid = [];
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    String uid = await getUid();

    QuerySnapshot<Map<String,dynamic>> dat = await firestore.collection("plan").get();




    QuerySnapshot<Map<String,dynamic>> data =await firestore.collection("Sportifs").doc(uid).collection("plans").get();

    debugPrint("size : ${dat.docs.length} & ${data.docs.length}");

    if(data.docs.isNotEmpty && dat.docs.isNotEmpty){
    dat.docs.forEach((df){
        data.docs.forEach((element){
          if(!planUids.contains(element["planID"])&&!planUids.contains(df["planID"])){
            planUids.add(element["planID"]);
            list.add(PlanWithoutCoach(title: element["name"], subtitle: element["subtitle"], categorie: element["categorie"], niveau: element["niveau"], prix: element["prix"], planUid: element.id, coachUid: element["coach"],image: element["image"]));
            if(!coachUid.contains(df["coachID"])){
              coachUid.add(df["coachID"]);
            }
          }

        });
    });
    }else if(dat.docs.isNotEmpty && data.docs.isEmpty){
      dat.docs.forEach((element){

          planUids.add(element.id);
          list.add(PlanWithoutCoach(title: element["name"], subtitle: element["subtitle"], categorie: element["categorie"], niveau: element["niveau"], prix: element["prix"], planUid: element.id, coachUid: element["coach"],image: element["image"]));
          if(!coachUid.contains(element["coach"])){
            coachUid.add(element["coach"]);
          }

      });
    }





    if(list.isNotEmpty){
      QuerySnapshot<Map<String, dynamic>> d = await firestore.collection("Entraineurs").get();

      coachUid.forEach((r){
        debugPrint("uid ${r}");

      });

      d.docs.forEach((data){
        if(coachUid.contains(data['coachId'])){
          list.forEach((element){
            if(element.coachUid == data['coachId']){
              flist.add(PlanCoach2UserModel(title: element.title, subtitle: element.subtitle, categorie: element.categorie, niveau: element.niveau, prix: element.prix, profile: data["storeImage"], fullname: data["businessName"], planUid: element.planUid, coachUid: element.coachUid,image: element.image));
            }
            debugPrint("uid ${data['coachId']}");
          });
        }
      });




    }
    debugPrint("coach count : ${coachUid.length}");
    debugPrint("plan count : ${planUids.length}");

    return flist;
  }

}

class PlanWithoutCoach{
  String title,subtitle,categorie,niveau,prix,planUid,coachUid,image;
  PlanWithoutCoach(
       {required this.title,
        required this.subtitle,
        required this.categorie,
        required this.niveau,
        required this.prix,
        required this.planUid,
        required this.coachUid,
       required this.image});
}

class PlanCoach2UserModel{
  String title,subtitle,categorie,niveau,prix,profile,fullname,planUid,coachUid,image;

  PlanCoach2UserModel(
      {required this.title,
      required this.subtitle,
      required this.categorie,
      required this.niveau,
      required this.prix,
      required this.profile,
      required this.fullname,
      required this.planUid,
      required this.coachUid,
      required this.image});
}