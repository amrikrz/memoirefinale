import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:sportapplication/coach/models/exercice_object.dart';

import '../../screens_client/alimentation/recipe_details.dart';
import '../models/reccete_plan_object.dart';

class AddPlanReccetteProvider extends ChangeNotifier{

  Future<List<ReccetePlanObject>> getData(String planUid) async{
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    List<ReccetePlanObject> list = [];

    QuerySnapshot<Map<String, dynamic>> snapshot = await firebaseFirestore.collection("plan").doc(planUid).collection("planReccete").get();

    debugPrint("data size ${snapshot.docs.length}");
    debugPrint("plan uid ${snapshot.docs.length}");

    snapshot.docs.forEach((element){
      list.add(
          ReccetePlanObject(title: element["name"], subtitle: element["subtitle"], image: element["image"], pereUid: planUid,uid: element.id)
      );
    });

    return list;


  }

  Future<void> addData(ExerciceObject exercice) async{
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    String url = await uploadFile(exercice.image);

    Map<String,String> data = {
      "name":exercice.name,
      "subtitle":exercice.subtitle,
      "image":url,
    };

    await firebaseFirestore.collection("plan").doc(exercice.pereUid).collection("planReccete").add(data);

    notifyListeners();
  }

  Future<String> uploadFile(String path) async{
    FirebaseStorage firebaseStorage = FirebaseStorage.instance;
    final ref = firebaseStorage.ref().child("upload/ExercicePlan");

    TaskSnapshot taskSnapshot = await  ref.putFile(File(path)).whenComplete((){

    });
    String url = await taskSnapshot.ref.getDownloadURL();
    return url;
  }


}