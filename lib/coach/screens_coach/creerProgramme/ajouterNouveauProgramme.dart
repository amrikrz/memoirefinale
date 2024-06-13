import 'package:flutter/material.dart';
import 'package:sportapplication/coach/screens_coach/creerProgramme/categorie/categorie_liste.dart';

class NouveauProgramme extends StatefulWidget {
  const NouveauProgramme({super.key});
  static String id = 'ajouter-programme-page';

  @override
  State<NouveauProgramme> createState() => _NouveauProgrammeState();
}

class _NouveauProgrammeState extends State<NouveauProgramme> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1, // The number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: Text('Ajouter Programme'),
        ),
        body: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text('Programmes/ Ajouter'),
                    ),
                    TextButton.icon(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.pink.shade200),
                      ),
                      onPressed: () {},
                      icon: Icon(
                        Icons.save,
                        color: Colors.white,
                      ),
                      label: Text(
                        'Sauvegarder',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Card(
                    child: TabBarView(
                      children: [
                        ListView(
                          padding: EdgeInsets.all(10.0),
                          children: [
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Nom Programme*',
                                labelStyle: TextStyle(color: Colors.grey),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade300,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Description*',
                                labelStyle: TextStyle(color: Colors.grey),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade300,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            TextButton(
                              child: Text(
                                'faire exercice',
                                style: TextStyle(color: Colors.black),
                              ),
                              onPressed: () {},
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: SizedBox(
                                width: 150,
                                height: 150,
                                child: Card(
                                  child: Center(
                                    child: TextButton(
                                      child: Text(
                                        'Image /Logo',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      onPressed: () {},
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Prix*',
                                labelStyle: TextStyle(color: Colors.grey),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade300,
                                  ),
                                ),
                              ),
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'comparer le prix',
                                labelStyle: TextStyle(color: Colors.grey),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade300,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 20, bottom: 10),
                              child: Row(
                                children: [
                                  Text(
                                    'Catégorie',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        labelText: 'Non séléctionné',
                                        labelStyle: TextStyle(
                                          color: Colors.grey,
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.grey.shade300,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return categorie();
                                          });
                                    },
                                    icon: Icon(Icons.edit_outlined),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
