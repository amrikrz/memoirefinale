
import 'package:flutter/material.dart';
import 'package:sportapplication/coach/screens_coach/creeProgram/addExercice.dart';
import 'package:video_player/video_player.dart';

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
                  color: Colors.white,
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
