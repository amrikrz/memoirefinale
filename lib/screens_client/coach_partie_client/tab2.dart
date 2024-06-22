import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sportapplication/coach/models/coach_item_model.dart';
import 'package:sportapplication/coach/models/exercice_object.dart';
import 'package:sportapplication/screens_client/homePage/dernieeArrivee/entrainneur/dernieeArriveeEntraineur_controller.dart';

class SportifCoteCoach extends StatefulWidget {
  const SportifCoteCoach({Key? key}) : super(key: key);

  @override
  _SportifCoteCoachState createState() => _SportifCoteCoachState();
}

class _SportifCoteCoachState extends State<SportifCoteCoach> {
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  Future<String> getUid() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String uid =  prefs.getString('userId')??"";

    return uid;
  }

  Future<List<ExerciceObject>> getData() async{

    List<ExerciceObject> list = [];

    FirebaseFirestore firestore = FirebaseFirestore.instance;
    String uid = await getUid();
    final query = await firestore.collection("Sportifs").doc(uid).collection("coachs").get();

    query.docs.forEach((element){
      list.add(ExerciceObject(name: element["fullname"], subtitle: "", image: element["profile"], uid: element["coachID"], pereUid: '',));
    });

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

          return snapshot.data?.isEmpty??true?Center(child: Text("Aucun Coach"),):ListView.builder(
              itemCount: snapshot.data?.length??0,
              itemBuilder: (context,position)=>CoachItemModel(exerciceObject:snapshot.data![position] )
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
