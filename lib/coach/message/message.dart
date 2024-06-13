

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class MessageScreen extends StatefulWidget {
  final String userId;
  final String userType; // 'sportif', 'entraineur', 'responsable'

  MessageScreen({required this.userId, required this.userType});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<MessageScreen> {
  final TextEditingController _messageController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  void _sendMessage() async {
    String messageText = _messageController.text.trim();
    _messageController.clear();

    await _firestore.collection('messages').add({
      'text': messageText,
      'createdAt': Timestamp.now(),
      'userId': widget.userId,
      'userType': widget.userType,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: StreamBuilder(
              stream: _firestore
                  .collection('messages')
                  .orderBy('createdAt', descending: true)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                List<QueryDocumentSnapshot> messages = snapshot.data!.docs;

                return ListView.builder(
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> messageData = messages[index].data() as Map<String, dynamic>;

                    return ListTile(
                      title: Text(messageData['text']),
                      subtitle: Text(messageData['userType']),
                      // Add more UI for displaying sender info, timestamps, etc.
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Enter your message...',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
