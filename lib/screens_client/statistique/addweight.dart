import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddWeightScreen extends StatefulWidget {
  @override
  _AddWeightScreenState createState() => _AddWeightScreenState();
}

class _AddWeightScreenState extends State<AddWeightScreen> {
  final TextEditingController _weightController = TextEditingController();
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Weight'),
      ),
      body: Padding(
        padding:  EdgeInsets.all(8.0),
        child: Column(
          children: [
            _buildDateSelector(),
            SizedBox(height: 20),
            TextField(
              controller: _weightController,
              decoration: InputDecoration(labelText: 'Enter your weight'),
              keyboardType: TextInputType.number,
            
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (_weightController.text.isNotEmpty && _selectedDate != null) {
                  try {
                    double weight = double.parse(_weightController.text);
                    await FirebaseFirestore.instance.collection('weights').add({
                      'weight': weight,
                      'date': Timestamp.fromDate(_selectedDate!),
                    });
                    Navigator.pop(context); 
                  } catch (e) {
                    print(e);
                    
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Failed to add weight. Please try again.')),
                    );
                  }
                } else {
                  
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please enter a weight and select a date.')),
                  );
                }
              },
              child: Text('Add Weight'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateSelector() {
    return InkWell(
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2101),
        );
        if (pickedDate != null) {
          setState(() {
            _selectedDate = pickedDate;
          });
        }
      },
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: 'Select date',
        ),
        child: Text(_selectedDate == null ? 'No date selected' : _selectedDate!.toLocal().toString().split(' ')[0]),
      ),
    );
  }
}
