import 'package:flutter/material.dart';
import 'package:sportapplication/screens_client/alimentation/alimentation_client.dart';
import 'package:sportapplication/screens_client/exercice_client.dart';
import 'package:sportapplication/screens_client/home_client2.dart';
import 'package:sportapplication/screens_client/profile_cclient.dart';
import 'package:sportapplication/screens_client/profile_client.dart';
import 'package:sportapplication/screens_client/statistique/statistique.dart';


class ClientHome extends StatefulWidget {
  const ClientHome({super.key});

  @override
  State<ClientHome> createState() => _MobileState();
}

class _MobileState extends State<ClientHome> {
  int currentpage = 0;
    int _pageIndex = 0;

   final List<Widget> _pages = [
            SportifHome2(),
            ClientExercice(),
            ClientAliment(),
            Statistique(),

            ProfileCclient(),
  ];
  final PageController pageController = PageController();
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
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: "Home",),
          BottomNavigationBarItem(
              icon: Icon(Icons.fitness_center_outlined), label: "Exercices"),
          BottomNavigationBarItem(icon: Icon(Icons.space_dashboard), label: "Plans"),
          BottomNavigationBarItem(icon: Icon(Icons.stacked_bar_chart), label: "Statistique"),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle_outlined,),label: "Profile"),
        ],
      ),
      
        
        body: _pages[_pageIndex],
        
        
      
      ),
    );
  }
}
