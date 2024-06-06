import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:sportapplication/auth_controller.dart';
import 'package:sportapplication/shared/colors.dart';
import 'package:sportapplication/show_snackbar.dart';

import 'login.dart';

class ClientRegisterScreen extends StatefulWidget {
  @override
  _Signup2State createState() => _Signup2State();
}

class _Signup2State extends State<ClientRegisterScreen> {
  bool _isLoading = false;
  late String nom;
  late String DateNaiss;
  late String email;
  late String password;
  late String telephone;
  late String Gendre ='Homme';

  final AuthController _authController = AuthController();

  final TextEditingController nam = TextEditingController();
  final TextEditingController mobile = TextEditingController();
  final TextEditingController date_nais = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String? _validateDate(String? value) {
    if (value == null || value.isEmpty) {
      return "Date cannot be empty";
    }
    List<String> parts = value.split('/');
    if (parts.length != 3) {
      return "Invalid date format";
    }
    int day = int.tryParse(parts[0]) ?? 0;
    int month = int.tryParse(parts[1]) ?? 0;
    int year = int.tryParse(parts[2]) ?? 0;
    if (day < 1 || day > 31 || month < 1 || month > 12 || year < 1900 || year > DateTime.now().year - 18) {
      return "Invalid date";
    }
    return null;
  }

  bool _isObscure = true;
  Uint8List? _image;

  var _currentItemSelected2 = "Homme";
  var rool2 = "Homme";

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  _signupUsers() async {
    setState(() {
      _isLoading = true;
    });
    if (_formKey.currentState!.validate()) {
      await _authController.signupUsers(nom, telephone, DateNaiss, email, password, _image, Gendre).then((value) {
        setState(() {
          _isLoading = false;
        });
        showSnackBa(context, value);
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      showSnackBa(context, 'field must not be empty');
    }
  }

  selectGalleryImage() async {
    Uint8List im = await _authController.pickProfileImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  selectCameraImage() async {
    Uint8List im = await _authController.pickProfileImage(ImageSource.camera);
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
                                  : CircleAvatar(
                                      radius: 64,
                                      backgroundColor: pink,
                                      backgroundImage: NetworkImage(
                                          'https://t4.ftcdn.net/jpg/00/64/67/63/360_F_64676383_LdbmhiNM6Ypzb3FM4PPuFP9rHe7ri8Ju.jpg'),
                                    ),
                              Positioned(
                                right: 0,
                                top: 5,
                                child: IconButton(
                                  onPressed: () {
                                    selectGalleryImage();
                                  },
                                  icon: Icon(Icons.image),
                                  color: Colors.black87,
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
                                hintText: 'Nom et Prenom',
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
                                  return "nom ne peut pas être vide";
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
                              controller: date_nais,
                              decoration: InputDecoration(
                                labelText: "Date de naissance",
                                filled: true,
                                prefixIcon: Icon(Icons.calendar_today),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: pink)),
                              ),
                              readOnly: true,
                              validator: _validateDate,
                              onTap: () {
                                _selectDate();
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
                              controller: mobile,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                hintText: '+213 (Entrer les 10 numéro du mobile)',
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
                                  return "numero ne peut pas être vide";
                                }
                                if (!RegExp("^[0-9]").hasMatch(value)) {
                                  return "Veuillez entrer un telephone valide";
                                } else {
                                  return null;
                                }
                              },
                              keyboardType: TextInputType.phone,
                              maxLength: 10,
                              onChanged: (value) {
                                telephone = value;
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
                                  return "email ne peut pas être vide";
                                }
                                if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
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
                                    icon: Icon(_isObscure ? Icons.visibility_off : Icons.visibility),
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
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Gender',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Flexible(
                                  child: Container(
                                    width: 100,
                                    child: DropdownButtonFormField(
                                      hint: Text('Select'),
                                      value: _currentItemSelected2,
                                      items: ['Homme', 'Femme']
                                          .map<DropdownMenuItem<String>>(
                                              (String value) {
                                        return DropdownMenuItem<String>(
                                            value: value, child: Text(value));
                                      }).toList(),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          _currentItemSelected2 = newValue!;
                                          Gendre = newValue;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ],
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
                                  _signupUsers();
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
                                      return LoginPage();
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

  Future<void> _selectDate() async {
    DateTime now = DateTime.now();
    DateTime lastDate = DateTime(now.year - 18, now.month, now.day);

    DateTime? _picked = await showDatePicker(
      context: context,
      initialDate: lastDate,
      firstDate: DateTime(1940),
      lastDate: lastDate,
    );

    if (_picked != null) {
      setState(() {
        DateNaiss = DateFormat('dd/MM/yyyy').format(_picked);
        date_nais.text = DateNaiss;
      });
    }
  }
}
