import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sportapplication/coach/models/input_model.dart';
import 'package:sportapplication/projects/what_you_are.dart';

import '../screens_client/client_profile_model.dart';

class ResponsableProfile extends StatefulWidget {

  String uid;
  ResponsableProfile({this.uid = ""});

  @override
  State<ResponsableProfile> createState() => _ProfileCoachScreenState();
}

class _ProfileCoachScreenState extends State<ResponsableProfile> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  void signOut() async {
    await auth.signOut();
    Navigator.pushAndRemoveUntil(
        context, MaterialPageRoute(builder: (context) => ChoisirWhatYouAre()),(route)=>false);

  }

  Future<String> getUid() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String uid =  prefs.getString('userId')??"";
    return uid;
  }

  Future<SallePRofileModel> getData() async{
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    String uids = "";
    if(widget.uid.isNotEmpty){
      uids = widget.uid;
    }else{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      uids =  prefs.getString('userId')??"";
    }


    DocumentSnapshot<Map<String, dynamic>> data = await firebaseFirestore.collection("Responsables").doc(uids).get();

    String name = data.get("fullname");
    String image = data.get('profileImage');
    String email = data.get('email');
    String number = data.get("phoneNumber");
    String location = data.get("location");

    return SallePRofileModel(name: name, image: image, email: email, number: number,location: location);

  }

  TextEditingController email_controller = TextEditingController(text: "berredje.oussama.mi@gmail.com"),
      phone_controller = TextEditingController(text: "0555927602"),
      state_controller = TextEditingController(text: "Annaba"),
      city_controller = TextEditingController(text: "Annaba");


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 2,
        backgroundColor: Colors.pinkAccent,
        title: Text(
          'Profile',
          style: TextStyle(letterSpacing: 4,color: Colors.white),
        ),
        centerTitle: true,//hy

      ),
      body: FutureBuilder<SallePRofileModel>(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot<SallePRofileModel> snapshot) {
          if(snapshot.connectionState == ConnectionState.done){
            email_controller.text = snapshot.data?.email??"ikrameamara@gmail.com";
            phone_controller.text = snapshot.data?.number??"055555555";
            state_controller.text = snapshot.data?.location??"Relizan";


            return Column(
              children: [
                SizedBox(
                  height: 25,
                ),
                Center(
                  child: Container(
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(image: NetworkImage(snapshot.data!.image),fit: BoxFit.cover)
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    snapshot.data?.name??"ikram",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                InputModel(c: email_controller, hint: "Email", icon: Icons.mail,ontap: (){},),
                InputModel(c: phone_controller, hint: "Telephone", icon: Icons.phone,ontap: (){},),
                InputModel(c: state_controller, hint: "Localisation", icon: Icons.location_on,ontap: (){},),
                SizedBox(height: 15,),
                ElevatedButton(onPressed: (){
                  signOut();
                }, child: Container(
                  width: MediaQuery.of(context).size.width*0.9,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Logout',style: TextStyle(color: Colors.white,fontSize: 19),),
                      SizedBox(width: 20,),
                      Icon(Icons.logout,color: Colors.white,)
                    ],
                  ),
                ),
                  style: ButtonStyle(
                      minimumSize: WidgetStateProperty.all<Size>(Size(MediaQuery.of(context).size.width*0.9,MediaQuery.of(context).size.height*0.07)),
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))),
                      backgroundColor: WidgetStateProperty.all<Color>(Colors.pinkAccent)
                  ),)

              ],
            );
          }
          return Center(child: CircularProgressIndicator(),);
        },

      ),
    );
  }
}

class SallePRofileModel{
  String image,name,email,number,location;

  SallePRofileModel(
      {required this.image,required  this.name,required  this.email,required  this.number,required  this.location});
}
