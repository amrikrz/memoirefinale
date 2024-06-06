import 'package:flutter/material.dart';
import 'package:sportapplication/screens_client/exercice/exercice_SearchScreen.dart';
import 'package:sportapplication/screens_client/coach_partie_client/tab2.dart';
import 'package:sportapplication/screens_client/Responsable_partie_sportif/tab3.dart';

class ClientExercice extends StatefulWidget {
  // ignore: use_super_parameters
  const ClientExercice({Key? key}) : super(key: key);

  @override
  State<ClientExercice> createState() => _ClientExerciceState();
}

class _ClientExerciceState extends State<ClientExercice> {
  @override
  Widget build(BuildContext context) {
  
    // ignore: prefer_const_constructors
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(automaticallyImplyLeading: false,
        actions:<Widget> [
          IconButton(onPressed: (){}, icon: Icon(Icons.add),),
        ],
        ),
        body: Column(
          children: [
            TabBar(
                            indicatorColor: Colors.red,

              labelColor: Colors.black,
              unselectedLabelColor: Colors.black.withOpacity(0.5),
              tabs: [
                Tab(
                  text: "EXERCICES",
                ),
                Tab(
                  text: "COACHES",
                ),
                Tab(
                  text: "SALLE DU SPORT",
                  
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  //tab 1
                  SearchScreen(),

                  //tab2
                  SportifCoteCoach(),

                  //tab3
                  SportifCoteResponsable(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
