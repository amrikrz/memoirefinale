import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sportapplication/screens_client/exercice/produict_provider.dart';
import 'package:sportapplication/screens_client/inner_screens/category_prodect.dart';
import 'package:video_player/video_player.dart';

class ExerciseDetailScreen extends StatefulWidget {
  final String productId;
  final String name;
  final String duree;
  final String imageUrl;
  final String material;
  final bool isFirstExercise;
  final String videoUrl;

  const ExerciseDetailScreen({
    Key? key,
    required this.name,
    required this.duree,
    required this.imageUrl,
    required this.material,
    required this.productId,
    required this.isFirstExercise,
    required this.videoUrl,
  }) : super(key: key);

  @override
  State<ExerciseDetailScreen> createState() => _ExerciseDetailScreenState();
}

class _ExerciseDetailScreenState extends State<ExerciseDetailScreen> {
  late VideoPlayerController _controller;
  late List<ProductModel> products;
  bool _playArea = false;

  @override
  void initState() {
    super.initState();
    // Initialize the video controller with the provided video URL
    _controller = VideoPlayerController.asset(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get the list of products based on isFirstExercise flag
    products = widget.isFirstExercise
        ? Provider.of<ProductProvider>(context).getProductsForFirstExercise()
        : Provider.of<ProductProvider>(context).getProductsForSecondExercise();

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.pink.shade500.withOpacity(0.9),
              Colors.pink.shade100,
            ],
            begin: FractionalOffset(0.0, 0.4),
            end: Alignment.topRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(top: 70, left: 30, right: 30),
              width: MediaQuery.of(context).size.width,
              height: 300,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Icon(
                          Icons.arrow_back_ios,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Text(
                    widget.name,
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                  SizedBox(height: 5),
                  Text(
                    widget.duree,
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                  SizedBox(height: 50),
                  Row(
                    children: [
                      Container(
                        width: 90,
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                            colors: [
                              Colors.pink.shade200,
                              Colors.pink.shade200,
                            ],
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.timer,
                              size: 20,
                              color: Colors.white,
                            ),
                            SizedBox(width: 5),
                            Text(
                              widget.duree,
                              style: TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 20),
                      Container(
                        width: 210,
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                            colors: [
                              Colors.pink.shade200,
                              Colors.pink.shade200,
                            ],
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.fitness_center_rounded,
                              size: 20,
                              color: Colors.white,
                            ),
                            SizedBox(width: 5),
                            Text(
                              widget.material,
                              style: TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(70),
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 30),
                    Row(
                      children: [
                        SizedBox(width: 30),
                        Text(
                          widget.name,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(width: 35),
                        Row(
                          children: [
                            Icon(
                              Icons.loop,
                              size: 30,
                              color: Colors.pink,
                            ),
                            SizedBox(width: 10),
                            Text(
                              '4 ensemble',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.pink,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 20),
                      ],
                    ),
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                        itemCount: products.length,
                        itemBuilder: (_, int index) {
                          if (index < products.length) {
                            return GestureDetector(
                              onTap: () {
                                _onTapVideo(index); // Start playing video on tap
                              },
                              child: Container(
                                height: 135,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: 80,
                                          height: 80,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            image: DecorationImage(
                                              image: AssetImage(products[index].productImage),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              products[index].productTitle,
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            Padding(
                                              padding: EdgeInsets.only(top: 3),
                                              child: Text(
                                                products[index].productTime,
                                                style: TextStyle(color: Colors.grey[500]),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 18),
                                    Row(
                                      children: [
                                        Container(
                                          width: 95,
                                          height: 20,
                                          decoration: BoxDecoration(
                                            color: Colors.pink.shade50,
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: Center(
                                            child: Text(
                                              '15s de repos',
                                              style: TextStyle(color: Colors.pink.shade300),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Row(
                                          children: [
                                            for (int i = 0; i < 70; i++)
                                              i.isEven
                                                  ? Container(
                                                      width: 3,
                                                      height: 1,
                                                      decoration: BoxDecoration(
                                                        color: Colors.pink.shade200,
                                                        borderRadius: BorderRadius.circular(2),
                                                      ),
                                                    )
                                                  : Container(
                                                      width: 3,
                                                      height: 1,
                                                      color: Colors.white,
                                                    ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          } else {
                            debugPrint("Invalid index: $index");
                            return SizedBox();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onTapVideo(int index) {
    if (index < products.length) {
      _controller.pause(); // Pause current video if playing

      // Initialize or update the video player controller with the selected video
      _controller = VideoPlayerController.asset(products[index].productImage)
        ..initialize().then((_) {
          setState(() {
            _playArea = true; // Update UI to indicate video playback area is active
          });
          _controller.play(); // Start playing the new video
        });

      // Set a listener for when the video finishes playing
      _controller.addListener(() {
        if (_controller.value.isPlaying && !_controller.value.isLooping) {
          setState(() {
            _playArea = false; // Update UI when video playback ends
          });
        }
      });
    } else {
      debugPrint("Invalid index: $index");
    }
  }
}
