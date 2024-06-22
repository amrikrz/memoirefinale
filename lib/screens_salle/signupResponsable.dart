import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sportapplication/screens_salle/auth_controller_responsable.dart';
import 'package:sportapplication/screens_salle/loginResponsable.dart';
import 'package:sportapplication/shared/colors.dart';
import 'package:sportapplication/show_snackbar.dart';

class ResponsableRegisterScreen extends StatefulWidget {
  @override
  _ResponsableRegisterScreenState createState() =>
      _ResponsableRegisterScreenState();
}

class _ResponsableRegisterScreenState extends State<ResponsableRegisterScreen> {
  bool _isLoading = false;
  late String nom;
  late String DateNais;
  late String email;
  late String password;
  late String telephone;
  late String Gendre;

  final AuthController2 _authController = AuthController2();

  final TextEditingController nam = TextEditingController();
  final TextEditingController mobile = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController location_controller = TextEditingController();

  bool _isObscure = true;
  Uint8List? _image;


  var rool2 = "Homme";

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();



  _signupUsers2() async {
    setState(() {
      _isLoading = true;
    });
    if (_formKey.currentState!.validate()) {
      debugPrint("i'm here");
      await _authController
          .signupUsers2(
              nam.text, mobile.text, email, passwordController.text, _image,location_controller.text)
          .then((value) {
        setState(() {
          _isLoading = false;
        });
        showSnackBa(context, value);
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      showSnackBa(context, 'Le champ ne doit pas être vide');
    }
  }

  selectGalleryImage() async {
    Uint8List im = await _authController.pickProfileImage2(ImageSource.gallery);

    setState(() {
      _image = im;
    });
  }

  selectCameraImage() async {
    Uint8List im = await _authController.pickProfileImage2(ImageSource.camera);

    setState(() {
      _image = im;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage("assets/images/login_background.png"),
          ),
        ),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: SingleChildScrollView(
                    child: Container(
                      margin: EdgeInsets.all(12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.06,
                          ),
                          Text(
                            "Sign up",
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: black,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Stack(
                            children: [
                              _image != null
                                  ? CircleAvatar(
                                      radius: 64,
                                      backgroundColor: pink,
                                      backgroundImage: MemoryImage(_image!),
                                    )
                                  : GestureDetector(
                                    onTap:(){
                                      selectGalleryImage();
                                    },
                                    child: CircleAvatar(
                                        radius: 64,
                                        backgroundColor: pink,
                                        backgroundImage: NetworkImage(
                                            'https://t4.ftcdn.net/jpg/00/64/67/63/360_F_64676383_LdbmhiNM6Ypzb3FM4PPuFP9rHe7ri8Ju.jpg'),
                                      ),
                                  ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            width: 334,
                            height: 60,
                            child: TextFormField(
                              controller: nam,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                hintText: 'Nom du Salle',
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
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Nom ne peut pas être vide";
                                }
                                if (!RegExp("^[a-zA-Z]").hasMatch(value)) {
                                  return "Veuillez entrer un nom valide";
                                } else {
                                  return null;
                                }
                              },
                              onChanged: (value) {
                                nom = value;
                              },
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            width: 334,
                            height: 60,
                            child: TextFormField(
                              controller: mobile,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                filled: true,
                                 fillColor: Colors.white,
                                hintText: 'Numero du Salle',
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
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Nom ne peut pas être vide";
                                }
                                else {
                                  return null;
                                }
                              },
                              onChanged: (value) {
                              },
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            width: 334,
                            height: 60,
                            child: TextFormField(
                              controller: location_controller,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                hintText: 'Location du Salle',
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
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Location ne peut pas être vide";
                                }
                                if (!RegExp("^[a-zA-Z]").hasMatch(value)) {
                                  return "Veuillez entrer un nom valide";
                                } else {
                                  return null;
                                }
                              },
                              onChanged: (value) {
                                nom = value;
                              },
                            ),
                          ),
                          SizedBox(
                            height: 10,
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
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Email ne peut pas être vide";
                                }
                                if (!RegExp(
                                        "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                    .hasMatch(value)) {
                                  return "Please enter a valid email";
                                } else {
                                  return null;
                                }
                              },
                              onChanged: (value) {
                                email = value;
                              },
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            width: 334,
                            height: 60,
                            child: TextFormField(
                              obscureText: _isObscure,
                              controller: passwordController,
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                    icon: Icon(_isObscure
                                        ? Icons.visibility_off
                                        : Icons.visibility),
                                    onPressed: () {
                                      setState(() {
                                        _isObscure = !_isObscure;
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
                              validator: (value) {
                                RegExp regex = RegExp(r'^.{6,}$');
                                if (value!.isEmpty) {
                                  return "Password cannot be empty";
                                }
                                if (!regex.hasMatch(value)) {
                                  return "Please enter a valid password (min. 6 characters)";
                                } else {
                                  return null;
                                }
                              },
                              onChanged: (value) {
                                password = value;
                              },
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  _signupUsers2();
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
                                        ? CircularProgressIndicator(
                                            color: white,
                                          )
                                        : Text(
                                            "Sign Up",
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white,
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Already have an account?',
                                style: TextStyle(color: Colors.black),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return ResponsableLoginPage();
                                    },
                                  ));
                                },
                                child: Text(
                                  ' Log in',
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
              ],
            ),
          ),
        ),
      ),
    );
  }

}
