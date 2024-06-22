import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:sportapplication/coach/controllers/add_exercice_provider.dart';
import 'package:sportapplication/coach/controllers/add_plan_exercice_provider.dart';
import 'package:sportapplication/coach/controllers/add_plan_provider.dart';
import 'package:sportapplication/coach/controllers/add_plan_reccette_provider.dart';
import 'package:sportapplication/coach/controllers/add_reccette_provider.dart';
import 'package:sportapplication/coach/screens_coach/edit/edit_things_screen.dart';
import 'package:sportapplication/coach/screens_coach/login_coach_screen.dart';
import 'package:sportapplication/coach/vendeur/vendeur_auth_screen.dart';
import 'package:sportapplication/coach/RegisterApresSignup/EntraineurRegistreScreen.dart';
import 'package:sportapplication/coach/screens_coach/creerProgramme/ajouterNouveauProgramme.dart';
import 'package:sportapplication/coach/vendeur/vendeur_auth_screen.dart';
import 'package:sportapplication/projects/home_client.dart';
import 'package:sportapplication/projects/image3.dart';
import 'package:sportapplication/projects/login.dart';
import 'package:sportapplication/projects/logo.dart';
import 'package:sportapplication/projects/role_selection.dart';
import 'package:sportapplication/projects/signup2.dart';
import 'package:sportapplication/projects/what_you_are.dart';
import 'package:sportapplication/screens_client/alimentation/alimentation_client.dart';
import 'package:sportapplication/screens_client/coach_partie_client/tab2.dart';
import 'package:sportapplication/screens_client/empty_cart_buy.dart';
import 'package:sportapplication/screens_client/exercice/produict_provider.dart';
import 'package:sportapplication/screens_client/exercice_client.dart';
import 'package:sportapplication/screens_client/homePage/dernieeArrivee/entrainneur/derniere_arrivee_entraineur.dart';
import 'package:sportapplication/screens_client/home_client2.dart';
import 'package:sportapplication/screens_client/inner_screens/favorite_page.dart';
import 'package:sportapplication/screens_client/inner_screens/produits_details.dart';
import 'package:sportapplication/screens_client/notification_screen.dart';
import 'package:sportapplication/screens_client/reli_cart_screen.dart';
import 'package:sportapplication/screens_client/statistique/statistique.dart';
import 'package:sportapplication/screens_salle/home_salle2.dart';
import 'package:sportapplication/screens_salle/loginResponsable.dart';
import 'package:sportapplication/shared/colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp( MyApp());
}



class MyApp extends StatelessWidget {
    Color _appBarColor = Colors.transparent;

   MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
                    

      providers: [
        ChangeNotifierProvider(create: (context) => ProductProvider()),

        ChangeNotifierProvider(create: (context) => MembersProvider()),
        ChangeNotifierProvider(create: (context) => AddReccetteProvider()),
        ChangeNotifierProvider(create: (context) => AddPlanReccetteProvider()),
        ChangeNotifierProvider(create: (context) => AddPlanExerciceProvider()),
        ChangeNotifierProvider(create: (context) => AddPlanProvider()),
        ChangeNotifierProvider(create: (context) => AddExerciceProvider()),
        //  ChangeNotifierProvider(create: (context) => EditProductScreen()),// Added MembersProvider
      
        
      ],
      child: MaterialApp(
        theme: ThemeData(

          colorScheme: ColorScheme.light().copyWith(
            primary: pink,
            background: Colors.white,
            
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: AuthStateListener(),
        builder: EasyLoading.init(),
        initialRoute: "/logo",
        routes: {
          '/logo': (context) => const MyLogo(),
          '/image3': (context) => const ImagesThree(),
          '/login_': (context) => LoginPage(),
          '/what_you_are': (context) => ChoisirWhatYouAre(),
          '/signup_client': (context) => ClientRegisterScreen(),
          '/responsableLogin': (context) => ResponsableLoginPage(),
          '/home_client': (context) => const ClientHome(),
          '/home_coach': (context) => CoachRegistrationScreen(),
          '/home_responsable': (context) => ResponsableHome(),
          '/clientAliment': (context) => ClientAliment(),
          '/exercice_salle_couch': (context) => const ClientExercice(),
          '/role_selection': (context) => RoleSelection(),
          '/home_client_2': (context) => SportifHome2(),
          '/cart_buy': (context) => EmptyCartWidget(onButtonPressed: () {}),
          '/notification': (context) => NotificationScreen(),
          '/cartpage': (context) => CartPage(),
          ProduitDetails.routeName: (context) => ProduitDetails(),
          FavoritePage.routeName: (context) => FavoritePage(),
          //'/edit_product': (context) => EditProductScreen(),

          '/vendorsAuth': (context) => VendorAuthScreen(),

         // '/RegisterPage': (context) => ResponsableAjouterClient(),
          '/vendorsAuth': (context) => LoginCoachScreen(),

          '/derniee_arrivee':(context)=>LastArrivalWidget(),
          '/sportifCoach':(context)=>SportifCoteCoach(),
          '/statistique':(context)=>Statistique(),
          NouveauProgramme.id:(context)=>NouveauProgramme(),


        },
      ),
    );
  }
}

class AuthStateListener extends StatefulWidget {
  const AuthStateListener({Key? key}) : super(key: key);

  @override
  _AuthStateListenerState createState() => _AuthStateListenerState();
}

class _AuthStateListenerState extends State<AuthStateListener> {

 var auth = FirebaseAuth.instance;
  var isLogin = false;

  @override
  void initState() {
    super.initState();
    auth.authStateChanges().listen((User? user) {
      if (user != null && mounted) {
        setState(() {
          isLogin = true;
        });
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:
            CircularProgressIndicator(), // Loading indicator while checking auth state
      ),
    );
  }
}
