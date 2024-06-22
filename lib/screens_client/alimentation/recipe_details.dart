class RecipeModel {
  final String name;
  final String image;
  final String category;
  final String duration;
  final String calories;
  final String subtitle;
  final String pereUid;
  final String reccetteUid;
  final String uid;
  final String reccette;

  RecipeModel( 
      {required this.name,
      required this.image,
      required this.category,
      required this.duration,
      required this.calories,
      required this.subtitle,
        required this.reccetteUid,
        required this.pereUid,
        required this.uid,
        required this.reccette
      });
}

final trandingRecipes = [
  RecipeModel(
    name: 'Crêpes aux Fraises',
    image: 'assets/images/recette_crepes_1040_832.jpg',
    category: 'Sucré',
    duration: "20 min",
    calories:'119.36 kcal',
    subtitle: 'subtitle',
    uid: "",
    pereUid: "",
    reccetteUid: "",
    reccette: ""

  ),
  RecipeModel(
    name: 'Salade de poulet ranch',
    image: 'assets/images/salade_de_poulet_ranch.jpg',
    category: 'Salée',
    duration: "30 min",
    calories:'545 kcal',
    subtitle: 'subtitle',
      uid: "",
      pereUid: "",
      reccetteUid: "",
      reccette: ""
  ),
  RecipeModel(
    name: 'Poivrons farcis',
    image: 'assets/images/poivron-farcis-au-four.jpg',
    category: 'Salée',
    duration: "1h 25min",
    calories:'210 kcal',
      subtitle: 'subtitle',
      uid: "",
      pereUid: "",
      reccetteUid: "",
      reccette: ""

  ),
];

final lastestRecipes = [
RecipeModel(
    name: 'Crêpes aux Fraises',
    image: 'assets/images/compte.jpg',
    category: 'Sucré',
    duration: "20 min",
    calories:'25 kcal',
    subtitle: 'subtitle',
    uid: "",
    pereUid: "",
    reccetteUid: "",
    reccette: ""

),
  RecipeModel(
    name: 'Biscuits à la banane et à l\'avoine',
    image: 'assets/images/banana-oatmeal-cookies.jpg',
    category: 'Sucré',
    duration: "22 min",
    calories:'65 kcal',
      subtitle: 'subtitle',
      uid: "",
      pereUid: "",
      reccetteUid: "",
      reccette: ""

  ),
  RecipeModel(
    name: 'Recette de granola au pain aux bananes',
    image: 'assets/images/granulla.jpg',
    category: 'Sucré',
    duration: "25 min",
    calories:'221 kcal',
      subtitle: 'subtitle',
      uid: "",
      pereUid: "",
      reccetteUid: "",
      reccette: ""

  ),

];
