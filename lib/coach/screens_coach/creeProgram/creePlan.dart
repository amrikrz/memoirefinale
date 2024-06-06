
import 'package:flutter/material.dart';
import 'package:sportapplication/coach/screens_coach/creeProgram/addExercice.dart';
import 'package:video_player/video_player.dart';

class PlanEnterainement {
  final String nom;
  final String Objectif;
  final double Prix;
  final String alimentation;
  final List<Exercise> exercice;
  PlanEnterainement(
      {required this.nom,
      required this.Objectif,
      required this.Prix,
      required this.alimentation,
      required this.exercice});
}

class AjoutePlanEntrainement extends StatefulWidget {
  const AjoutePlanEntrainement({super.key});

  @override
  State<AjoutePlanEntrainement> createState() => _AjoutePlanEntrainement();
}

class _AjoutePlanEntrainement extends State<AjoutePlanEntrainement> {
  final List<Exercise> exercis = [];

  late TextEditingController nameController = TextEditingController();
  late TextEditingController _objectifController = TextEditingController();
  late TextEditingController _prixController = TextEditingController();

  String nom = '';
  String objectif = '';
  double prix = 0.0;
  String errorMessage = '';
  void addExercise(Exercise exercise) {
    setState(() {
      exercis.add(exercise);
    });
  }

  void _showMessage(String message) {
    setState(() {
      errorMessage = message;
    });
  }

  void _validate(String value) {
    if (RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
      setState(() {
        nom = value;
      });
    } else {
      _showMessage(
          'Le champ  contenir uniquement des caractères alphabétiques.');
    }
  }

  void _validatePrix(String value) {
    double? parsedPrix = double.tryParse(value);
    if (parsedPrix != null) {
      setState(() {
        prix = parsedPrix;
      });
    } else {
      _showMessage('Le prix doit être un nombre valide');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Créer un PlanEntrainement'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 10),
              Visibility(
                visible: errorMessage.isNotEmpty,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    errorMessage,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Nom de PlanEntrainement',
                  enabled: true,
                  contentPadding:
                      const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                controller: nameController,
                onChanged: (_) {
                  if (errorMessage.isNotEmpty) {
                    setState(() {
                      errorMessage = '';
                    });
                  }
                },
                onSubmitted: _validate,
              ),
              const SizedBox(height: 10),
              TextField(
                  decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                hintText: 'Objectif de PlanEntrainement',
                                enabled: true,


contentPadding: const EdgeInsets.only(
                                    left: 14.0, bottom: 8.0, top: 8.0),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                controller: _objectifController,
                onChanged: (_) {
                  if (errorMessage.isNotEmpty) {
                    setState(() {
                      errorMessage = '';
                    });
                  }
                },
                onSubmitted: _validate,
              ),
              const SizedBox(height: 10),
              TextField(
                  decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                hintText: 'Prix de PlanEntrainement',
                                enabled: true,
                                contentPadding: const EdgeInsets.only(
                                    left: 14.0, bottom: 8.0, top: 8.0),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                controller: _prixController,
                keyboardType: TextInputType.number,
                onChanged: (_) {
                  if (errorMessage.isNotEmpty) {
                    setState(() {
                      errorMessage = '';
                    });
                  }
                },
                onSubmitted: _validatePrix,
              ),
              const SizedBox(height: 10),
              const TextField(
                maxLines: 3,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Programme d'alimentation",
                  enabled: true,
                  contentPadding:
                      const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Exercices',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: 500,
                height: 200,
                child: ListView.builder(
                  itemCount: exercis.length,
                  itemBuilder: (context, index) {
                    return ExerciseCard(
                      exercise: exercis[index],
                      index: index + 1,
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 50,
                      width: 400,

child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  AddExercise(onAddExercise: addExercise),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromRGBO(233, 61, 73, 96),
                        ),
                        child: const Text(
                          'Ajouter un exercice',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 50,
                      width: 400,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromRGBO(233, 61, 73, 96),
                        ),
                        child: const Text(
                          'Save',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}

class ExerciseCard extends StatefulWidget {
  final Exercise exercise;
  final int index;

  ExerciseCard({required this.exercise, required this.index});

  @override
  _ExerciseCardState createState() => _ExerciseCardState();
}

class _ExerciseCardState extends State<ExerciseCard> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.exercise.videoUrl)
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(10),
      child: ListTile(
        leading: Container(
          width: 50.0,
          height: 50.0,
          child: _controller.value.isInitialized
              ? VideoPlayer(_controller)
              : Container(
                  color: Colors.grey,
                ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Exercice ${widget.index} :${widget.exercise.nom}'),
            Text('${widget.exercise.description}'),
          ],
        ),
      ),
    );
  }
}
