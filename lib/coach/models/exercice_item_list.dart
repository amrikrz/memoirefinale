import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sportapplication/coach/models/exercice_object.dart';
import 'package:sportapplication/coach/screens_coach/edit/exercise_item_screen.dart';
import 'package:sportapplication/coach/screens_coach/edit/exercise_screen.dart';
import 'package:sportapplication/coach/screens_coach/edit/plan_screen.dart';
import 'package:sportapplication/coach/screens_coach/exercice_view.dart';

import '../screens_coach/edit/edit_things_screen.dart';

class ExerciceItemList extends StatelessWidget {

  ExerciceObject exerciceObject;
  bool coach;
  ExerciceItemList({super.key,required this.exerciceObject,this.coach = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:const EdgeInsets.all(5),
      padding:const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.grey.shade100
      ),
      child: Column(
        children: [
          ListTile(
            onTap: (){
              Navigator.of(context).push(CupertinoPageRoute(builder: (context)=>ExerciceView(link: exerciceObject.image,title: exerciceObject.name,desc: exerciceObject.subtitle,)));
            },
            leading: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey.shade100,
              ),
            ),
            title:  Text(exerciceObject.name,style: GoogleFonts.acme(letterSpacing: 1,color: Colors.black),),
            subtitle: Text(exerciceObject.subtitle),
            trailing: const Icon(Icons.more_vert_rounded),

          ),

        ],
      ),
    );
  }
}
