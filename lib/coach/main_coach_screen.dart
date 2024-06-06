import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sportapplication/coach/screens_coach/earning_screen.dart';
import 'package:sportapplication/coach/screens_coach/edit/edit_things_screen.dart';
import 'package:sportapplication/coach/screens_coach/message.dart';
import 'package:sportapplication/coach/screens_coach/orders_screen.dart';
import 'package:sportapplication/coach/screens_coach/profile_couch.dart';


class MainCoachScreen extends StatefulWidget {
  const MainCoachScreen({Key? key}) : super(key: key);

  @override
  State<MainCoachScreen> createState() => _MainCoachScreenState();
}

class _MainCoachScreenState extends State<MainCoachScreen> {
  int _pageIndex = 0;

  List<Widget> _pages = [
    MessageScreen(),
    EarningScreen(),
  
    EditProductScreen(),
    OrderScreen(),
    ProfileCoachScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          BottomNavigationBarItem(icon: Icon(Icons.message), label: 'SMS'),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.calendar), label: 'Organize'),
          
          BottomNavigationBarItem(icon: Icon(Icons.edit), label: 'EDIT'),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.shopping_cart), label: 'ORDERS'),
          BottomNavigationBarItem(icon: Icon(Icons.perm_identity_rounded), label: 'PROFILE'),
        ],
      ),
      body: _pages[_pageIndex],
    );
  }
}
