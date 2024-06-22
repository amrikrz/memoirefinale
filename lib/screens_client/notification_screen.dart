import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sportapplication/screens_client/message_user_screen.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Notifications',style: GoogleFonts.acme(letterSpacing: 1)),
          bottom: TabBar(
            dividerColor: Colors.orange.shade100,
            indicatorPadding: EdgeInsets.symmetric(horizontal: 9),
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: [
              Tab(icon: Text('NOTIFICATION',style: GoogleFonts.acme(letterSpacing: 1,color: Colors.black),),),
              Tab( icon: Text('MESSAGES',style: GoogleFonts.acme(letterSpacing: 1,color: Colors.black))),

            ],
          ),
        ),
        body: TabBarView(
          children: [
            Center(child: Text('Notification Screen')),
            MessageUserScreen(),
          ],
        ),
      ),
    );
  }
}
