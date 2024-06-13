

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ClientForm extends StatefulWidget {
  @override
  _FitnessFormState createState() => _FitnessFormState();
}

class _FitnessFormState extends State<ClientForm> {
  final _formKey = GlobalKey<FormState>();

  String height = '';
  String currentWeight = '';
  String targetWeight = '';
  String goal = '';
  String zone = '';
  String level = '';
  List<String> trainingDays = [];
  bool hasPain = false;
  String painSeverity = '';
  String painType = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fitness Form'),
      ),
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Votre hauteur actuel'),
                onSaved: (value) {
                  height = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Votre poids actuel'),
                onSaved: (value) {
                  currentWeight = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Poids ciblé'),
                onSaved: (value) {
                  targetWeight = value!;
                },
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Choisissez votre objectif'),
                items: ['Perdre du poids', 'Garder la forme', 'Construire du muscles']
                    .map((goal) => DropdownMenuItem(value: goal, child: Text(goal)))
                    .toList(),
                onChanged: (value) {
                  goal = value!;
                },
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Choisissez la zone'),
                items: ['Abdos', 'Jambes', 'Bras', 'Poitrine', 'Tout le corps']
                    .map((zone) => DropdownMenuItem(value: zone, child: Text(zone)))
                    .toList(),
                onChanged: (value) {
                  zone = value!;
                },
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Choisissez le niveaux'),
                items: [
                  'Débutant( e ) :2-15min :je veux commencer la formation',
                  'Intermédiaire : 15-45 min : je m\'entraine 1 a 2 fois par semaine',
                  'Avancé ( e ) : 45-1:45h : je m\'entraine plus de 5 fois par semaine',
                ].map((level) => DropdownMenuItem(value: level, child: Text(level)))
                    .toList(),
                onChanged: (value) {
                  level = value!;
                },
              ),
              Column(
                children: [
                  Text('Choisir un jour ou plus de formation:'),
                  ...['Dimanche', 'Lundi', 'Mardi', 'Mercredi', 'Jeudi', 'Vendredi', 'Samedi']
                      .map((day) => CheckboxListTile(
                            title: Text(day),
                            value: trainingDays.contains(day),
                            onChanged: (bool? selected) {
                              setState(() {
                                if (selected == true) {
                                  trainingDays.add(day);
                                } else {
                                  trainingDays.remove(day);
                                }
                              });
                            },
                          ))
                      .toList(),
                ],
              ),
              SwitchListTile(
                title: Text('Souffrez-vous de douleurs ?'),
                value: hasPain,
                onChanged: (bool value) {
                  setState(() {
                    hasPain = value;
                  });
                },
              ),
              if (hasPain) ...[
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(labelText: 'Quelle est la gravité de ta douleur ?'),
                  items: ['Pas si sérieux', 'Vraiment sérieux']
                      .map((severity) => DropdownMenuItem(value: severity, child: Text(severity)))
                      .toList(),
                  onChanged: (value) {
                    painSeverity = value!;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Quelle est la douleur ?'),
                  onSaved: (value) {
                    painType = value!;
                  },
                ),
              ],
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      FirebaseFirestore.instance.collection('Sportifs').add({
        'height': height,
        'currentWeight': currentWeight,
        'targetWeight': targetWeight,
        'goal': goal,
        'zone': zone,
        'level': level,
        'trainingDays': trainingDays,
        'hasPain': hasPain,
        'painSeverity': painSeverity,
        'painType': painType,
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Form Submitted')));
    }
  }
}
