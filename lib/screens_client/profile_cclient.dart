import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sportapplication/coach/models/input_model.dart';
import 'package:sportapplication/projects/what_you_are.dart';
import 'package:sportapplication/screens_client/client_profile_model.dart';

import '../coach/models/coach_profile_model.dart';

class ProfileCclient extends StatefulWidget {

  String uid;
  ProfileCclient({this.uid = ""});

  @override
  State<ProfileCclient> createState() => _ProfileCoachScreenState();
}

class _ProfileCoachScreenState extends State<ProfileCclient> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  void signOut() async {
    await auth.signOut();
    Navigator.pushAndRemoveUntil(
        context, MaterialPageRoute(builder: (context) => ChoisirWhatYouAre()),(route){return false;});

  }

  Future<ClientProfileModel> getData() async{
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    String uids = "";
    if(widget.uid.isNotEmpty){
      uids = widget.uid;
    }else{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      uids =  prefs.getString('userId')??"";
    }


    QuerySnapshot<Map<String, dynamic>> data = await firebaseFirestore.collection("Sportifs").where("acheyeurId",isEqualTo: uids).get();

    String name = data.docs.first["fullname"];
    String image = data.docs.first['profileImage'];
    String email = data.docs.first['email'];
    String number = data.docs.first["phoneNumber"];
    String gendre = data.docs.first["gendre"];
    String dateN = data.docs.first["dateNaiss"];

    return ClientProfileModel(name: name, image: image, email: email, phone: number,dateN: dateN, gendre: gendre);

  }

  TextEditingController email_controller = TextEditingController(text: "berredje.oussama.mi@gmail.com"),
  phone_controller = TextEditingController(text: "0555927602"),
  state_controller = TextEditingController(text: "12/12/2003"),
  city_controller = TextEditingController(text: "Homme");


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
        centerTitle: true,

      ),
      body:FutureBuilder<ClientProfileModel>(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot<ClientProfileModel> snapshot) {
          if(snapshot.connectionState == ConnectionState.done){
            ClientProfileModel? client = snapshot.data;

            email_controller.text = client?.email ?? "";
            phone_controller.text = client?.phone??"";
            state_controller.text = client?.dateN??"";
            city_controller.text = client?.gendre??"";

            return  Column(
              children: [
                SizedBox(
                  height: 25,
                ),
                Center(
                  child: Container(
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        shape: BoxShape.circle,
                        image: DecorationImage(image: NetworkImage(snapshot.data?.image??""),fit: BoxFit.cover)
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "${client?.name}",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                InputModel(c: email_controller, hint: "Email", icon: Icons.mail,ontap: (){},),
                InputModel(c: phone_controller, hint: "Telephone", icon: Icons.phone,ontap: (){},),
                InputModel(c: state_controller, hint: "Date de Naissance", icon: Icons.calendar_month,ontap: (){},),
                InputModel(c: city_controller, hint: "Gendre", icon: Icons.person,ontap: (){},),
                SizedBox(height: 15,),
                Visibility(
                  visible: widget.uid.isEmpty,
                  child: ElevatedButton(onPressed: (){
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
                    ),),
                )

              ],
            );
          }
          return const Center(child: CircularProgressIndicator(),);
        },


      ),
    );
  }
}
