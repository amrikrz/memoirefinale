import 'package:flutter/material.dart';
import 'package:sportapplication/coach/screens_coach/edit/edit_things_screen.dart';
import 'package:sportapplication/screens_salle/ajouter_salle/ajouterClient.dart';
import 'package:sportapplication/screens_salle/ajouter_salle/ajouterEntraineur.dart';
import 'package:sportapplication/screens_salle/ajouter_salle/ajouterEquipement.dart';
import 'package:sportapplication/screens_salle/list_demande_clients.dart';
import 'package:sportapplication/screens_salle/list_demandes_coach.dart';

class DemandesScreen extends StatelessWidget {
  const DemandesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text("Participent Invitation"),
        ),
        ),
        body: Column(
          children: [
            TabBar(
              dividerHeight: 0,
              indicatorColor: Colors.red,indicatorSize: TabBarIndicatorSize.tab,
              indicatorPadding: EdgeInsets.symmetric(horizontal: 10),
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(color: Colors.red, width: 4.0),
                insets: EdgeInsets.symmetric(horizontal: 16.0),
              ),

              unselectedLabelColor: Colors.black.withOpacity(0.5),

              tabs: [
                  Tab(
                  text: "Sportif",
                ),
                Tab(
                  text: "Entraineurs",
                ),

              
            ]),
             Expanded(
              child: TabBarView(
                children: [
                  //tab 1
                  ListDemandeClients(),

                  //tab2
                  ListDemandesCoach(),

                  //tab3
                 // ResponsableAjouterEquipement(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}