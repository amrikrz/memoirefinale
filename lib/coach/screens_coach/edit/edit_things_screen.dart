import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sportapplication/coach/screens_coach/edit/exercise_screen.dart';
import 'package:sportapplication/coach/screens_coach/edit/plan_screen.dart';
import 'package:sportapplication/coach/screens_coach/edit/reccette_screen.dart';

class MembersProvider with ChangeNotifier {
  List<Member> _members = [
    Member(
        name: 'Boutiba',
        prenom: 'Sarah',
        dateEnrolled: 'Jan 11',
        dateExpiration: 'Feb 11'),
    Member(  name: 'Boutiba',
        prenom: 'Amina', dateEnrolled: 'Jan 11', dateExpiration: 'Feb 11'),
    Member(  name: 'Boutiba',
        prenom: 'Sarah',dateEnrolled: 'Jan 20', dateExpiration: 'Feb 20'),
    Member(  name: 'Boutiba',
        prenom: 'Sarah', dateEnrolled: 'Mar 20', dateExpiration: 'Avr 20'),
  ];

  List<Member> get members => _members;

  void updateMember(int index, Member member) {
    _members[index] = member;
    notifyListeners();
  }
}

class Member {
  String name;
  String prenom;
  String dateEnrolled;
  String dateExpiration;

  Member(
      {required this.name,
      required this.prenom,
      required this.dateEnrolled,
      required this.dateExpiration});
}

class EditProductScreen extends StatelessWidget {

  String planUid;
  bool coach;

  EditProductScreen({required this.planUid,this.coach = true});

  @override
  Widget build(BuildContext context) {
    final membersProvider = Provider.of<MembersProvider>(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Plan Entrainment',style: TextStyle(color: Colors.pinkAccent),),
          bottom: TabBar(
              indicatorSize: TabBarIndicatorSize.tab,
            indicatorPadding: EdgeInsets.symmetric(horizontal: 10),
              dividerHeight: 0,
              tabs: [
            Tab(icon: Text('RECCETTES',style: GoogleFonts.acme(letterSpacing: 1,color: Colors.black),),),
            Tab( icon: Text('EXERCISES',style: GoogleFonts.acme(letterSpacing: 1,color: Colors.black))),

          ]),
        ),
        body: TabBarView(
          children: [
            ReccetteScreen(planUid: planUid,coach: coach,),
            ExerciseScreen(planUid: planUid,coach: coach,)
          ],
        ),
      ),
    );
  }

  void _editMember(BuildContext context, int index, Member member) {
    final membersProvider =
        Provider.of<MembersProvider>(context, listen: false);
    showDialog(
      context: context,
      builder: (context) {
        final TextEditingController nameController =
            TextEditingController(text: member.name);
            final TextEditingController prenomController =
            TextEditingController(text: member.prenom);
        final TextEditingController dateEnrolledController =
            TextEditingController(text: member.dateEnrolled);
        final TextEditingController dateExpirationController =
            TextEditingController(text: member.dateExpiration);

        return AlertDialog(
          title: Text('Edit Member'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
                TextField(
                controller: prenomController,
                decoration: InputDecoration(labelText: 'Prenom'),
              ),
              TextField(
                controller: dateEnrolledController,
                decoration: InputDecoration(labelText: 'Date Enrolled'),
              ),
              TextField(
                controller: dateExpirationController,
                decoration: InputDecoration(labelText: 'Date Expiration'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                membersProvider.updateMember(
                  index,
                  Member(
                    name: nameController.text,
                    prenom: prenomController.text,
                    dateEnrolled: dateEnrolledController.text,
                    dateExpiration: dateExpirationController.text,
                  ),
                );
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
