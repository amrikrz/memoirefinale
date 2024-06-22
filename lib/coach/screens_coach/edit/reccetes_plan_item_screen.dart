import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sportapplication/coach/controllers/add_reccette_provider.dart';
import 'package:sportapplication/coach/screens_coach/edit/add_reccette_screen.dart';
import 'package:sportapplication/coach/screens_coach/edit/recipes_plan_item.dart';
import 'package:sportapplication/screens_client/alimentation/recipe_details.dart';
import 'package:sportapplication/screens_client/alimentation/recipes_item.dart';

class ReccetesPlanItemScreen extends StatefulWidget {
  String planUid,reccetteUid;
  bool coach;
  ReccetesPlanItemScreen({Key? key,required this.planUid,required this.reccetteUid,this.coach=true}) : super(key: key);

  @override
  State<ReccetesPlanItemScreen> createState() => _ReccetesPlanItemScreenState();
}

class _ReccetesPlanItemScreenState extends State<ReccetesPlanItemScreen> {




  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Plan Reccettes",style: TextStyle(color: Colors.pinkAccent,fontWeight: FontWeight.w500),),
        ),
        body: Consumer<AddReccetteProvider>(
          builder: (context, provider, child) {
            return FutureBuilder<List<RecipeModel>>(
              future: provider.getData(widget.planUid,widget.reccetteUid),
              builder: (BuildContext context, AsyncSnapshot<List<RecipeModel>> snapshot) {
                if(snapshot.connectionState == ConnectionState.done){
                  int size = snapshot.data?.length ?? 0;
                  debugPrint("size in reccette : $size");
                  return snapshot.data?.isEmpty??true?
                  Center(child: Text("Aucun Plan Reccettes"),):
                  ListView.builder(
                      itemCount: snapshot.data?.length??0,
                      itemBuilder: (context,position){
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: RecipesPlanItem(recipe: snapshot.data![position],),
                        );
                      });
                }
                return Center(child: CircularProgressIndicator(),);
              },

            );
          },
        ),
        floatingActionButton: Visibility(
          visible: widget.coach,
          child: FloatingActionButton(
            onPressed: (){
              Navigator.push(context, CupertinoPageRoute(builder: (context)=>AddReccetteScreen(planUid: widget.planUid,reccetteUid: widget.reccetteUid,)));
            },
            child:Icon(Icons.add),
            backgroundColor: Colors.pinkAccent,
          ),
        )
    );
  }
}
