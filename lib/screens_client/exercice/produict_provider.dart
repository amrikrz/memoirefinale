import 'package:flutter/material.dart';
import 'package:sportapplication/screens_client/inner_screens/category_prodect.dart';

class ProductProvider with ChangeNotifier {
  List<ProductModel> get getProducts {
    return _products;
  }
  List<ProductModel> getProductsForFirstExercise() {
    return _products.where((product) => product.productId == 'exerc1'|| product.productId == 'exercice2' || product.productId=="exercice3" || product.productId=='exercice4' ).toList();
  }
   List<ProductModel> getProductsForSecondExercise() {
    return _products.where((product) => product.productId != 'exerc1' && product.productId != 'exercice2' && product.productId!='exercice3' && product.productId!='exercice4').toList();
  }
  ProductModel? findByProdId(String productId) {
    if (_products.where((element) => element.productId == productId).isEmpty) {
      return null;
    }
    return _products.firstWhere((element) => element.productId == productId);
  }

  List<ProductModel> findByCategory({required String ctgName}) {
    List<ProductModel> ctgList = _products
        .where((element) => element.productCategory
            .toLowerCase()
            .contains(ctgName.toLowerCase()))
        .toList();

    return ctgList;
  }

  List<ProductModel> searchQuery(
      {required String searchText, required List<ProductModel> passedList}) {
    List<ProductModel> searchList = passedList
        .where((element) => element.productTitle
            .toLowerCase()
            .contains(searchText.toLowerCase()))
        .toList();
    return searchList;
  }

  final List<ProductModel> _products = [
    // Phones
    ProductModel(
  productId: 'exerc1',
  productTitle: "Exercice jambe",
  productPrice: "600",
  productCategory: "Jambe",
  productDescription: "Ce programme d'exercice jambe est créé par moi, le coach -nom coach- travaille avec le-s- salle-s- de sport. Il contient 15 exercices",
  productImage: "assets/videos/sport1.mp4",
  productCoachName: "Mansar A.",
  productLevel: "Débutant",
  productMaterial: "no material",
  
  productTime: '5 min',
  productVideo: 'assets/videos/sport1.mp4', productQuntity: '20', // Ensure productVideo is initialized
),

    ProductModel(
      //2

        
        productId: 'exercice2',
      productTitle: "Exercice bras",
      productPrice: "600",
      productCategory: "bras",
      productDescription:
          "6.1-inch Super Retina XDR display with ProMotion and always-on display. Dynamic Island, a new and magical way to interact with your iPhone. 48MP main camera for up to 4x higher resolution. Cinematic mode, now in 4K Dolby Vision up to 30 fps. Action mode, for stable and smooth videos when you're on the move. Accident detection, vital safety technology that calls for help for you. All-day battery life and up to 23 hours of video playback.",
      productImage: "assets/videos/sport1.mp4",
      productCoachName: " Mansar A.",
      productLevel: "Bigenner",
      productMaterial: "no material",
      
      productQuntity: '10',
      productTime: '9 min',
      productVideo:"assets/videos/sport1.mp4",
    ),
    ProductModel(
      //3
productId: 'exercice3',
      productTitle: "CURLER LES BICEPS",
      productPrice: "1399.99",
      productCategory: "bras",
      productDescription:
          "6.1-inch Super Retina XDR display with ProMotion and always-on display. Dynamic Island, a new and magical way to interact with your iPhone. 48MP main camera for up to 4x higher resolution. Cinematic mode, now in 4K Dolby Vision up to 30 fps. Action mode, for stable and smooth videos when you're on the move. Accident detection, vital safety technology that calls for help for you. All-day battery life and up to 23 hours of video playback.",
      productImage: "assets/videos/sport1.mp4",
      productCoachName: " Mansar A.",
      productLevel: "Bigenner",
      productMaterial: "no material",
      
      productQuntity: '10',
      productTime: '15 min',
      productVideo: 'assets/videos/sport1.mp4',
    ),
    ProductModel(
      //4
productId: 'exercice4',
      productTitle: "CURLER LES BICEPS",
      productPrice: "1399.99",
      productCategory: "Phones",
      productDescription:
          "6.1-inch Super Retina XDR display with ProMotion and always-on display. Dynamic Island, a new and magical way to interact with your iPhone. 48MP main camera for up to 4x higher resolution. Cinematic mode, now in 4K Dolby Vision up to 30 fps. Action mode, for stable and smooth videos when you're on the move. Accident detection, vital safety technology that calls for help for you. All-day battery life and up to 23 hours of video playback.",
      productImage: "assets/videos/sport1.mp4",
      productCoachName: " Mansar A.",
      productLevel: "Bigenner",
      productMaterial: "no material",
      
      productQuntity: '10',
      productTime: '15 min',
       productVideo: 'assets/videos/sport1.mp4',
    ),

    ProductModel(
      //4
productId: 'exercice5',
      productTitle: "CURLER LES BICEPS",
      productPrice: "1399.99",
        productCategory: "bras",
      productDescription:
          "6.1-inch Super Retina XDR display with ProMotion and always-on display. Dynamic Island, a new and magical way to interact with your iPhone. 48MP main camera for up to 4x higher resolution. Cinematic mode, now in 4K Dolby Vision up to 30 fps. Action mode, for stable and smooth videos when you're on the move. Accident detection, vital safety technology that calls for help for you. All-day battery life and up to 23 hours of video playback.",
      productImage: "assets/images/ex1.jpg",
      productCoachName: " Mansar A.",
      productLevel: "Bigenner",
      productMaterial: "no material",
      
      productQuntity: '10',
      productTime: '15 min',
       productVideo: 'assets/videos/sport1.mp4',
    ),

    ProductModel(
      //4
productId: 'exercice6',
      productTitle: "CURLER LES BICEPS",
      productPrice: "1399.99",
        productCategory: "bras",
      productDescription:
          "6.1-inch Super Retina XDR display with ProMotion and always-on display. Dynamic Island, a new and magical way to interact with your iPhone. 48MP main camera for up to 4x higher resolution. Cinematic mode, now in 4K Dolby Vision up to 30 fps. Action mode, for stable and smooth videos when you're on the move. Accident detection, vital safety technology that calls for help for you. All-day battery life and up to 23 hours of video playback.",
      productImage: "assets/images/ex1.jpg",
      productCoachName: " Mansar A.",
      productLevel: "Bigenner",
      productMaterial: "no material",
      
      productQuntity: '10',
      productTime: '15 min',
       productVideo: 'assets/videos/sport1.mp4',
    ),
    ProductModel(
      //4
productId: 'exercice7',
      productTitle: "CURLER LES BICEPS",
      productPrice: "1399.99",
      productCategory: "bras",
      productDescription:
          "6.1-inch Super Retina XDR display with ProMotion and always-on display. Dynamic Island, a new and magical way to interact with your iPhone. 48MP main camera for up to 4x higher resolution. Cinematic mode, now in 4K Dolby Vision up to 30 fps. Action mode, for stable and smooth videos when you're on the move. Accident detection, vital safety technology that calls for help for you. All-day battery life and up to 23 hours of video playback.",
      productImage: "assets/images/ex1.jpg",
      productCoachName: " Mansar A.",
      productLevel: "Bigenner",
      productMaterial: "no material",
      
      productQuntity: '10',
      productTime: '15 min',
       productVideo: 'assets/videos/sport1.mp4',
    ),
      ProductModel(
      //4
productId: 'exercice8',
      productTitle: "CURLER LES BICEPS",
      productPrice: "1399.99",
        productCategory: "bras",
      productDescription:
          "6.1-inch Super Retina XDR display with ProMotion and always-on display. Dynamic Island, a new and magical way to interact with your iPhone. 48MP main camera for up to 4x higher resolution. Cinematic mode, now in 4K Dolby Vision up to 30 fps. Action mode, for stable and smooth videos when you're on the move. Accident detection, vital safety technology that calls for help for you. All-day battery life and up to 23 hours of video playback.",
      productImage: "assets/images/ex1.jpg",
      productCoachName: " Mansar A.",
      productLevel: "Bigenner",
      productMaterial: "no material",
      
      productQuntity: '10',
      productTime: '15 min',
       productVideo: 'assets/videos/sport1.mp4',
    ),
    
    
  ];
}