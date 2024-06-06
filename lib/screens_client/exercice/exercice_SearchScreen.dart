import 'package:flutter/material.dart';
import 'package:sportapplication/screens_client/exercice/exercice1/exercice_ProductWidget.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              width: 350,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: Colors.grey.shade300,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 17),
                    width: 16,
                    height: 16,
                    child: Icon(
                      Icons.search_rounded,
                      size: 20,
                      color: Colors.grey.shade400,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 40,
                      child: TextField(
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(5, 5, 0, 5),
                          hintText: "Recherche tes exercice",
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.transparent,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.transparent,
                            ),
                          ),
                          disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: Colors.transparent,
                          )),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.transparent,
                            ),
                          ),
                          hintStyle: TextStyle(
                            color: Colors.grey.shade400,
                          ),
                        ),
                        style: TextStyle(
                          color: Colors.grey.shade300,
                          fontFamily: AutofillHints.birthday,
                          fontWeight: FontWeight.normal,
                          fontSize: 15,
                        ),
                        autocorrect: false,
                        obscureText: false,
                      ),
                    ),
                  ),
                  GestureDetector(
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(13),
                        ),
                        border: Border.all(
                          color: Colors.grey.shade300,
                        ),
                      ),
                      child: Icon(
                        Icons.filter_list_sharp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        for (final location in locations)
                          ItemsListWidget(
                            imageUrl: location.imageUrl,
                            name: location.nameExercice,
                            duree: location.duree,
                            nameId: location.nameId,
                            material:location.material,
                              video: location.videoUrl,
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}