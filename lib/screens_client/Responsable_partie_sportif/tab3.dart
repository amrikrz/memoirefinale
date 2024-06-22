import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sportapplication/coach/models/exercice_object.dart';
import 'package:sportapplication/projects/demande_salle_client.dart';
import 'package:sportapplication/projects/salle_item_model.dart';
import 'package:sportapplication/screens_client/homePage/dernieeArrivee/Responsable/dernieeArriveeResponsable_controller.dart';

class SportifCoteResponsable extends StatefulWidget {
  const SportifCoteResponsable({Key? key}) : super(key: key);

  @override
  _SportifCoteResponsableState createState() => _SportifCoteResponsableState();
}

class _SportifCoteResponsableState extends State<SportifCoteResponsable> {
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
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    List<ExerciceObject> list = [];
    String uid = await getUid();
    QuerySnapshot<Map<String,dynamic>> data = await firestore.collection("Members").where('userID',isEqualTo: uid).where("role",isEqualTo: "user").get();
    data.docs.forEach((element){
      list.add(ExerciceObject(name: element["name"], subtitle: "", image: element["image"], uid: element.id, pereUid: ""));
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
          return snapshot.data?.isEmpty??true?Center(child: Text("Aucun Salle"),):ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context,position)=>SalleItemModel(exerciceObject: snapshot.data![position])
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pinkAccent,
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.of(context).push(CupertinoPageRoute(builder: (context)=>DemandeSalleClient()));
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
