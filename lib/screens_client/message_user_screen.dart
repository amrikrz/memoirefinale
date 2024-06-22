
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sportapplication/screens_client/chat_message_client.dart';




class MessageUserScreen extends StatefulWidget {
  MessageUserScreen({Key? key}) : super(key: key);

  @override
  State<MessageUserScreen> createState() => _ChatState();
}

class _ChatState extends State<MessageUserScreen>{

  bool isVisible = true,isReleased = false;
  ScrollController _Vertical = ScrollController();

  late String userId;


  Future<String> getUid() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String uid =  prefs.getString('userId')??"";
    return uid;
  }


  double pastVerOf=0;

  void init() async{
    userId = await getUid();
    setState((){

      loading = false;
    });
  }

  bool loading = true;

  @override
  void initState() {
    // TODO: implement initState

    init();

    _Vertical.addListener(() {
      if (_Vertical.offset != 0.0) {



        if (pastVerOf > _Vertical.offset) {
          if(!isVisible){
            setState(() {
              isVisible = true;
              isReleased = false;
            });
          }

        } else {
          // Scrolled bottom to top
          if(isVisible){
            setState(() {
              isVisible = false;
              isReleased = false;
            });
          }
        }
        pastVerOf = _Vertical.offset;

      }
    });
    super.initState();
  }



  @override
  void dispose() {
    _Vertical.dispose();
    super.dispose();
  }







  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      backgroundColor: Colors.grey.shade100,

      body: loading?Center(child: CircularProgressIndicator(color: Colors.green,),):Stack(
          children:[
            NestedScrollView(
              controller: _Vertical,
              floatHeaderSlivers: true,
              headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {

                return [
                  SliverAppBar(
                    floating: true,
                    backgroundColor: Colors.grey.shade100,
                    toolbarHeight: 65,
                    leadingWidth: double.infinity,
                    leading: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 7),
                      color: Colors.transparent,
                      child: TextField(

                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search),
                          hintText: "Search",
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 0.4
                              )
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 0.4
                              )
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 0.4
                            )
                          )
                        ),
                      ),
                    ),

                  ),

                ];
              },
              body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance
                    .collection('Sportifs')
                    .doc(userId)
                    .collection('chats')
                    .snapshots(),
                builder: (context, chatSnapshot) {
                  if (chatSnapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (!chatSnapshot.hasData || chatSnapshot.data!.docs.isEmpty) {
                    return Center(child: Text('No chats available'));
                  }

                  return ListView(
                    children: chatSnapshot.data!.docs.map((chatDoc) {
                      String friendId = chatDoc.id;

                      return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                        future: FirebaseFirestore.instance
                            .collection('Sportifs')
                            .doc(userId)
                            .collection("chats")
                            .doc(friendId)
                            .get(),
                        builder: (context, userSnapshot) {
                          if (userSnapshot.connectionState == ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          }

                          if (!userSnapshot.hasData || !userSnapshot.data!.exists) {
                            return Center(child: Text('User not found'));
                          }

                          String fullName = userSnapshot.data!.data()?['fullname'] ?? "Ikram";
                          String role = userSnapshot.data!.data()?['role'] ?? "Sportif";
                          String profile = userSnapshot.data!.data()?['profile'] ?? "https://firebasestorage.googleapis.com/v0/b/sportapp-43.appspot.com/o/profileimage%2FywtLRT3wpiPzkwZt9YD00rwfzEq1?alt=media&token=09e30701-8edc-4f27-9978-98748209fc23";

                          return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                            stream: FirebaseFirestore.instance
                                .collection('Sportifs')
                                .doc(userId)
                                .collection('chats')
                                .doc(friendId)
                                .collection('messages')
                                .orderBy('timestamp', descending: true)
                                .limit(1)
                                .snapshots(),
                            builder: (context, messageSnapshot) {
                              if (!messageSnapshot.hasData || messageSnapshot.data!.docs.isEmpty) {
                                return CupertinoContextMenu(
                                  actions: [
                                    CupertinoContextMenuAction(child: Text("Reponder")),
                                    CupertinoContextMenuAction(child: Text("Remove")),
                                    CupertinoContextMenuAction(child: Text("Share")),
                                  ],
                                  child: Material(
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(color: Colors.grey.shade100),
                                      child: Container(
                                        constraints: BoxConstraints(
                                            maxWidth: MediaQuery.of(context).size.width * 0.95,
                                            maxHeight: 73
                                        ),
                                        height: 69,
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.only(bottom: 7),
                                        child: ListTile(
                                          onTap: () {
                                            Navigator.of(context).push(CupertinoPageRoute(builder: (context)=>ChatMessageClient(uid: friendId, profile: profile, fullname: fullName,role: role,)));
                                          },
                                          leading: Container(
                                            color: Colors.grey.shade100,
                                            margin: EdgeInsets.only(left: 5),
                                            height: 55,
                                            width: 55,
                                            child: CircleAvatar(
                                              backgroundImage: NetworkImage(profile),
                                            ),
                                          ),
                                          title: Text(fullName, style: TextStyle(fontWeight: FontWeight.bold)),
                                          subtitle: Text("You are friends now"),
                                          trailing: Text("$role", style: TextStyle(color: Colors.green)),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }

                              var lastMessage = messageSnapshot.data!.docs.first["message"];
                              return CupertinoContextMenu(
                                actions: [
                                  CupertinoContextMenuAction(child: Text("Reponder")),
                                  CupertinoContextMenuAction(child: Text("Remove")),
                                  CupertinoContextMenuAction(child: Text("Share")),
                                ],
                                child: Material(
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(color: Colors.grey.shade100),
                                    child: Container(
                                      constraints: BoxConstraints(
                                          maxWidth: MediaQuery.of(context).size.width * 0.95,
                                          maxHeight: 73
                                      ),
                                      height: 69,
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.only(bottom: 7),
                                      child: ListTile(
                                        onTap: () {
                                          Navigator.of(context).push(CupertinoPageRoute(builder: (context)=>ChatMessageClient(uid: friendId, profile: profile, fullname: fullName,role: role,)));
                                        },
                                        leading: Container(
                                          color: Colors.grey.shade100,
                                          margin: EdgeInsets.only(left: 5),
                                          height: 55,
                                          width: 55,
                                          child: CircleAvatar(
                                            backgroundImage: NetworkImage(profile),
                                          ),
                                        ),
                                        title: Text(fullName, style: TextStyle(fontWeight: FontWeight.bold)),
                                        subtitle: Text(lastMessage),
                                        trailing: Text("$role", style: TextStyle(color: Colors.green)),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      );
                    }).toList(),
                  );
                },
              )
              ,
            ),


          ]),
    );
  }




}
