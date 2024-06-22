import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sportapplication/coach/models/plan_model.dart';
import 'package:sportapplication/coach/models/plan_object.dart';

class AddPlanProvider extends ChangeNotifier{

  Future<List<PlanObject>> getData() async{

    List<PlanObject> list = [];

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String uid =  prefs.getString('userId')??"";
    QuerySnapshot<Map<String, dynamic>> data = await firebaseFirestore.collection("plan").where("coach",isEqualTo: uid).get();

    for (var element in data.docs) {
      list.add(
        PlanObject(name: element['name'], description: element['subtitle'], niveau: element['niveau'], categorie: element['categorie'], prix: element['prix'], image: element['image'],uid: element.id)
      );
    }

    return list;
  }

  Future<void> addData(PlanObject plan) async{
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String uid =  prefs.getString('userId')??"";

    String url = await uploadFile(plan.image);
    try{
    Map<String,String> data = {
      "coach":uid,
      "name":plan.name,
      "subtitle":plan.description,
      "prix":plan.prix,
      "categorie":plan.categorie,
      "niveau":plan.niveau,
      "image":url,
    };



    await firebaseFirestore.collection("plan").add(data);

    }catch(e){
      debugPrint("error ${e.toString()}");
    }


  }

  void update(){
    notifyListeners();
  }

  Future<String> uploadFile(String path) async{
    FirebaseStorage firebaseStorage = FirebaseStorage.instance;
    final ref = firebaseStorage.ref().child("upload/plan");

    TaskSnapshot taskSnapshot = await  ref.putFile(File(path)).whenComplete((){

    });
    String url = await taskSnapshot.ref.getDownloadURL();
    return url;
  }

}