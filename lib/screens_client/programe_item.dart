import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sportapplication/coach/screens_coach/edit/plan_screen.dart';
import 'package:sportapplication/projects/get_plan_coach_buy.dart';
import 'package:sportapplication/screens_client/checkout_screen.dart';

import '../coach/screens_coach/edit/edit_things_screen.dart';


class ProgrameItem extends StatelessWidget {
  PlanCoach2UserModel plan;
  bool showIcon;
  ProgrameItem({Key? key,required this.plan,this.showIcon = true}) : super(key: key);

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<String> getUid() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String uid =  prefs.getString('userId')??"";

    return uid;
  }

  Future<void> addData() async {

    Map<String,dynamic> data = {};
    String uid = await getUid();

    data["planID"] = plan.planUid;
    data["name"] = plan.title;
    data["subtitle"] = plan.subtitle;
    data["image"] = plan.image;
    data["categorie"] = plan.categorie;
    data["niveau"] = plan.niveau;
    data["fullname"] = plan.fullname;
    data["profile"] = plan.profile;
    data["prix"] = plan.prix;
    data["coachID"] = plan.coachUid;

    await firestore.runTransaction((transaction) async {
      // Query the documents to check if the planUid already exists
      QuerySnapshot querySnapshot = await firestore
          .collection("Sportifs")
          .doc(uid)
          .collection("checkouts")
          .where("planID", isEqualTo: plan.planUid)
          .get();

      QuerySnapshot query = await firestore
          .collection("Sportifs")
          .doc(uid)
          .collection("plans")
          .where("planID", isEqualTo: plan.planUid)
          .get();

      // If no documents are found, add the new document
      if (querySnapshot.docs.isEmpty && query.docs.isEmpty) {
        // Create a new document reference
        DocumentReference newDocRef = firestore
            .collection("Sportifs")
            .doc(uid)
            .collection("checkouts")
            .doc();

        // Add the new document
        transaction.set(newDocRef, data);
      }
    });




  }

  showD(BuildContext context){
    showDialog(
        context: context,
        builder: (context)=>AlertDialog(
          content: Container(
            height: 80,
            width: 80,
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 12,),
                Text("Loading ...")
              ],
            ),
          ),
        ));
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.grey.shade100
      ),
      child: GestureDetector(
        onTap: (){
          if(!showIcon){
            Navigator.of(context).push(CupertinoPageRoute(builder: (context)=> EditProductScreen(planUid: plan.planUid,coach: false,)));

          }
        },
        child: Column(
          children: [
            ListTile(
                contentPadding: EdgeInsets.only(bottom: 10,top: 10,left: 10),
                trailing: Visibility(
                  visible: showIcon,
                  child: IconButton(icon: Icon(Icons.add_shopping_cart,color: Colors.blueAccent,),onPressed: () async{
                    showD(context);
                    await addData();
                    Navigator.pop(context);
                  },),
                ),
                leading: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey.shade100,
                      image: DecorationImage(image: NetworkImage(plan.profile),fit: BoxFit.cover)
                  ),
                ),
                title: Text(plan.fullname,style: GoogleFonts.acme(letterSpacing: 1,color: Colors.black),),
              ),
            Container(
              color: Colors.pinkAccent.shade100.withOpacity(0.5),
              child: ListTile(
                contentPadding: EdgeInsets.only(left: 30),
                onTap: (){
                },
                leading: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey.shade100,
                      image: DecorationImage(image: NetworkImage(plan.image),fit: BoxFit.cover)
                  ),
                ),
                title:  Text(plan.title,style: GoogleFonts.acme(letterSpacing: 1,color: Colors.black),),
                subtitle: Text(plan.subtitle),

              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 15),
              decoration: BoxDecoration(
                color: Colors.pinkAccent.shade100.withOpacity(0.5),
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12),bottomRight: Radius.circular(12))
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('Categorie : ${plan.categorie}',style: GoogleFonts.acme(letterSpacing: 1,color: Colors.black),),
                  Text('Niveaux : ${plan.niveau}',style: GoogleFonts.acme(letterSpacing: 1,color: Colors.purple),),
                  Text('Prix : ${plan.prix}DA',style: GoogleFonts.acme(letterSpacing: 1,color: Colors.green),),
                ],
              ),
            )

          ],
        ),
      ),
    );
  }
}
