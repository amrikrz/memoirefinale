import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sportapplication/coach/models/plan_model.dart';
import 'package:sportapplication/projects/get_plan_coach_buy.dart';
import 'package:sportapplication/screens_client/alimentation/recipe_details.dart';
import 'package:sportapplication/screens_client/alimentation/recipes_item.dart';
import 'package:sportapplication/screens_client/programe_item.dart';
import 'package:sportapplication/shared/colors.dart';

import '../checkout_screen.dart';

class ClientAliment extends StatefulWidget {
  const ClientAliment({Key? key}) : super(key: key);

  @override
  State<ClientAliment> createState() => _ClientAlimentState();
}

class _ClientAlimentState extends State<ClientAliment> {

  GetPlanCoachBuy getPlanCoachBuy = GetPlanCoachBuy();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(onPressed: (){
            Navigator.of(context).push(CupertinoPageRoute(builder: (context)=>CheckoutScreen()));
          }, icon: Icon(Icons.shopping_cart_outlined,color: Colors.pinkAccent,))
        ],
        title: Text("Plan Entrainment",style: TextStyle(color: Colors.pinkAccent,fontWeight: FontWeight.w500)),),
      body: FutureBuilder<List<PlanCoach2UserModel>>(
        future: getPlanCoachBuy.getData(),
        builder: (BuildContext context, AsyncSnapshot<List<PlanCoach2UserModel>> snapshot) {
          if(snapshot.connectionState == ConnectionState.done){
            return snapshot.data?.isEmpty??true?Center(child: Text("Aucun Plan"),):
                ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context,position)=>ProgrameItem(plan: snapshot.data![position]
                    ));
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },


      ),
    );
  }
}

