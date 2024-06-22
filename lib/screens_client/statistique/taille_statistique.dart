import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sportapplication/screens_client/statistique/statistique_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';


class TailleStatistique extends StatefulWidget {
  @override
  _TailleStatistique createState() => _TailleStatistique();
}

class _TailleStatistique extends State<TailleStatistique> with AutomaticKeepAliveClientMixin{
  List<StatistiqueModel> _weights = [];
  TextEditingController _weightController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  Future<void> addData(String taille,String date) async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String uid =  prefs.getString('userId')??"";

   FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
   Map<String,dynamic> data = {
     "date":date,
     "value":taille
   };
   await firebaseFirestore.collection("Sportifs").doc(uid).collection("Tailles").add(data);
   setState(() {
     _weights.add(StatistiqueModel(date: date,value: taille));

   });
  }

  Future<void> getData() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String uid =  prefs.getString('userId')??"";

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    QuerySnapshot<Map<String,dynamic>> data = await firebaseFirestore.collection("Sportifs").doc(uid).collection("Tailles").get();

    for (var element in data.docs) {
      _weights.add(StatistiqueModel(date:element['date'],value:  element['value']));
    }
    setState(() {
      isLoading = false;
    });
  }

  bool isLoading = true;

  void _addWeight() {

      addData(_weightController.text, DateTime.now().day.toString()+"/"+DateTime.now().month.toString());
      _weightController.clear();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,

        forceMaterialTransparency: true,
        title: Text('Tailles Tracker'),
        actions: [
          IconButton(onPressed: (){
            showDialog(context: context, builder: (context)=>AlertDialog(

              title: Text("Taille"),
              content: Container(
                width: MediaQuery.of(context).size.width*0.85,
                child: TextField(
                  controller: _weightController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    suffixText: "CM",
                    labelText: 'Enter votre Taille',
                    border: OutlineInputBorder(
                    ),
                  ),
                ),
              ),
              actions: [
                TextButton(onPressed: (){
                  Navigator.pop(context);
                }, child: Text("CANCELL",style: TextStyle(color: Colors.black),)),
                TextButton(onPressed: (){
                  _addWeight();
                  Navigator.pop(context);
                }, child: Text("AJOUTER",style: TextStyle(color:Colors.green),)),
              ],
            ));
          }, icon: Icon(Icons.add))
        ],
      ),
      body: isLoading?const Center(
        child: CircularProgressIndicator(),
      ):Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [

            SizedBox(height: 20),
            Expanded(
              child: SfCartesianChart(
                primaryXAxis: CategoryAxis(
                  interval: 1,
                  title: AxisTitle(text: 'JOURS / MOIS'),
                ),
                primaryYAxis: NumericAxis(
                  title: AxisTitle(text: 'Tailles'),
                ),
                series:[
                  LineSeries<StatistiqueModel, String>(
                    dataSource: _weights,
                    xValueMapper: (StatistiqueModel weight, _) => weight.date,
                    yValueMapper: (StatistiqueModel weight, _) => double.parse(weight.value),
                    dataLabelSettings: DataLabelSettings(isVisible: true),
                    color: Colors.orange,
                    markerSettings: MarkerSettings(
                      isVisible: true,
                      color: Colors.orange,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),

    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}



