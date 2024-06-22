import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sportapplication/coach/models/reccete_plan_object.dart';
import 'package:sportapplication/coach/screens_coach/edit/reccetes_plan_item_screen.dart';
import 'package:sportapplication/screens_client/alimentation/recipe_details.dart';
import 'package:sportapplication/shared/colors.dart';

class RecipesPlanItemWidget extends StatelessWidget {
  final ReccetePlanObject recipe;
  final bool coach ;
  const RecipesPlanItemWidget({super.key, required this.recipe,this.coach = true});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: GestureDetector(
        onTap: (){
          Navigator.push(context, CupertinoPageRoute(builder: (context)=>ReccetesPlanItemScreen(planUid: recipe.pereUid,reccetteUid: recipe.uid,coach: coach,)));
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
                        recipe.title,
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
                                    recipe.subtitle,
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
                                    "",
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
      ),
    );
  }
}
