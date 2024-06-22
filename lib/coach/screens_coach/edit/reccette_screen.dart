import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sportapplication/coach/controllers/add_plan_reccette_provider.dart';
import 'package:sportapplication/coach/models/reccete_plan_object.dart';
import 'package:sportapplication/coach/screens_coach/edit/add_plan_reccette_screen.dart';
import 'package:sportapplication/coach/screens_coach/edit/recipes_plan_item.dart';
import 'package:sportapplication/coach/screens_coach/edit/recipes_plan_item_widget.dart';
import 'package:sportapplication/screens_client/alimentation/recipes_item.dart';
import 'package:sportapplication/screens_client/alimentation/recipe_details.dart';
import 'package:sportapplication/screens_client/alimentation/recipes_item.dart';
import 'package:sportapplication/screens_client/alimentation/alimentation_client.dart';

class ReccetteScreen extends StatefulWidget {
  String planUid;
  bool coach;
   ReccetteScreen({Key? key,required this.planUid,this.coach=true}) : super(key: key);

  @override
  State<ReccetteScreen> createState() => _ReccetteScreenState();
}

class _ReccetteScreenState extends State<ReccetteScreen> with AutomaticKeepAliveClientMixin{



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AddPlanReccetteProvider>(
        builder: (context, provider, child) {
          return FutureBuilder<List<ReccetePlanObject>>(
            future: provider.getData(widget.planUid),
            builder: (BuildContext context, AsyncSnapshot<List<ReccetePlanObject>> snapshot) {
              if(snapshot.hasData && snapshot.connectionState == ConnectionState.done){
                return snapshot.data!.isEmpty?
                Center(child: Text("Aucun Plan Reccete"),):
                ListView.builder(
                    itemCount: snapshot.data?.length??0,
                    itemBuilder: (context,position){
                      return RecipesPlanItemWidget(recipe: snapshot.data![position],coach: widget.coach,);
                    });
              }
              return Center(child: CircularProgressIndicator(),);
            },

          );
        },
      ),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButton: Visibility(
        visible: widget.coach,
        child: FloatingActionButton(
          onPressed: (){
            Navigator.push(context, CupertinoPageRoute(builder: (context)=>AddPlanReccetteScreen(planUid: widget.planUid)));
          },
          backgroundColor: Colors.pinkAccent,
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
