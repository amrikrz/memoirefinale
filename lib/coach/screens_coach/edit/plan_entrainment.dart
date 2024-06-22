import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sportapplication/coach/controllers/add_plan_provider.dart';
import 'package:sportapplication/coach/models/plan_model.dart';
import 'package:sportapplication/coach/models/plan_object.dart';
import 'package:sportapplication/coach/screens_coach/edit/add_plan_entrainment.dart';

class PlanEntrainment extends StatefulWidget {
  const PlanEntrainment({Key? key}) : super(key: key);

  @override
  State<PlanEntrainment> createState() => _PlanEntrainmentState();
}

class _PlanEntrainmentState extends State<PlanEntrainment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Plan Entrainment", style: TextStyle(
            color: Colors.pinkAccent, fontWeight: FontWeight.w500),),
      ),
      body: Consumer<AddPlanProvider>(
        builder: (context, provider, child) {
          return FutureBuilder<List<PlanObject>>(
            future: provider.getData(),
            builder: (BuildContext context, AsyncSnapshot<List<PlanObject>> snapshot) {
              if(snapshot.hasData && snapshot.connectionState == ConnectionState.done){
                return snapshot.data!.isEmpty?
                    Center(child: Text("Aucun Plan Entrainment"),):
                    ListView.builder(
                        itemCount: snapshot.data?.length??0,
                        itemBuilder: (context,position){
                          return PlanModel(plan: snapshot.data![position],);
                        });
              }
              return Center(child: CircularProgressIndicator(),);
            },

          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
              CupertinoPageRoute(builder: (context) => AddPlanEntrainment()));
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.pinkAccent,
      ),
    );
  }
}
