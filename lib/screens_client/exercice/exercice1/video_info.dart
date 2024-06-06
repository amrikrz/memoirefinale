/*import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sportapplication/screens_client/exercice/produict_provider.dart';
import 'package:sportapplication/screens_client/inner_screens/category_prodect.dart';
import 'package:sportapplication/shared/colors.dart';

class VideoInfo extends StatefulWidget {
  final String productId;

  const VideoInfo({super.key, required this.productId, required String name, required String duree, required String imageUrl, required String nameId});

  @override
  State<VideoInfo> createState() => _VideoInfoState();
}

class _VideoInfoState extends State<VideoInfo> {
  bool _playArea = false;

  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider = Provider.of<ProductProvider>(context, listen: false);
    ProductModel? product = productProvider.findByProdId(widget.productId);
    
    if (product == null) {
      return Scaffold(
        body: Center(
          child: Text("Product not found"),
        ),
      );
    }

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
          children: [
            _playArea == false
                ? Container(
                    padding: EdgeInsets.only(top: 70, left: 30, right: 30),
                    width: MediaQuery.of(context).size.width,
                    height: 300,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                              
                              child: InkWell(
                                onTap: () {
                                  
                                },
                                child: Icon(
                                  Icons.arrow_back_ios,
                                  size: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 30),
                        Text(product.productTitle, style: TextStyle(fontSize: 25, color: Colors.white)),
                        SizedBox(height: 5),
                        Text(product.productLevel, style: TextStyle(fontSize: 25, color: Colors.white)),
                        SizedBox(height: 50),
                        Row(
                          children: [
                            Container(
                              width: 90,
                              height: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(
                                  colors: [Colors.pink.shade200, Colors.pink.shade200],
                                  begin: Alignment.bottomLeft,
                                  end: Alignment.topRight,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.timer, size: 20, color: Colors.white),
                                  SizedBox(width: 5),
                                  Text(product.productTime, style: TextStyle(fontSize: 16, color: Colors.white)),
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
                                  colors: [Colors.pink.shade200, Colors.pink.shade200],
                                  begin: Alignment.bottomLeft,
                                  end: Alignment.topRight,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.fitness_center_rounded, size: 20, color: Colors.white),
                                  SizedBox(width: 5),
                                  Text(product.productMaterial, style: TextStyle(fontSize: 16, color: Colors.white)),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  )
                : Container(
                    width: 200,
                    height: 100,
                    color: Colors.amber,
                  ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topRight: Radius.circular(70)),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 30),
                    Row(
                      children: [
                        SizedBox(width: 30),
                        Text(
                          "Circuit 1 : ${product.productCategory}",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                        SizedBox(width: 30),
                        Row(
                          children: [
                            Icon(Icons.loop, size: 30, color: Colors.pink),
                            SizedBox(width: 10),
                            Text(
                              '4 ensembles',
                              style: TextStyle(fontSize: 15, color: Colors.pink),
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                        itemCount: 1, // Only one product in detail view
                        itemBuilder: (_, int index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _playArea = !_playArea;
                              });
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
                                            image: AssetImage(product.productImage),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(product.productTitle, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                          SizedBox(height: 10),
                                          Padding(
                                            padding: EdgeInsets.only(top: 3),
                                            child: Text(product.productTime, style: TextStyle(color: Colors.grey[500])),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 18),
                                  Row(
                                    children: [
                                      Container(
                                        width: 150,
                                        height: 20,
                                        decoration: BoxDecoration(
                                          color: Colors.pink.shade50,
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Center(
                                          child: Text("15s de repos"),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          for (int i = 0; i < 70; i++)
                                            i.isEven
                                                ? Container(
                                                    width: 3,
                                                    height: 1,
                                                    decoration: BoxDecoration(color: Colors.pink, borderRadius: BorderRadius.circular(2)),
                                                  )
                                                : Container(
                                                    width: 3,
                                                    height: 1,
                                                    color: Colors.white,
                                                  ),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}*/