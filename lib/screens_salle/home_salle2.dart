import 'package:flutter/material.dart';
import 'package:sportapplication/screens_salle/ajouter_Salle.dart';
import 'package:sportapplication/screens_salle/demandes_screen.dart';
import 'package:sportapplication/screens_salle/message2.dart';
import 'package:sportapplication/screens_salle/profile_salle.dart';

class ResponsableHome extends StatefulWidget {
  const ResponsableHome({super.key});

  @override
  State<ResponsableHome> createState() => _ResponsableHomeState();
}

class _ResponsableHomeState extends State<ResponsableHome> {
    int currentpage = 0;
    int _pageIndex = 0;

 final List<Widget> _pages = [
            Message2(),
            ResponsableFormul(),
            DemandesScreen(),
            ResponsableProfile(),
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(

        bottomNavigationBar: BottomNavigationBar(
        currentIndex: _pageIndex,
        onTap: (value) {
          setState(() {
            _pageIndex = value;
          });
        },
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.pink,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.message), label: "Message",),
              BottomNavigationBarItem(
              icon: Icon(Icons.group), label: "Partcipent"), BottomNavigationBarItem(
              icon: Icon(Icons.person_add_rounded), label: "Demandes"),
      
          BottomNavigationBarItem(icon: Icon(Icons.account_circle_outlined,),label: "Profile"),
        ],
      ),
      
        
        body: _pages[_pageIndex],
        
        
      
      ),
    );
  }
}
