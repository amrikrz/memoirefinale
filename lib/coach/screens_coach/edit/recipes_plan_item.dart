import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sportapplication/coach/screens_coach/edit/reccetes_plan_item_screen.dart';
import 'package:sportapplication/screens_client/alimentation/recipe_details.dart';
import 'package:sportapplication/shared/colors.dart';

import '../reccette_view.dart';

class RecipesPlanItem extends StatelessWidget {
  final RecipeModel recipe;
  const RecipesPlanItem({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, CupertinoPageRoute(builder: (context)=>ReccetteView(title: recipe.name,desc: recipe.subtitle,duration: recipe.duration,calories: recipe.calories,link: recipe.image, reccette: recipe.reccette,)));
      },
      child: SizedBox(
        height: 280,
        child: Stack(
          children: [
            Container(
              height: 280,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  image: NetworkImage(
                    recipe.image,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: 8,
              left: 8,
              //a glass effect
              child: ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 5,
                    sigmaY: 5,
                  ),
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      recipe.category,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: white,
                          ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 8,
              left: 8,
              right: 8,
              //a glass effect
              child: ClipRRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 5,
                    sigmaY: 5,
                  ),
                  child: Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  recipe.name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(color: white),
                                      maxLines: 2,
                                ),
                              ),
                              SizedBox(width:16 ,),

                            ],
                          ),
                          SizedBox(height: 8,),
                          Text(
                                  "${recipe.duration} |   ${recipe.calories}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(color: white),
                                      maxLines: 2,
                                ),
                        ],
                      )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
