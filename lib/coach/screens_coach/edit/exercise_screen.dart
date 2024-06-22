import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sportapplication/coach/controllers/add_plan_exercice_provider.dart';
import 'package:sportapplication/coach/models/exercice_object.dart';
import 'package:sportapplication/coach/models/exercise_model.dart';
import 'package:sportapplication/coach/screens_coach/edit/add_plan_exercise.dart';

import 'add_exercise_screen.dart';

class ExerciseScreen extends StatefulWidget {
  String planUid;
  bool coach;
   ExerciseScreen({Key? key,required this.planUid,this.coach=true}) : super(key: key);

  @override
  State<ExerciseScreen> createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AddPlanExerciceProvider>(
        builder: (context, provider, child) {
          return FutureBuilder<List<ExerciceObject>>(
            future: provider.getData(widget.planUid),
            builder: (BuildContext context, AsyncSnapshot<List<ExerciceObject>> snapshot) {
              if(snapshot.hasData && snapshot.connectionState == ConnectionState.done){
                return snapshot.data!.isEmpty?
                const Center(child: Text("Aucun Plan Exercice"),):
                ListView.builder(
                    itemCount: snapshot.data?.length??0,
                    itemBuilder: (context,position){
                      return ExerciseModel(exerciceObject: snapshot.data![position],coach: widget.coach,);
                    });
              }
              return const Center(child: CircularProgressIndicator(),);
            },

          );
        },
      ),
      floatingActionButton:Visibility(
        visible: widget.coach,
        child: FloatingActionButton(
          onPressed: (){
        Navigator.push(context, CupertinoPageRoute(builder: (context)=>AddPlanExercise(planUid: widget.planUid,)));
            },
            backgroundColor: Colors.pinkAccent,
            child: const Icon(Icons.add),
            ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
