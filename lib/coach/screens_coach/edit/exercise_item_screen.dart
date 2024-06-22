import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sportapplication/coach/controllers/add_exercice_provider.dart';
import 'package:sportapplication/coach/models/exercice_item_list.dart';
import 'package:sportapplication/coach/models/exercice_object.dart';
import 'package:sportapplication/coach/models/exercise_model.dart';

import 'add_exercise_screen.dart';

class ExerciseItemScreen extends StatefulWidget {
  String planUid,exerciceUid;
  bool coach;
  ExerciseItemScreen({Key? key,required this.planUid,required this.exerciceUid,this.coach = true}) : super(key: key);

  @override
  State<ExerciseItemScreen> createState() => _ExerciseItemScreenState();
}

class _ExerciseItemScreenState extends State<ExerciseItemScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Plan Exercice", style: TextStyle(
              color: Colors.pinkAccent, fontWeight: FontWeight.w500),),
        ),
        body: Consumer<AddExerciceProvider>(
          builder: (context, provider, child) {
            return FutureBuilder<List<ExerciceObject>>(
              future: provider.data(widget.planUid,widget.exerciceUid),
              builder: (BuildContext context, AsyncSnapshot<List<ExerciceObject>> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return snapshot.data?.length == 0 ?
                  const Center(child: Text("Aucun Exercice "),):
                  ListView.builder(
                    itemCount: snapshot.data?.length??0,
                    itemBuilder: (BuildContext context, int index) {
                      return ExerciceItemList(exerciceObject: snapshot.data![index],coach: widget.coach,);
                    },

                  );
                }
                return CircularProgressIndicator();
              },

            );
          },
        ),
        floatingActionButton: Visibility(
          visible: widget.coach,
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(context,
                  CupertinoPageRoute(builder: (context) => AddExerciseScreen(planUid:widget.planUid,exerciceUid:widget.exerciceUid)));
            },
            child: Icon(Icons.add),
            backgroundColor: Colors.pinkAccent,
          ),
        )
    );
  }
}
