import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sportapplication/screens_salle/list_demande_clients.dart';

class DemandeSalleItem extends StatelessWidget {
  DemandeSalleItemModel model;
  VoidCallback ontap;
  DemandeSalleItem({Key? key,required this.model,required this.ontap}) : super(key: key);

  FirebaseFirestore firestore = FirebaseFirestore.instance;

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


  Future<String> getUid() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String uid =  prefs.getString('userId')??"";
    return uid;
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: EdgeInsets.all(8),
      color: Colors.grey.shade100,
      child: Column(
        children: [
          ListTile(
            leading: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey.shade100,
                  image: DecorationImage(image: NetworkImage(model.image),fit: BoxFit.cover)
              ),
            ),
            title:  Text('${model.fullname}',style: GoogleFonts.acme(letterSpacing: 1,color: Colors.black),),
            subtitle: Text(''),

          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(height: 25,),
              ElevatedButton(onPressed: () async{
                showD(context);
                String salle = await getUid();
                if(model.coach){
                  await firestore.collection("Entraineurs").doc(model.uid).collection("demandes").where("salleID",isEqualTo: salle).get().then((value) async{
                    WriteBatch batch = firestore.batch();

                    // Iterate through the documents and update the 'status' field
                    for (QueryDocumentSnapshot doc in value.docs) {
                      batch.update(doc.reference, {'status': 'refuse'});
                    }

                    // Commit the batch
                    await batch.commit();
                  });
                  await firestore.collection("Responsables").doc(salle).collection("demandes").where("user",isEqualTo: salle).where("role",isEqualTo: "coach").get().then((value) async{
                    await value.docs.first.reference.delete();

                  });


                }else{


                  await firestore.collection("Sportifs").doc(model.uid).collection("demandes").where("salleID",isEqualTo: salle).get().then((value) async{
                    WriteBatch batch = firestore.batch();

                    // Iterate through the documents and update the 'status' field
                    for (QueryDocumentSnapshot doc in value.docs) {
                      batch.update(doc.reference, {'status': 'refuse'});
                    }

                    // Commit the batch
                    await batch.commit();

                  });
                  await firestore.collection("Responsables").doc(salle).collection("demandes").where("user",isEqualTo: model.uid).where("role",isEqualTo: "sportif").get().then((value) async{
                    await value.docs.first.reference.delete();

                  });

                }
                Navigator.pop(context);
                ontap();

              },
                child: Text('Refuser',style: TextStyle(color: Colors.white,fontSize: 19),),
                style: ButtonStyle(
                    minimumSize: WidgetStateProperty.all<Size>(Size(MediaQuery.of(context).size.width*0.47,MediaQuery.of(context).size.height*0.04)),
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))),
                    backgroundColor: WidgetStateProperty.all<Color>(Colors.redAccent)
                ),),

              ElevatedButton(onPressed: () async{
                showD(context);
                String salle = await getUid();
                if(model.coach){
                  await firestore.collection("Entraineurs").doc(model.uid).collection("demandes").where("salleID",isEqualTo: salle).get().then((value) async{
                    await value.docs.first.reference.delete();
                  });
                  await firestore.collection("Responsables").doc(salle).collection("demandes").where("user",isEqualTo: model.uid).where("role",isEqualTo: "coach").get().then((value) async{
                    await value.docs.first.reference.delete();
                  });

                  Map<String,dynamic> mp = {
                    "salleID":salle,
                    "user":model.uid,
                    "role":"coach"
                  };
                  await firestore.collection("Members").add(mp).then((val){
                    debugPrint("im here just add");
                  });

                  /** HERE NEW LINES **/

                  Map<String,dynamic> s = {
                    "role":"coach",
                    "user":model.uid
                  };
                  Map<String,dynamic> c = {
                    "role":"salle",
                    "user":salle
                  };
                  await firestore.collection("Responsables").doc(salle).collection("chats").add(s);
                  await firestore.collection("Entraineurs").doc(model.uid).collection("chats").add(c);

                }else{
                  debugPrint("user is sportif now");
                  await firestore.collection("Sportifs").doc(model.uid).collection("demandes").where("salleID",isEqualTo: salle).get().then((value) async{
                    await value.docs.first.reference.delete();
                  });
                  await firestore.collection("Responsables").doc(salle).collection("demandes").where("user",isEqualTo: model.uid).where("role",isEqualTo: "sportif")..get().then((value) async{
                    debugPrint("doc to delete now is $salle and doc id is ${value.docs.first.id}");

                    await value.docs.first.reference.delete();
                  });



                  Map<String,dynamic> mp = {
                    "salleID":salle,
                    "user":model.uid,
                    "role":"sportif"
                  };
                  await firestore.collection("Members").add(mp).then((val){
                    debugPrint("im here just add");
                  });

                  /** HERE NEW LINES **/

                  DocumentSnapshot<Map<String, dynamic>> sp = await firestore.collection("Sportifs").doc(model.uid).get();
                  DocumentSnapshot<Map<String, dynamic>> sa = await firestore.collection("Responsables").doc(salle).get();


                  Map<String,dynamic> s = {
                    "role":"sportif",
                    "user":model.uid,
                    "fullname":sp.get("fullname"),
                    "image":sp.get("profileImage")
                  };
                  Map<String,dynamic> c = {
                    "role":"salle",
                    "user":salle,
                    "fullname":sa.get("fullname"),
                     "profile":sa.get("profileImage")
                  };
                  await firestore.collection("Responsables").doc(salle).collection("chats").doc(model.uid).set(s);
                  await firestore.collection("Sportifs").doc(model.uid).collection("chats").doc(salle).set(c);
                }
                Navigator.pop(context);
                ontap();

              }, child: Text('Accepter',style: TextStyle(color: Colors.white,fontSize: 19),),
                style: ButtonStyle(
                    minimumSize: WidgetStateProperty.all<Size>(Size(MediaQuery.of(context).size.width*0.47,MediaQuery.of(context).size.height*0.04)),
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))),
                    backgroundColor: WidgetStateProperty.all<Color>(Colors.green)
                ),),

            ],
          )
        ],
      ),
    );
  }
}
