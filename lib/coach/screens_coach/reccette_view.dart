import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sportapplication/coach/models/exercice_object.dart';
import 'package:video_player/video_player.dart';

import '../models/input_model.dart';

class ReccetteView extends StatefulWidget {
  String link,title,desc,reccette,calories,duration;
  ReccetteView({Key? key,required this.link,required this.title,required this.desc,required this.reccette,required this.duration,required this.calories}) : super(key: key);

  @override
  State<ReccetteView> createState() => _ExerciceViewState();
}

class _ExerciceViewState extends State<ReccetteView> {



  @override
  void initState() {
    // TODO: implement initState
    title_controller.text = widget.title;
    desc_controller.text = widget.desc;
    calorie.text = widget.calories;
    duration.text = widget.duration;
    reccete.text = widget.reccette;
    super.initState();

  }

  TextEditingController title_controller = TextEditingController();
  TextEditingController desc_controller = TextEditingController();
  TextEditingController calorie = TextEditingController();
  TextEditingController duration = TextEditingController();
  TextEditingController reccete = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Reccete Vue"),),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.sizeOf(context).height*0.5,
              decoration: BoxDecoration(
                image: DecorationImage(image: NetworkImage(widget.link),fit: BoxFit.cover)
              ),
              ),

            InputModel(c: title_controller, hint: "Title", icon: Icons.mail,ontap: (){},),
            InputModel(c: desc_controller, hint: "Description", icon: Icons.mail,ontap: (){},),
            InputModel(c: calorie, hint: "Description", icon: Icons.mail,ontap: (){},),
            InputModel(c: duration, hint: "Description", icon: Icons.mail,ontap: (){},),
            InputModel(c: reccete, hint: "Description", icon: Icons.mail,ontap: (){},),

          ],
        ),
      ),
    );
  }
}
