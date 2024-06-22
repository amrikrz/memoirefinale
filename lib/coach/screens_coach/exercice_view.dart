import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sportapplication/coach/models/exercice_object.dart';
import 'package:video_player/video_player.dart';

import '../models/input_model.dart';

class ExerciceView extends StatefulWidget {
  String link,title,desc;
  ExerciceView({Key? key,required this.link,required this.title,required this.desc}) : super(key: key);

  @override
  State<ExerciceView> createState() => _ExerciceViewState();
}

class _ExerciceViewState extends State<ExerciceView> {

 bool lodaing = true;
 late VideoPlayerController videoPlayerController;

 @override
  void initState() {
    // TODO: implement initState
   title_controller.text = widget.title;
   desc_controller.text = widget.desc;
    super.initState();
    init();
  }

  TextEditingController title_controller = TextEditingController();
  TextEditingController desc_controller = TextEditingController();


  void init() async{
    videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(widget.link));
    await videoPlayerController.initialize();
    videoPlayerController.setLooping(true);
    setState(() {
      lodaing = false;
      videoPlayerController.play();

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Exercice Vue"),),
      body: Column(
        children: [
          Container(
            height: MediaQuery.sizeOf(context).height*0.5,
            child: videoPlayerController.value.isInitialized?AspectRatio(
              aspectRatio: videoPlayerController.value.aspectRatio,
              child: VideoPlayer(videoPlayerController),
            ):Center(
              child: CircularProgressIndicator(),
            ),
          ),
          InputModel(c: title_controller, hint: "Title", icon: Icons.mail,ontap: (){},),
          InputModel(c: desc_controller, hint: "Description", icon: Icons.mail,ontap: (){},),

        ],
      ),
    );
  }
}
