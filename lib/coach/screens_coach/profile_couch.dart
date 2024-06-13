import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sportapplication/projects/what_you_are.dart';

class ProfileCoachScreen extends StatefulWidget {
  

  @override
  State<ProfileCoachScreen> createState() => _ProfileCoachScreenState();
}

class _ProfileCoachScreenState extends State<ProfileCoachScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  signOut() async {
    await auth.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => ChoisirWhatYouAre()));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Column(
        children: [
          SizedBox(
            height: 25,
          ),
          Center(
            child: CircleAvatar(
              radius: 64,
              backgroundColor: Colors.pink.shade200,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "NAME",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Entraineur@gmail.com",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Divider(
              thickness: 2,
              color: Colors.grey,
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.settings,
            ),
            title: Text('Settings'),
          ),
          ListTile(
            leading: Icon(
              Icons.phone,
            ),
            title: Text('Phone'),
          ),
          ListTile(
            leading: Icon(
              Icons.settings,
            ),
            title: Text('Settings'),
          ),
          ListTile(
            leading: Icon(
              Icons.shopping_bag,
            ),
            title: Text('SHopping'),
          ),
          ListTile(
            leading: Icon(
              Icons.logout_outlined,
            ),
            title: Text('Log out'),
            onTap: () {
              signOut();
            },
          ),
        ],
      ),
    );
  }
}
