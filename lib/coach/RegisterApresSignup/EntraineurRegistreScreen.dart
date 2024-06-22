import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sportapplication/coach/controllers/entraineur_registrer_contoller.dart';

class CoachRegistrationScreen extends StatefulWidget {
  @override
  State<CoachRegistrationScreen> createState() =>
      _CoachRegistrationScreenState();
}

class _CoachRegistrationScreenState extends State<CoachRegistrationScreen> {
  String? locations;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final CoachController _coachController = CoachController();
  late String countryValue;

  late String bussinessName;

  late String email;

  late String phoneNumber;

  late String taxNumber;

  late String stateValue;

  late String cityValue;

  Uint8List? _image;
    Uint8List? _cv;
      Uint8List? _CarteNatio;



  Future<Uint8List?> _compressImage(Uint8List image) async {
    return image;
  }
    Future<Uint8List?> _compressImageCv(Uint8List cv) async {
    return cv;
  }
    Future<Uint8List?> _compressImageCarteNation(Uint8List CarteNation) async {
    return CarteNation;
  }

  void _showSuccessDialog() {
    EasyLoading.showSuccess('Registration Successful!');

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success!'),
          content:
              Text('Your coach registration has been submitted successfully.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog(String errorMessage) {
    EasyLoading.showError(errorMessage);


    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error!'),
          content: Text(errorMessage),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _saveCoachDetails() async {
  if (_formKey.currentState!.validate()) {
    EasyLoading.show(status: 'Uploading...');
    try {
      await _coachController.registerCoach(
        bussinessName,
        email,
        phoneNumber,
        countryValue,
        stateValue,
        cityValue,
        
        _image != null ? await _compressImage(_image!) : null,
        _cv != null ? await _compressImage(_cv!) : null,
        _CarteNatio != null ? await _compressImage(_CarteNatio!) : null,
      );
      if (mounted) {
        _showSuccessDialog();
      }
    } catch (error) {
      if (mounted) {
        _showErrorDialog(error.toString());
      }
    } finally {
      EasyLoading.dismiss();
    }
  } else {
    EasyLoading.dismiss();
    print('Form validation failed');
  }
}
selectGalleryImage1() async {
  Uint8List? im = await _coachController.pickImage(ImageSource.gallery);

  if (im != null) {
    setState(() {
      _image = im;
    });
  } else {
    print('Image not selected');
  }
}

_selectGalleryCVImage2() async {
    Uint8List? im2 = await _coachController.pickImage(ImageSource.gallery);
    if (im2 != null) {
      setState(() {
        _cv = im2;
      });
    }
  }
     _selectGalleryCarteNatioImage3() async {
    Uint8List? im3 = await _coachController.pickImage(ImageSource.gallery);
    if (im3 != null) {
      setState(() {
        _CarteNatio = im3;
      });
    }
  }





  @override
  void initState() {
    super.initState();
    countryValue = 'Algeria';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registre Coach"),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            toolbarHeight: 200,
            flexibleSpace: LayoutBuilder(builder: (context, constraints) {
              return FlexibleSpaceBar(
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.pink.shade300,
                        Colors.white,
                      ],
                    ),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 90,
                          width: 90,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(
                              10,
                            ),
                          ),
                          child: _image != null
                              ? Image.memory(_image!)
                              : IconButton(
                                  onPressed: () {
                                    selectGalleryImage1();
                                  },
                                  icon: Icon(CupertinoIcons.photo)),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      onChanged: (value) {
                        bussinessName = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Bussiness Name must not be empty';
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        labelText: 'Nom',
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      onChanged: (value) {
                        email = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'svp Email  ne peuve pas étre vide';
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Ton Email professionnel',
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      onChanged: (value) {
                        phoneNumber = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'SVP enter votre numero';
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Numero telephone',
                      ),
                    ),
                    SizedBox(height: 20,),
                    SizedBox(
                      height: 30,
                      child: Text('Le cv')),
                    Container(
                          height: 90,
                          width: 90,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(
                              10,
                            ),
                          ),
                          child: _cv != null
                              ? Image.memory(_cv!)
                              : IconButton(
                                  onPressed: () {
                                  _selectGalleryCVImage2();
                                  },
                                  icon: Icon(CupertinoIcons.photo)),
                                  
                        ),
                        SizedBox(
                          height: 20,
                          child: Text('carte nationalle')),
                        Container(
                          height: 90,
                          width: 90,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(
                              10,
                            ),
                          ),
                          child:_CarteNatio != null
                              ? Image.memory(_CarteNatio!)
                              : IconButton(
                                  onPressed: () {
                                  _selectGalleryCarteNatioImage3();
                                  },
                                  icon: Icon(CupertinoIcons.photo)),
                        ),
                    Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: SelectState(
                        onCountryChanged: (value) {
                          countryValue:
                          'Algeria';
                          setState(() {
                            countryValue = 'Algeria';
                          });
                        },
                        onStateChanged: (value) {
                          setState(() {
                            stateValue = value;
                          });
                        },
                        onCityChanged: (value) {
                          setState(() {
                            cityValue = value;
                          });
                        },
                      ),
                    ),
                  
                  
                    


                    Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: TextFormField(
                        onChanged: (value) {
                          setState(() {
                            locations = value;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: 'Localisation',
                          hintText: 'Entrer la localisation',
                        ),
                      ),
                    ),

                    InkWell(
                      onTap: () async{
                        await _saveCoachDetails();
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width - 40,
                        decoration: BoxDecoration(
                          color: Colors.pink.shade300,
                          borderRadius: BorderRadius.circular(
                            10,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Save',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
