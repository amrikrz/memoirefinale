import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sportapplication/coach/controllers/add_plan_provider.dart';
import 'package:sportapplication/coach/models/input_model.dart';
import 'package:sportapplication/coach/models/plan_object.dart';

class AddPlanEntrainment extends StatefulWidget {
  const AddPlanEntrainment({Key? key}) : super(key: key);

  @override
  State<AddPlanEntrainment> createState() => _AddPlanEntrainmentState();
}

class _AddPlanEntrainmentState extends State<AddPlanEntrainment> {

  TextEditingController prix_controller = TextEditingController(),nom_controller = TextEditingController(),objectif_controller = TextEditingController(),level_controller = TextEditingController(),categorie_controller = TextEditingController();

  final List<String> categories = [
    'Dépression',
    'Stress',
    'La démence sénile',
    'La maladie de Parkinson',
    'La sclérose en plaques',
    'L’obésité',
    'Le diabète',
    'Le cancer',
    'Avec machine',
    'Sans machine',
    'La Thyroïde',
  ];
  // List to track checked categories
  final List<bool> _checkedCategories = List<bool>.filled(11, false);

  // List to store the selected categories
  List<String> _selectedCategories = [];


  void _showCategoriesDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Text('Select Categories'),
              content: Container(
                width: MediaQuery.of(context).size.width * 0.7,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: categories.length,
                  itemBuilder: (BuildContext context, int index) {
                    return CheckboxListTile(
                      title: Text(categories[index]),
                      value: _checkedCategories[index],
                      onChanged: (bool? value) {
                        setState(() {
                          _checkedCategories[index] = value!;
                          if (value) {
                            _selectedCategories.add(categories[index]);
                          } else {
                            _selectedCategories.remove(categories[index]);
                          }
                        });
                      },
                    );
                  },
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    // You can use _selectedCategories list as needed
                   String t = _selectedCategories.toString().replaceAll("[", "");
                    categorie_controller.text = t.replaceAll("]", "");
                    print(_selectedCategories);
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      },
    );



  }

  final List<String> niveaux = [
    'Débutant',
     'Moyen',
    'Extrême',
  ];

  late String selectedNiveau;

  @override
  void initState() {
    // TODO: implement initState
    selectedNiveau = niveaux[0]; // Pre-select the first option (optional)

    super.initState();
  }

  File? media;
  final ImagePicker _picker = ImagePicker();
  bool _isVideo = false;

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


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("Ajouter Plan Entrainment",style: TextStyle(color: Colors.pinkAccent,fontWeight: FontWeight.w500),),),
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
            InputModel(c: nom_controller, hint: "Nom", icon: Icons.abc),
            InputModel(c: objectif_controller, hint: "Objectif", icon: Icons.playlist_add_check_circle),
            InputModel(c: categorie_controller, hint: "Categorie", icon: Icons.list_alt_outlined,ontap: (){_showCategoriesDialog();}),
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
                items: niveaux.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            InputModel(c: prix_controller, hint: "Prix", icon: Icons.monetization_on_sharp),
            SizedBox(height: 15,),
            ElevatedButton(onPressed: () async{

              if(categorie_controller.text.isNotEmpty && objectif_controller.text.isNotEmpty && nom_controller.text.isNotEmpty && prix_controller.text.isNotEmpty && media != null){
                showDialog(
                  context: context,
                  barrierDismissible: false, // Disable user dismissal
                  builder: (BuildContext context) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                );

                await Provider.of<AddPlanProvider>(context,listen: false).addData(PlanObject(uid: "",name: nom_controller.text, description: objectif_controller.text, niveau: selectedNiveau, categorie: categorie_controller.text, prix: prix_controller.text, image: media!.path));
                Provider.of<AddPlanProvider>(context,listen: false).update();
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Success Add Tout Les Information"),duration: Duration(milliseconds: 450),));
                Future.delayed(Duration(milliseconds: 500));
                Navigator.pop(context);
              }else{
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Entrer Tout Les Information")));
              }

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
