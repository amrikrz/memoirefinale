import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sportapplication/coach/models/coach_user_models.dart';
import 'package:sportapplication/screens_client/homePage/dernieeArrivee/entrainneur/dernieeArriveeEntraineur_controller.dart';

class LastArrivalWidget extends StatelessWidget {
  const LastArrivalWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: DernieearriveeController().DernieeArrive(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        final docs = snapshot.data?.docs ?? [];
        return Column(
          children:[ Container(
            child: Flexible(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: docs.length,
                itemBuilder: (BuildContext context, int index) {
                  final document = docs[index];
                  final data = document.data() as Map<String, dynamic>;
                  final coach = CoachUserModel.fromJson(data);
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.0),
                    child: Container(
                      width: 80,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 100,
                            height: 100,
                            child: Card(
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(4),
                                    child: Image.network(
                                      document['storeImage'],
                                      fit: BoxFit.cover,
                                    ))),
                          ),
                          Container(
                            height: 35,
                            child: Text(
                              document['businessName'],
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          ],
        );
      },
    );
  }
}
