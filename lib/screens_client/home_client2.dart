import 'package:card_swiper/card_swiper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sportapplication/screens_client/exercice/app_constants.dart';
import 'package:sportapplication/screens_client/exercice/exercice1/exercice_ProductWidget.dart';
import 'package:sportapplication/screens_client/homePage/dernieeArrivee/Responsable/derniee_arrive_responsable.dart';
import 'package:sportapplication/screens_client/homePage/dernieeArrivee/entrainneur/derniere_arrivee_entraineur.dart';
import 'package:sportapplication/screens_client/homePage/bannerScreen.dart';
import 'package:sportapplication/screens_client/inner_screens/favorite_page.dart';
import 'package:sportapplication/shared/colors.dart';

class SportifHome2 extends StatelessWidget {
  const SportifHome2({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Colors.transparent,
                image: DecorationImage(
                  image: AssetImage("assets/images/backgroundcompte.jpg"),
                  fit: BoxFit.cover,
                ),
              ),

              //circle
              currentAccountPicture: CircleAvatar(
                radius: 55,
                backgroundImage: (AssetImage("assets/images/compte.jpg")),
              ),
              accountEmail: Text("ikramamara15@gmail.com"),
              accountName: Text("ikram"),
            ),

            //statistique
            Column(
              children: [
                ListTile(
                  title: Text("Statistique"),
                  leading: Icon(Icons.stacked_bar_chart),
                  onTap: () {},
                ),

                //exercice
                ListTile(
                  title: Text("Exercice"),
                  leading: Icon(Icons.fitness_center_outlined),
                  onTap: () {},
                ),

                //Couch et Salle
                ListTile(
                  title: Text("Couch et salle"),
                  leading: Icon(Icons.list_alt_sharp),
                  onTap: () {},
                ),

                //alimentation
                ListTile(
                  title: Text("Alimentation"),
                  leading: Icon(Icons.local_dining_outlined),
                  onTap: () {},
                ),

                //Mon profile
                ListTile(
                  title: Text("Mon profile"),
                  leading: Icon(Icons.account_circle),
                  onTap: () {},
                ),

                //Mes favorites
                ListTile(
                  title: Text("Mes favorites"),
                  leading: Icon(
                    Icons.favorite_outlined,
                    color: red,
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, FavoritePage.routeName);
                  },
                ),

                //contact support
                ListTile(
                  title: Text("Contact support"),
                  leading: Icon(Icons.contact_phone),
                  onTap: () {},
                ),

                //buy
                ListTile(
                  title: Text("Cart Buy"),
                  leading: Icon(Icons.credit_card_outlined),
                  onTap: () {
                    Navigator.pushReplacementNamed(context, '/cartpage');
                  },
                ),

                //logout
                ListTile(
                  title: Text("Log out"),
                  leading: Icon(Icons.logout_outlined),
                  onTap: () async {
                    await FirebaseAuth.instance.signOut();
                    Navigator.pushReplacementNamed(
                      context,
                      "/login_client",
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Row(
            children: [
              //notification
              Stack(
                children: [
                  Positioned(
                    bottom: 20,
                    child: Container(
                      decoration: BoxDecoration(
                        color: pink,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        "2",
                        style: TextStyle(fontSize: 15, color: black),
                      ),
                      padding: EdgeInsets.all(5),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/notification');
                    },
                    icon: Icon(
                      Icons.notifications,
                      size: 35.0,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),

              //cart
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.add_shopping_cart,
                      color: Colors.grey[500], size: 35),
                ),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height * 0.24,
                child: Swiper(
                  itemBuilder: (context, index) {
                    return Container(
                      child: PubliciteAccueil(),
                    );
                  },
                  itemCount: AppConstants.bannersImages.length,
                  autoplay: true,
                  pagination: SwiperPagination(
                    alignment: Alignment.bottomCenter,
                    builder: DotSwiperPaginationBuilder(
                      color: Colors.black,
                      activeColor: white,
                      size: 5,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 18,
              ),
              Text(
                'Dernière arrivée',
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Les Entraineurs :',
                style: TextStyle(
                  fontSize: 15,
                  color: gray,
                ),
              ),
              Container(
                height: 170,
                child: LastArrivalWidget(),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Les salles du sport :',
                style: TextStyle(
                  fontSize: 15,
                  color: gray,
                ),
              ),
              Container(
                height: 170,
                child: LastArrivalWidgetResponsable(),
              ),
              Text(
                'Categories',
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
              SizedBox(
                height: 15,
              ),
          
              SizedBox(
                height: 5,
              ),
              Text(
                'Alimentations',
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [

                    
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
