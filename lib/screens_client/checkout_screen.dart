import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sportapplication/projects/get_plan_coach_buy.dart';
import 'package:sportapplication/screens_client/programe_chekhout_item.dart';

class CD{
  String image,fullname;

  CD(this.image, this.fullname);

}

class CheckoutScreen extends StatefulWidget {
  CheckoutScreen({Key? key,}) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {


  List<PlanCoach2UserModel> checkouts = [];

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<String> getUid() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String uid =  prefs.getString('userId')??"";
    
    return uid;
  }
  
  Future<void> Delete(PlanCoach2UserModel plan) async {
    String uid = await getUid();
    QuerySnapshot querySnapshot = await firestore
        .collection("Sportifs")
        .doc(uid)
        .collection("checkouts")
        .where("planID", isEqualTo: plan.planUid)
        .get();
    debugPrint("plan ${plan.planUid}");
    await querySnapshot.docs.first.reference.delete();
  }



  Future<List<PlanCoach2UserModel>> getData() async{
    String uid = await getUid();
    QuerySnapshot<Map<String,dynamic>> dat = await firestore.collection("Sportifs").doc(uid).collection("checkouts").get();
    checkouts.clear();



    dat.docs.forEach((data){
      PlanCoach2UserModel model = PlanCoach2UserModel(title: data["name"], subtitle: data["subtitle"], categorie: data["categorie"], niveau: data["niveau"], prix:  data["prix"], profile: data["profile"], fullname: data["fullname"], planUid: data["planID"], coachUid:   data["coachID"], image:data["image"]);
     checkouts.add(model);
    });


    return checkouts;
  }



  Future<void> Buy() async{
    List<String> coachUids = [];
    List<CD> cd = [];
    String uid = await getUid();

    checkouts.forEach((plan) async{
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

      if(!coachUids.contains(plan.coachUid)){
        coachUids.add(plan.coachUid);
        cd.add(CD(plan.profile,plan.fullname));
      }

      await firestore.collection("Sportifs").doc(uid).collection("plans").add(data);
      debugPrint('coachID : ${plan.coachUid}');
      await firestore.collection("Sell").add(data);
      checkouts.clear();

    });

    final querySnapshot = await firestore.collection("Sportifs").doc(uid).collection("checkouts").get();

    // Delete each document in a batch (optional for efficiency)
    final batch = FirebaseFirestore.instance.batch();
    for (var doc in querySnapshot.docs) {
      batch.delete(doc.reference);
    }
    await batch.commit(); // Commit the batch write (if used)


    final query = await firestore.collection("Sportifs").doc(uid).collection("coachs").get();

    if(query.docs.isNotEmpty){
      query.docs.forEach((element){
        for (int i =0;i<coachUids.length; i++) {
          if(element['coachID'] == coachUids[i]){

          }else{
            Map<String,dynamic> data = {
              "coachID": coachUids[i],
              "profile":cd[i].image,
              "fullname":cd[i].fullname
            };
            firestore.collection("Sportifs").doc(uid).collection("coachs").add(data);
          }
        }
      });
    }else{
      for (int i =0;i<coachUids.length; i++) {

          Map<String,dynamic> data = {
            "coachID": coachUids[i],
             "profile":cd[i].image,
            "fullname":cd[i].fullname
          };
          firestore.collection("Sportifs").doc(uid).collection("coachs").add(data);

    }
    }
    debugPrint("uids size: ${coachUids.length}");
    
    for (var element in coachUids) {
      DocumentSnapshot<Map<String, dynamic>> sp = await firestore.collection("Sportifs").doc(uid).get();
      DocumentSnapshot<Map<String, dynamic>> co = await firestore.collection("Entraineurs").doc(element).get();
      Map<String,dynamic> s = {
        "role":"coach",
        "user":element,
        "profile":co.get("storeImage"),
        "fullname":co.get("businessName")
      };
      Map<String,dynamic> c = {
        "role":"sporif",
        "user":uid,
        "profile":sp.get("profileImage"),
        "fullname":sp.get("fullname")
      };
      await firestore.collection("Sportifs").doc(uid).collection("chats").doc(element).set(s);
      await firestore.collection("Entraineurs").doc(element).collection("chats").doc(uid).set(c);
    }
  }

  showD(){
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
                Text("  Loading ...")
              ],
            ),
          ),
        ));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          checkouts.clear();
          Navigator.of(context).pop();
        }, icon: Icon(Icons.arrow_back)),
        title: Text("Commandes",style: TextStyle(color: Colors.pinkAccent,fontWeight: FontWeight.w500)),),
        body: FutureBuilder<List<PlanCoach2UserModel>>(
          future: getData(),
          builder: (BuildContext context, AsyncSnapshot<List<PlanCoach2UserModel>> snapshot) {

            double total = 0;
            checkouts.forEach((element){
              try{
              total += double.parse(element.prix);}
                  catch(e){

                  }
            });

            if(snapshot.connectionState == ConnectionState.done){
              return checkouts.isEmpty?const Center(child: Text("Aucun Commande"),):Column(
                children: [
                  Expanded(
                      flex: 8,
                      child: ListView.builder(

                          itemCount: checkouts.length,
                          itemBuilder:(context,position)=>ProgrameChekhoutItem(plan:checkouts[position],ontap: () async{

                            debugPrint("ih here");
                            await Delete(checkouts[position]);

                            setState(() {
                              checkouts.remove(position);
                            });
                          },))),
                  Expanded(
                      flex: 2,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.pinkAccent.shade100.withOpacity(0.2),
                            borderRadius: BorderRadius.only(topRight: Radius.circular(8),topLeft: Radius.circular(8)),
                            border: Border.all(
                                color: Colors.black,
                                width: 1
                            )

                        ),
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            SizedBox(height: 20,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text("Total",style:GoogleFonts.poppins(fontWeight: FontWeight.w600,fontSize: 30)),
                                Text("$total DA",style:GoogleFonts.poppins(fontWeight: FontWeight.w600,fontSize: 30)),
                              ],),
                            SizedBox(height: 20,),
                            ElevatedButton(
                                onPressed: () async{
                                  showD();
                                  await Buy();
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();

                                },
                                style: ButtonStyle(
                                    minimumSize: WidgetStateProperty.all<Size>(Size(MediaQuery.of(context).size.width*0.9,MediaQuery.of(context).size.height*0.07)),
                                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))),
                                    backgroundColor: WidgetStateProperty.all<Color>(Colors.pinkAccent)
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Acheter",style:GoogleFonts.poppins(fontWeight: FontWeight.w600,fontSize: 25,color: Colors.white)),
                                    SizedBox(width: 25,),
                                    Icon(CupertinoIcons.creditcard_fill,color: Colors.white,)
                                  ],
                                )
                            )
                          ],
                        ),

                      ))
                ],
              );
            }
            return Center(child: CircularProgressIndicator(),);
          },


        ),
    );
  }
}

/**
 coach order / demande salle
 user show plan / coach / salle
 **/