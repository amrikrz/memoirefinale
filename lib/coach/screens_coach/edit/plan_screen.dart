import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sportapplication/coach/controllers/add_plan_exercice_provider.dart';
import 'package:sportapplication/coach/models/exercice_object.dart';
import 'package:sportapplication/coach/models/exercise_model.dart';
import 'package:sportapplication/coach/models/plan_model.dart';
import 'package:sportapplication/coach/screens_coach/edit/add_exercise_screen.dart';

class PlanScreen extends StatefulWidget {
  String planUid,exerciceUid;
  PlanScreen({Key? key,required this.planUid,required this.exerciceUid}) : super(key: key);

  @override
  State<PlanScreen> createState() => _PlanScreenState();
}

/** plan exercise **/

class _PlanScreenState extends State<PlanScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AddPlanExerciceProvider>(
        builder: (context, provider, child) {
          return FutureBuilder<List<ExerciceObject>>(
            future: provider.getData(""),
            builder: (BuildContext context, AsyncSnapshot<List<ExerciceObject>> snapshot) {
              if(snapshot.hasData && snapshot.connectionState == ConnectionState.done){
                return snapshot.data!.isEmpty?
                const Center(child: Text("Aucun Plan Entrainment"),):
                ListView.builder(
                    itemCount: snapshot.data?.length??0,
                    itemBuilder: (context,position){
                      return ExerciseModel(exerciceObject: snapshot.data![position],);
                    });
              }
              return const Center(child: CircularProgressIndicator(),);
            },

          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, CupertinoPageRoute(builder: (context)=>AddExerciseScreen(planUid: widget.planUid,exerciceUid: widget.exerciceUid,)));
        },
        child:Icon(Icons.add),
        backgroundColor: Colors.pinkAccent,
      ),
    );
  }
}
