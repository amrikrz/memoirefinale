import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sportapplication/coach/models/input_model.dart';
import 'package:sportapplication/projects/what_you_are.dart';

import '../models/coach_profile_model.dart';

class ProfileCoachScreen extends StatefulWidget {

  String uid;
  ProfileCoachScreen({this.uid = ""});
  @override
  State<ProfileCoachScreen> createState() => _ProfileCoachScreenState();
}

class _ProfileCoachScreenState extends State<ProfileCoachScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  void signOut() async {
    await auth.signOut();

    Navigator.pushAndRemoveUntil(
        context, MaterialPageRoute(builder: (context) => ChoisirWhatYouAre()),(route)=>false);

  }
  TextEditingController email_controller = TextEditingController(text: "berredje.oussama.mi@gmail.com"),
  phone_controller = TextEditingController(text: "0555927602"),
  state_controller = TextEditingController(text: "Annaba"),
  city_controller = TextEditingController(text: "Mondovi"),
  country_controller = TextEditingController(text: "Algerie");

  Future<CoachProfileModel> getData() async{
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    String uid;
    if(widget.uid.isNotEmpty){
      uid = widget.uid;
    }else{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      uid =  prefs.getString('userId')??"";
    }

    try {
      DocumentSnapshot<Map<String, dynamic>> data = await firebaseFirestore
          .collection("Entraineurs").doc(uid).get();

      String name = data.get("businessName");
      String image = data.get('storeImage');
      String email = data.get("email");
      String number = data.get("phoneNumber");
      String country = data.get("countryValue");
      String state = data.get("stateValue");
      String city = data.get("cityValue");

      return CoachProfileModel(name: name, image: image, email: email, number: number, region: country, state: state, city: city);

    }catch(e){
      debugPrint("error profile : $e");
      return CoachProfileModel(name: "", image: "", email: "", number: "", region: "", state: "", city: "");

    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading:widget.uid.isNotEmpty,
        elevation: 2,
        backgroundColor: Colors.pinkAccent,
        title: Text(
          'Profile',
          style: TextStyle(letterSpacing: 4,color: Colors.white),
        ),
        centerTitle: true,

      ),
      body: FutureBuilder<CoachProfileModel>(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot<CoachProfileModel> snapshot) {
          if(snapshot.connectionState == ConnectionState.done){

            email_controller.text = snapshot.data?.email ?? "";
            phone_controller.text = snapshot.data?.number ?? "";
            country_controller.text = snapshot.data?.region ?? "";
            city_controller.text = snapshot.data?.city ?? "";
            state_controller.text = snapshot.data?.state ?? "";

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
                      color: Colors.grey,
                      shape: BoxShape.circle,
                      image: DecorationImage(image: NetworkImage(snapshot.data?.image??"https://firebasestorage.googleapis.com/v0/b/sportapp-43.appspot.com/o/coachImages%2FVWCdWufdFvOiihFxJQVdDSX0N8u2?alt=media&token=e55f6e40-295b-4eec-a18d-998285aebfe7"
                      ),fit: BoxFit.cover)
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "${snapshot.data?.name}",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                InputModel(c: email_controller, hint: "Email", icon: Icons.mail,ontap: (){},),
                InputModel(c: phone_controller, hint: "Telephone", icon: Icons.phone,ontap: (){},),
                InputModel(c: country_controller, hint: "Region", icon: Icons.public,ontap: (){},),
                InputModel(c: state_controller, hint: "Wilaya", icon: Icons.location_on,ontap: (){},),
                InputModel(c: city_controller, hint: "Ville", icon: Icons.location_city,ontap: (){},),
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
    ));
  }
}
