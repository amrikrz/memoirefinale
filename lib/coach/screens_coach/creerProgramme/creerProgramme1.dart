import 'package:flutter/material.dart';
import 'package:sportapplication/coach/screens_coach/creeProgram/creePlan.dart';
import 'package:sportapplication/coach/screens_coach/creerProgramme/ajouterNouveauProgramme.dart';

class EditProductScreen extends StatelessWidget {
  const EditProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Material(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10,),
                    child: Container(
                      child: Row(
                        children: [
                          Text('Programmes'),
                          SizedBox(
                            width: 10,
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.black54,
                            maxRadius: 8,
                            child: FittedBox(
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Text(
                                  '20',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  /*TextButton.icon(
                    style:ButtonStyle(backgroundColor:MaterialStateProperty.all(Colors.pink.shade200) ) ,
                    onPressed: () {Navigator.pushNamed(context, NouveauProgramme.id);},
                    icon: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    label: Text('Nouveau programme',style:TextStyle(color: Colors.white) ,),
                  )*/
                  ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AjoutePlanEntrainement()),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromRGBO(233, 61, 73, 96),
          ),
          child: const Text(
            'Ajouter un exercice',
            style: TextStyle(color: Colors.white),
          ),
        )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
