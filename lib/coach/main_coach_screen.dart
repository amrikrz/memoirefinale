import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sportapplication/coach/message/message.dart';

import 'package:sportapplication/coach/screens_coach/creerProgramme/creerProgramme1.dart';
import 'package:sportapplication/coach/screens_coach/earning_screen.dart';

import 'package:sportapplication/coach/screens_coach/edit/edit_things_screen.dart';
import 'package:sportapplication/coach/screens_coach/edit/plan_entrainment.dart';
import 'package:sportapplication/coach/screens_coach/message.dart';
import 'package:sportapplication/coach/screens_coach/orders_screen.dart';
import 'package:sportapplication/coach/screens_coach/profile_couch.dart';
import 'package:sportapplication/projects/what_you_are.dart';


class MainCoachScreen extends StatefulWidget {
   MainCoachScreen({Key? key}) : super(key: key);

  @override
  State<MainCoachScreen> createState() => _MainCoachScreenState();
}

class _MainCoachScreenState extends State<MainCoachScreen> {
  int _pageIndex = 0;

  List<Widget> _pages = [
    MessageScreen(userId: '', userType: '',),
    MessageCoachScreen(),
    EarningScreen(),

    PlanEntrainment(),
    OrderScreen(),
    ProfileCoachScreen(),
  ];
  final FirebaseAuth auth = FirebaseAuth.instance;

    signOut() async {
    await auth.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => ChoisirWhatYouAre()));

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text(''),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Colors.transparent,
                image: DecorationImage(
                  image: AssetImage("assets/images/backgroundcompte.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              currentAccountPicture: CircleAvatar(
                radius: 55,
                backgroundImage: AssetImage("assets/images/compte.jpg"),
              ),
              accountEmail: Text("vendor@gmail.com"),
              accountName: Text("vendor"),
            ),
            ListTile(
              title: Text("Message"),
              leading: Icon(Icons.message_outlined),
              onTap: () {},
            ),
            ListTile(
              title: Text("Créer programmes"),
              leading: Icon(Icons.add),
              onTap: () {},
            ),
              ListTile(
              title: Text("Ordres"),
              leading: Icon(Icons.list_alt_sharp),
              onTap: () {},
            ),
              ListTile(
              title: Text("Sportifs"),
              leading: Icon(Icons.person_add_rounded),
              onTap: () {},
            ),
              ListTile(
              title: Text("Organize"),
              leading: Icon(Icons.calendar_month),
              onTap: () {},
            ),
            ListTile(
              title: Text("Notification"),
              leading: Icon(Icons.notifications),
              onTap: () {},
            ),
            ListTile(
              title: Text("Paramètres"),
              leading: Icon(Icons.settings),
              onTap: () {},
            ),
            ListTile(
              title: Text("Contactez le support"),
              leading: Icon(Icons.contact_phone),
              onTap: () {},
            ),
            ListTile(
              title: Text("Se déconnecter"),
              leading: Icon(Icons.logout_rounded),
              onTap: () {
                signOut();
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _pageIndex,
        onTap: (value) {
          setState(() {
            _pageIndex = value;
          });
        },
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.pinkAccent,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.messenger), label: 'Messages'),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.calendar), label: 'Organize'),
          
          BottomNavigationBarItem(icon: Icon(Icons.my_library_add_sharp), label: 'Programes'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_basket), label: 'ORDERS'),
          BottomNavigationBarItem(icon: Icon(Icons.perm_identity_rounded), label: 'PROFILE'),
        ],
      ),
      body: _pages[_pageIndex],
    );
  }
}
