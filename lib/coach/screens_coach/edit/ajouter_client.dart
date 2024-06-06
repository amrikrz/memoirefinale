


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ResponsableAjouterClient extends StatefulWidget {
  const ResponsableAjouterClient({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<ResponsableAjouterClient> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _dateController = TextEditingController();
  final _emailController = TextEditingController();
  final _contactController = TextEditingController();
  final _planController = TextEditingController();
  final _priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name of Participant',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _dateController,
                decoration: const InputDecoration(
                  labelText: 'Date of Join',
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                onTap: () async {
                  FocusScope.of(context).requestFocus(FocusNode());
                  DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (picked != null) {
                    setState(() {
                      _dateController.text = picked.toString().split(' ')[0];
                    });
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a date';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email Address',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an email address';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _contactController,
                decoration: const InputDecoration(
                  labelText: 'Contact No.',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a contact number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _planController,
                decoration: const InputDecoration(
                  labelText: 'Plan',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a plan';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(
                  labelText: 'Price',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a price';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Provider.of<EditProductScreen>(context, listen: false).updateDetails(
                          name: _nameController.text,
                          dateOfJoin: _dateController.text,
                          email: _emailController.text,
                          contact: _contactController.text,
                          plan: _planController.text,
                          price: _priceController.text,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Processing Data')),
                        );
                      }
                    },
                    child: const Text('Ajouter '),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      _formKey.currentState!.reset();
                      _nameController.clear();
                      _dateController.clear();
                      _emailController.clear();
                      _contactController.clear();
                      _planController.clear();
                      _priceController.clear();
                    },
                    child: const Text('Cancel'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EditProductScreen extends ChangeNotifier {
  String? name;
  String? dateOfJoin;
  String? email;
  String? contact;
  String? plan;
  String? price;

  void updateDetails({
    required String name,
    required String dateOfJoin,
    required String email,
    required String contact,
    required String plan,
    required String price,
  }) {
    this.name = name;
    this.dateOfJoin = dateOfJoin;
    this.email = email;
    this.contact = contact;
    this.plan = plan;
    this.price = price;
    notifyListeners();
  }
}