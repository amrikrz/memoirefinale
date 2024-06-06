import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class Exercise {
  final String nom;
  final String description;
  final String videoUrl;

  Exercise(
      {required this.nom, required this.description, required this.videoUrl});
}

class AddExercise extends StatefulWidget {
  final Function(Exercise) onAddExercise;
  const AddExercise({super.key, required this.onAddExercise});

  @override
  State<AddExercise> createState() => _AddExerciseState();
}

class _AddExerciseState extends State<AddExercise> {
  File? media;
  final ImagePicker _picker = ImagePicker();
  bool _isVideo = false;
  VideoPlayerController? _videoPlayerController;

  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String nom = '';
  String errorMessage = '';

  void _validate(String value) {
    if (RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
      setState(() {
        nom = value;
      });
    } else {
      _showMessage(
          'Le champ  contenir uniquement des caractères alphabétiques.');
    }
  }

  void pickvideoFromCamera() async {
    final XFile? photo = await _picker.pickVideo(source: ImageSource.camera);
    if (photo == null) return;
    setState(() {
      media = File(photo.path);
      _isVideo = true;
    });
    _videoPlayerController = VideoPlayerController.file(media!);
    try {
      await _videoPlayerController!.initialize();
      _videoPlayerController!.setLooping(true);
      _videoPlayerController!.play();
      _videoPlayerController!.setVolume(0.0);
    } catch (e) {
      print("Error initializing video : $e");
    }
  }

  void pickvideoFromGallery() async {
    final XFile? photo = await _picker.pickVideo(source: ImageSource.gallery);
    if (photo == null) return;
    setState(() {
      media = File(photo.path);
      _isVideo = true;
    });
    _videoPlayerController = VideoPlayerController.file(media!);
    _videoPlayerController!.initialize();
    _videoPlayerController!.setLooping(true);
    _videoPlayerController!.play();
  }

  void _showMessage(String message) {
    setState(() {
      errorMessage = message;
    });}
@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercice'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Column(
              children: [
                _isVideo
                    ? AspectRatio(
                        aspectRatio: _videoPlayerController!.value.aspectRatio,
                        child: VideoPlayer(_videoPlayerController!),
                      )
                    : Container(
                        height: 350,
                        child: media != null
                            ? Image.file(media!)
                            : const Center(child: Text('Vidéo'))),
                const SizedBox(height: 20),
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
                                hintText: "Nom d'Exercice",
                                enabled: true,
                                contentPadding: const EdgeInsets.only(
                                    left: 14.0, bottom: 8.0, top: 8.0),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                  controller: _nomController,
                  onChanged: (_) {
                    if (errorMessage.isNotEmpty) {
                      setState(() {
                        errorMessage = '';
                      });
                    }
                  },
                  onSubmitted: _validate,
                ),
                const SizedBox(height: 5),
                TextField(
                    decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                hintText: 'Description',
                                enabled: true,
                                contentPadding: const EdgeInsets.only(
                                    left: 14.0, bottom: 8.0, top: 8.0),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 50,
                  width: 400,
                  child: ElevatedButton(
                    onPressed: () {
                      pickvideoFromCamera();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(233, 61, 73, 96),
                    ),
child: const Text(
                      'Prendre un vidéo avec la caméra',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                SizedBox(
                  height: 50,
                  width: 400, 
                  child: ElevatedButton(
                    onPressed: () {
                      pickvideoFromGallery();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(233, 61, 73, 96),
                    ),
                    child: const Text(
                      'Ajouter un vidéo depuis galerie',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                SizedBox(
                  height: 50,
                  width: 400,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(233, 61, 73, 96),
                    ),
                    child: const Text(
                      'Ajouter un exercice depuis GymBuddy',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                SizedBox(
                  height: 50,
                  width: 400, 
                  child: ElevatedButton(
                    onPressed: () {
                      if (_nomController.text.isNotEmpty &&
                          _descriptionController.text.isNotEmpty &&
                          media != null) {
                        final newExercise = Exercise(
                          nom: _nomController.text,
                          description: _descriptionController.text,
                          videoUrl: media!.path,
                        );
                        widget.onAddExercise(newExercise);
                        Navigator.pop(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(233, 61, 73, 96),
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
        ),
      ),
    );
  }
}

