import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sportapplication/coach/controllers/add_reccette_provider.dart';
import 'package:sportapplication/screens_client/alimentation/recipe_details.dart';

import '../../models/input_model.dart';


class AddReccetteScreen extends StatefulWidget {
  String planUid,reccetteUid;
   AddReccetteScreen({super.key,required this.planUid,required this.reccetteUid});

  @override
  State<AddReccetteScreen> createState() => _AddReccetteScreenState();
}

class _AddReccetteScreenState extends State<AddReccetteScreen> {

  File? media;
  final ImagePicker _picker = ImagePicker();
  bool _isVideo = false;
  TextEditingController nom_controller=TextEditingController(),desc_controller=TextEditingController(),calories_controller=TextEditingController(),reccette_controller=TextEditingController(),duration_controller=TextEditingController();


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

  final List<String> categorie = [
    'Sucré',
    'Sallé',
  ];

  late String selectedNiveau;

  @override
  void initState() {
    // TODO: implement initState
    selectedNiveau = categorie[0];
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Ajouter Reccettes",style: TextStyle(color: Colors.pinkAccent,fontWeight: FontWeight.w500),),),
      body: SingleChildScrollView(
        child: Column(
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
            InputModel(c: nom_controller, hint: "Nom de reccette", icon: Icons.abc),
            InputModel(c: reccette_controller, hint: "Reccette", icon: Icons.list_alt_outlined),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 3),
              margin: EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.black54,
                      width: 1
                  )
              ),
              child: DropdownButton<String>(

                isExpanded: true,
                value: selectedNiveau,
                icon: Icon(Icons.arrow_drop_down), // Dropdown icon
                iconSize: 24.0,
                elevation: 16, // Shadow effect
                style: TextStyle(color: Colors.black, fontSize: 16.0), // Text style
                underline: Container(
                  height: 2,
                  color: Colors.transparent, // Underline color
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedNiveau = newValue!;
                    print(selectedNiveau!);
                  });
                },
                items: categorie.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),

            InputModel(c: calories_controller, hint: "Callorie", icon: Icons.local_fire_department_rounded),
            InputModel(c: duration_controller, hint: "Temp de preparation", icon: Icons.alarm),
            InputModel(c: desc_controller, hint: "Description", icon: Icons.list_outlined),

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
              await Provider.of<AddReccetteProvider>(context,listen: false).addData(RecipeModel(name: nom_controller.text, image: media!.path, category: selectedNiveau, duration: duration_controller.text, calories: calories_controller.text, subtitle: desc_controller.text, reccetteUid: widget.reccetteUid, pereUid: widget.planUid, uid: "", reccette: reccette_controller.text));
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
      ),
    );
  }
}
