
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_login_buttons/social_login_buttons.dart';
import 'package:sportapplication/auth_controller.dart';
import 'package:sportapplication/coach/RegisterApresSignup/EntraineurRegistreScreen.dart';
import 'package:sportapplication/projects/home_client.dart';
import 'package:sportapplication/projects/home_salle.dart';
import 'package:sportapplication/projects/signup2.dart';
import 'package:sportapplication/screens_salle/home_salle2.dart';
import 'package:sportapplication/screens_salle/signupResponsable.dart';
import 'package:sportapplication/shared/colors.dart';
import 'package:sportapplication/show_snackbar.dart';

import '../vendeur/screens/landing_screen.dart';

class LoginCoachScreen extends StatefulWidget {
  @override
  _LoginCoachScreen createState() => _LoginCoachScreen();
}

class _LoginCoachScreen extends State<LoginCoachScreen> {
  bool _isObscure3 = true;
  //bool visible = false;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  late String email;
  late String password;

  bool _isLoading = false;

  final AuthController _authController = AuthController();

  _loginUsers2() async {
    setState(() {
      _isLoading = true;
    });
    if (_formkey.currentState!.validate()) {
      email = emailController.text; // Retrieve email from the controller
      password = passwordController.text; // Retrieve password from the controller
      String res = await _authController.loginUsers(email, password); // Pass email and password to loginUsers

      if (res == 'succès') {


        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('userId', FirebaseAuth.instance.currentUser!.uid);
        await prefs.setString('role', "coach");


        return Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (BuildContext context) {
              return  LandingScreen();
            }),(route)=>false);
      } else {
        setState(() {
          _isLoading = false;
        });
        return showSnackBa(context, res); // Show the error message from loginUsers
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      return showSnackBa(context, 'les champs ne peuvent pas être vides');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(

        elevation: 0,
        toolbarHeight: 100,


        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage("assets/images/login_background.png"),
                ),
              ),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Center(
                child: Container(
                  margin: EdgeInsets.all(12),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Login",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: black,
                            fontSize: 36,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 60,
                          child: Center(
                            child: Text(
                              "Entrez votre e-mail et mot de passe\n          comme un responsable",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: Colors.grey[500],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          width: 334,
                          height: 60,
                          child: TextFormField(
                            controller: emailController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Email',
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
                            onChanged: (value) {
                              email = value;
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Email cannot be empty";
                              }
                              if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                  .hasMatch(value)) {
                                return ("Please enter a valid email");
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          width: 334,
                          height: 60,
                          child: TextFormField(
                            controller: passwordController,
                            obscureText: _isObscure3,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  icon: Icon(_isObscure3
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                  onPressed: () {
                                    setState(() {
                                      _isObscure3 = !_isObscure3;
                                    });
                                  }),
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Password',
                              enabled: true,
                              contentPadding: const EdgeInsets.only(
                                  left: 14.0, bottom: 8.0, top: 15.0),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            onChanged: (value) {
                              password = value;
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'password must not be empty ';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        //forget mot de passe
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'Mot de passe oublié ?',
                                style: TextStyle(
                                    color: Color.fromRGBO(36, 36, 36, 0.5)),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10,),
                        InkWell(
                          onTap: () {
                            _loginUsers2();
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width - 40,
                            height: 46,
                            decoration: BoxDecoration(
                              color: pink,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: _isLoading
                                  ? Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: CircularProgressIndicator(
                                                                    color: white,
                                                                  ),
                                  )
                                  : Text(
                                "S'identifier",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Divider(
                                  thickness: 0.5,
                                  color: Colors.grey[400],
                                ),
                              ),
                              Padding(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                                child: Text(
                                  "ou continuer avec ",
                                  style: TextStyle(color: Colors.grey[500]),
                                ),
                              ),
                              Expanded(
                                child: Divider(
                                  thickness: 1,
                                  color: Colors.grey[400],
                                ),
                              ),
                            ],
                          ),
                        ),

                        //facebook
                        SizedBox(height: 10),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: SocialLoginButton(
                            backgroundColor: blue,
                            height: 50,
                            text: '    Sign up avec Facebook',
                            borderRadius: 20,
                            fontSize: 17,
                            buttonType: SocialLoginButtonType.generalLogin,
                            imageWidth: 25,
                            imagePath: "assets/icons/fecbook.png",
                            onPressed: () {},
                          ),
                        ),

                        //google
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: SocialLoginButton(
                            backgroundColor: Colors.white,
                            height: 50,
                            text: '    Sign up avec Google',
                            textColor: black,
                            borderRadius: 20,
                            fontSize: 17,
                            buttonType: SocialLoginButtonType.generalLogin,
                            imageWidth: 25,
                            imagePath: "assets/icons/google_icon.png",
                            onPressed: () {},
                          ),
                        ),

                        //signup
                        SizedBox(height: 60),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Vous n\'avez pas de compte ?',
                              style: TextStyle(color: Colors.black),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: ((context) {
                                    return CoachRegistrationScreen();
                                  })),
                                );
                              },
                              child: Text(
                                ' Sign Up ',
                                style: TextStyle(
                                  color: Color.fromRGBO(233, 61, 73, 0.8),
                                ),
                              ),
                            ),
                          ],
                        ),


                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}