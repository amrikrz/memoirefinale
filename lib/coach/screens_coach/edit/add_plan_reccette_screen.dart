import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sportapplication/coach/controllers/add_plan_reccette_provider.dart';
import 'package:sportapplication/coach/models/exercice_object.dart';
import 'package:video_player/video_player.dart';

import '../../controllers/add_plan_exercice_provider.dart';
import '../../models/input_model.dart';

class AddPlanReccetteScreen extends StatefulWidget {
  String planUid;
  AddPlanReccetteScreen({Key? key,required this.planUid}) : super(key: key);

  @override
  State<AddPlanReccetteScreen> createState() => _AddPlanExercise();
}

class _AddPlanExercise extends State<AddPlanReccetteScreen>{

  TextEditingController nom_controller=TextEditingController(),desc_controller=TextEditingController();

  File? media;
  final ImagePicker _picker = ImagePicker();
  bool _isVideo = false;
  VideoPlayerController? _videoPlayerController;

  void pick(BuildContext context){
    showDialog(context: context, builder: (context)=>AlertDialog(

      actions: [
        TextButton(onPressed: (){Navigator.pop(context);}, child: Text("ANULLER",style: TextStyle(color: Colors.black),))
      ],
      title: Text("Choiser Image"),
      content:Container(
        height: 99,
        padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
        alignment: Alignment.bottomCenter,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                IconButton(icon:Icon(Icons.video_collection,size: 40,color: Colors.green,),onPressed: (){
                  Navigator.of(context).pop();
                  pickvideoFromGallery();
                },),
                Text("Galerie")
              ],
            ),
            Column(
              children: [
                IconButton(icon:Icon(Icons.camera_alt,size: 40,color: Colors.green,),onPressed: (){
                  Navigator.of(context).pop();
                  pickvideoFromCamera();
                }),
                Text("Camera")
              ],
            )
          ],
        ),
      ),

    ));
  }


  void pickvideoFromCamera() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    if (photo == null) return;
    setState(() {
      media = File(photo.path);
      _isVideo = true;
    });

  }

  void pickvideoFromGallery() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.gallery);
    if (photo == null) return;
    media = File(photo.path);
    setState(() {
      _isVideo = true;
    });
  }

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Ajouter Plan Reccettes",style: TextStyle(color: Colors.pinkAccent,fontWeight: FontWeight.w500),),),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width*0.9,
            height: MediaQuery.of(context).size.width*0.4,
            margin: EdgeInsets.only(bottom: 15),
            decoration: BoxDecoration(
                color: _isVideo?Colors.transparent:Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8)
            ),
            child: IconButton(
              style: ButtonStyle(
                shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              onPressed: (){
                pick(context);
              },
              icon: ClipRRect(borderRadius: BorderRadius.circular(8),child: _isVideo && media != null?Image.file(media!):Icon(Icons.image,color: Colors.black54,size: MediaQuery.of(context).size.height*0.1,)),
            ),
          ),
          InputModel(c: nom_controller, hint: "Nom de plan d'Reccette", icon: Icons.abc),
          InputModel(c: desc_controller, hint: "Description", icon: Icons.wb_iridescent_rounded),
          SizedBox(height: 15,),
          ElevatedButton(onPressed: () async{
            showDialog(
              context: context,
              barrierDismissible: false, // Disable user dismissal
              builder: (BuildContext context) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            );
            await Provider.of<AddPlanReccetteProvider>(context,listen: false).addData(ExerciceObject(name: nom_controller.text, subtitle: desc_controller.text, image: media!.path, uid: "", pereUid: widget.planUid),);
            Navigator.pop(context);
            Navigator.pop(context);
          }, child: Text('Ajouter',style: TextStyle(color: Colors.white,fontSize: 19),),
            style: ButtonStyle(
                minimumSize: WidgetStateProperty.all<Size>(Size(MediaQuery.of(context).size.width*0.95,MediaQuery.of(context).size.height*0.07)),
                shape: WidgetStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))),
                backgroundColor: WidgetStateProperty.all<Color>(Colors.pinkAccent)
            ),)
        ],
      ),
    );
  }






}




