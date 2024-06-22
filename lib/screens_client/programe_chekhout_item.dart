import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sportapplication/coach/screens_coach/edit/plan_screen.dart';
import 'package:sportapplication/projects/get_plan_coach_buy.dart';
import 'package:sportapplication/screens_client/checkout_screen.dart';


class ProgrameChekhoutItem extends StatelessWidget {
  PlanCoach2UserModel plan;
  VoidCallback ontap;
  ProgrameChekhoutItem({Key? key,required this.plan,required this.ontap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.grey.shade100
      ),
      child: Column(
        children: [

          ListTile(
              contentPadding: EdgeInsets.only(bottom: 10,top: 10,left: 10),
              trailing: IconButton(icon: Icon(Icons.delete_forever,color: Colors.redAccent,),onPressed: (){
                ontap();
              },),
              leading: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey.shade100,
                    image: DecorationImage(image: NetworkImage(plan.profile),fit: BoxFit.cover)
                ),
              ),
              title: Text(plan.fullname,style: GoogleFonts.acme(letterSpacing: 1,color: Colors.black),),
            ),
          Container(
            color: Colors.pinkAccent.shade100.withOpacity(0.5),
            child: ListTile(
              contentPadding: EdgeInsets.only(left: 30),
              onTap: (){},
              leading: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey.shade100,
                    image: DecorationImage(image: NetworkImage(plan.image),fit: BoxFit.cover)
                ),
              ),
              title:  Text(plan.title,style: GoogleFonts.acme(letterSpacing: 1,color: Colors.black),),
              subtitle: Text(plan.subtitle),

            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 15),
            decoration: BoxDecoration(
              color: Colors.pinkAccent.shade100.withOpacity(0.5),
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12),bottomRight: Radius.circular(12))
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('Categorie : ${plan.categorie}',style: GoogleFonts.acme(letterSpacing: 1,color: Colors.black),),
                Text('Niveaux : ${plan.niveau}',style: GoogleFonts.acme(letterSpacing: 1,color: Colors.purple),),
                Text('Prix : ${plan.prix}DA',style: GoogleFonts.acme(letterSpacing: 1,color: Colors.green),),
              ],
            ),
          )

        ],
      ),
    );
  }
}
