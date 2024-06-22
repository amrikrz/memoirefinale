import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SND{
  Widget msg;
  String isSend;

  SND({required this.msg,required this.isSend});
}

class ChatMessageSalle extends StatefulWidget {
  String uid,fullname,profile,role;
  ChatMessageSalle({Key? key,required this.uid,required this.profile,required this.fullname,required this.role}) : super(key: key);

  @override
  State<ChatMessageSalle> createState() => _ChatMessageClientState();
}

class _ChatMessageClientState extends State<ChatMessageSalle> {
  bool taping = false,emoji = false,thisrd=false;

  TextEditingController controller = TextEditingController();
  late String userId;

  late String wh;

  Future<String> getUid() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String uid =  prefs.getString('userId')??"";
    return uid;
  }

  void init() async{
    userId = await getUid();
    setState((){
      loading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    wh = widget.role=='coach'?"Entraineurs":"Sportifs";
    super.initState();
    init();
  }

  bool loading = true;

  List<SND> mylist = [SND(msg: Text(
    'This is a message with emojis 😊😍🎉',
    style: TextStyle(fontSize: 22.0),
  ), isSend: "true"),];
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> sendMSG(String text) async{
    Map<String,dynamic> d = {
      "isSender":true,
      "message":text,
      "timestamp":Timestamp.now()
    };Map<String,dynamic> l = {
      "isSender":false,
      "message":text,
      "timestamp":Timestamp.now()
    };
    firestore.collection("Responsables").doc(userId).collection("chats").doc(widget.uid).collection("messages").add(d);
    firestore.collection(wh).doc(widget.uid).collection("chats").doc(widget.uid).collection("messages").add(l);

  }

  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade100,
        title: ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Container(
            height: 40,
            width: 40,
            child: CircleAvatar(
              backgroundImage: NetworkImage(
               widget.profile
                ),
            ),
          ),
          title: Text(
           widget.fullname,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          subtitle: Text("il ya 1h"),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Icon(Icons.call),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Icon(Icons.more_vert_outlined),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            flex: 9,
            child: Center(
              child: loading?CircularProgressIndicator():StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance
                    .collection('Responsables')
                    .doc(userId)
                    .collection('chats')
                    .doc(widget.uid)
                    .collection('messages')
                    .orderBy('timestamp', descending: true)
                    .snapshots(),
                builder: (context, messageSnapshot) {
                  if (messageSnapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (!messageSnapshot.hasData || messageSnapshot.data!.docs.isEmpty) {
                    return Center(child: Text('No messages available'));
                  }

                  mylist.clear();
                  messageSnapshot.data!.docs.forEach((doc) {
                    Map<String,dynamic> h = doc.data();
                    debugPrint("chat : ${h["isSender"]}");
                    mylist.add(SND(msg:Text(doc['message'], style: TextStyle(fontSize: 23,)),isSend: h["isSender"].toString()));
                  });

                  return AnimatedList(
                    reverse: true,
                    controller: scrollController,
                    key: _listKey,
                    initialItemCount: mylist.length,
                    itemBuilder: (context, position, animation) {
                      return SizeTransition(
                        sizeFactor: animation,
                        child: Row(
                          mainAxisAlignment: mylist[position].isSend=="true"?MainAxisAlignment.end:MainAxisAlignment.start,
                          children: [
                            Container(

                              margin: EdgeInsets.symmetric(vertical: 3, horizontal: 15),
                              padding: EdgeInsets.symmetric(horizontal: 7, vertical: 4),
                              decoration: BoxDecoration(
                                color:  mylist[position].isSend=="true"?Colors.pinkAccent.shade100.withOpacity(0.4):Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child:Container(
                                constraints: BoxConstraints(
                                    maxWidth: MediaQuery.of(context).size.width * 0.75),
                                padding: EdgeInsets.symmetric(horizontal: 7, vertical: 4),
                                child: mylist[position].msg,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
          Container(
            height: 80,
            color: Colors.grey.shade100,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 3),
            child: Row(
              children: [
                Container(
                  padding:EdgeInsets.symmetric(horizontal:15),
                  width:MediaQuery.of(context).size.width*0.87,
                  height: 60,
                  child: TextField(
                    maxLines: 5,
                    minLines: 1,
                    style: TextStyle(fontSize: 23, fontFamily: 'ios'),
                    controller: controller,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Message",
                      contentPadding: EdgeInsets.symmetric(horizontal: 8),
                      hintStyle: TextStyle(fontWeight: FontWeight.normal),
                    ),
                  ),
                ),
                Container(
                  width: 70,
                  height: 70,
                  child: ElevatedButton(
                    onPressed: () async{
                      mylist.insert(0, SND(msg:Text(controller.value.text, style: TextStyle(fontSize: 23)),isSend: "true"));
                      await sendMSG(controller.text);
                      controller.clear();
                      _listKey.currentState?.insertItem(0, duration: Duration(milliseconds: 200));
                      scrollController.animateTo(0, duration: Duration(milliseconds: 1000), curve: Curves.slowMiddle);
                    },
                    child: Icon(Icons.send, color: Colors.white),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pinkAccent.shade100, shape: CircleBorder()),
                  ),
                ),
              ],
            ),
          ),
        ],
      )
      ,

    );
  }
}
