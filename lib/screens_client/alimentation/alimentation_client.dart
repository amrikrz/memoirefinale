import 'package:flutter/material.dart';
import 'package:sportapplication/screens_client/alimentation/recipe_details.dart';
import 'package:sportapplication/screens_client/alimentation/recipes_item.dart';
import 'package:sportapplication/shared/colors.dart';

class ClientAliment extends StatefulWidget {
  @override
  _ClientAlimentScreenState createState() => _ClientAlimentScreenState();
}

class _ClientAlimentScreenState extends State<ClientAliment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + 24,
          bottom: MediaQuery.of(context).padding.bottom + 24,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 24,
              ),
              child: Text(
                'Nutrition,',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: Colors.pink.shade600),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 24,
              ),
              child: Text(
                'Recettes d\'aliments sains et nutritifs',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            Container(
              margin: EdgeInsets.all(16),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Icon(Icons.search),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: Text(
                      'Chercher une recette',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 24,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recettes Tendance',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 8,
            ),
            SizedBox(
              height: 280,
              child: ListView.separated(
                itemCount: trandingRecipes.length,
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(
                  horizontal: 24,
                ),
                separatorBuilder: (_, __) {
                  return SizedBox(
                    width: 16,
                  );
                },
                itemBuilder: (context, index) {
                  final recipe = trandingRecipes[index];
                  return RecipesItem(recipe: recipe);
                },
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 24,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Dernières recettes',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 8,
            ),
            SizedBox(
              height: 280,
              child: ListView.separated(
                itemCount: lastestRecipes.length,
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(
                  horizontal: 24,
                ),
                separatorBuilder: (_, __) {
                  return SizedBox(
                    width: 16,
                  );
                },
                itemBuilder: (context, index) {
                  final recipe = lastestRecipes[index];
                  return RecipesItem(recipe: recipe);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
