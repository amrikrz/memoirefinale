import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sportapplication/coach/models/plan_object.dart';
import 'package:sportapplication/coach/screens_coach/edit/plan_entrainment.dart';
import 'package:sportapplication/coach/screens_coach/edit/plan_screen.dart';

import '../screens_coach/edit/edit_things_screen.dart';

class PlanModel extends StatelessWidget {
  PlanObject plan;
  PlanModel({Key? key,required this.plan}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey.shade100
      ),
      child: Column(
        children: [
          ListTile(
            onTap: (){
              Navigator.of(context).push(CupertinoPageRoute(builder: (context)=>EditProductScreen(planUid: plan.uid,)));
            },
            leading: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey.shade100,
                image: DecorationImage(image: NetworkImage(plan.image),fit: BoxFit.cover)
              ),
            ),
            title:  Text(plan.name,style: GoogleFonts.acme(letterSpacing: 1,color: Colors.black),),
            subtitle: Text(plan.description),
            trailing: Icon(Icons.more_vert_rounded),
      
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('Categorie : ${plan.categorie}',style: GoogleFonts.acme(letterSpacing: 1,color: Colors.black),),
              Text('Niveaux : ${plan.niveau}',style: GoogleFonts.acme(letterSpacing: 1,color: Colors.purple),),
              Text('Prix : ${plan.prix}',style: GoogleFonts.acme(letterSpacing: 1,color: Colors.green),),
            ],
          )
      
        ],
      ),
    );
  }
}
