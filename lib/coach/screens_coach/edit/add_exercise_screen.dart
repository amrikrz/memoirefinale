import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sportapplication/coach/controllers/add_exercice_provider.dart';
import 'package:video_player/video_player.dart';

import '../../models/exercice_object.dart';
import '../../models/input_model.dart';

class AddExerciseScreen extends StatefulWidget {
  String planUid,exerciceUid;
  AddExerciseScreen({Key? key,required this.planUid,required this.exerciceUid}) : super(key: key);

  @override
  State<AddExerciseScreen> createState() => _AddExerciseScreenState();
}

class _AddExerciseScreenState extends State<AddExerciseScreen> {

  TextEditingController nom_controller=TextEditingController(),desc_controller=TextEditingController();

  File? media;
  final ImagePicker _picker = ImagePicker();
  bool _isVideo = false;
  VideoPlayerController? _videoPlayerController;

  void pickvideoFromCamera() async {
    final XFile? photo = await _picker.pickVideo(source: ImageSource.camera);
    if (photo == null) return;
    setState(() {
      media = File(photo.path);
      _isVideo = true;
    });
    _videoPlayerController = VideoPlayerController.file(media!);
    try {
      await _videoPlayerController!.initialize();
      _videoPlayerController!.setLooping(true);
      _videoPlayerController!.play();
      _videoPlayerController!.setVolume(0.0);
    } catch (e) {
      print("Error initializing video : $e");
    }
  }

  void pickvideoFromGallery() async {
    final XFile? photo = await _picker.pickVideo(source: ImageSource.gallery);
    if (photo == null) return;
      media = File(photo.path);
    _videoPlayerController =  VideoPlayerController.file(media!);
     _videoPlayerController!.initialize().then((data){
       _videoPlayerController!.setLooping(true);
       _videoPlayerController!.play();
       setState(() {
         _isVideo = true;
       });
    });


  }

  void pick(){
    showDialog(context: context, builder: (context)=>AlertDialog(

      actions: [
        TextButton(onPressed: (){Navigator.pop(context);}, child: Text("ANULLER",style: TextStyle(color: Colors.black),))
      ],
      title: Text("Choiser Video"),
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
                IconButton(icon:Icon(Icons.video_collection,size: 30,color: Colors.green,),onPressed: (){
                  Navigator.of(context).pop();
                  pickvideoFromGallery();
                },),
                SizedBox(height: 10,),
                Text("Galerie")
              ],
            ),
            Column(
              children: [
                IconButton(icon:Icon(Icons.video_call,size: 40,color: Colors.green,),onPressed: (){
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Ajouter Exercice",style: TextStyle(color: Colors.pinkAccent,fontWeight: FontWeight.w500),),),
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
                pick();
              },
              icon: _isVideo? ClipRRect(borderRadius: BorderRadius.circular(8),child: !_videoPlayerController!.value.isInitialized?CircularProgressIndicator():AspectRatio(aspectRatio: _videoPlayerController!.value.aspectRatio,child: VideoPlayer(_videoPlayerController!))):Icon(Icons.video_collection_outlined,color: Colors.black54,size: MediaQuery.of(context).size.height*0.1,),
            ),
          ),
          InputModel(c: nom_controller, hint: "Nom d'Exercise", icon: Icons.abc),
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
            await Provider.of<AddExerciceProvider>(context,listen: false).addData(ExerciceObject(name: nom_controller.text, subtitle: desc_controller.text, image: media!.path, uid: widget.exerciceUid, pereUid:widget.planUid),);
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
  @override
  void dispose() {
    // TODO: implement dispose
    _videoPlayerController?.dispose();
    super.dispose();
  }
}
