import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class HistoryScreen2 extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen2> {
  final Set<DocumentReference> _selectedWeights = {};

  void _handleDeleteSelected() async {
    if (_selectedWeights.isEmpty) {
      return; // No items selected, do nothing
    }

    final confirmed = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirm Delete'),
        content: Text('Are you sure you want to delete the selected weights?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text('Delete'),
          ),
        ],
      ),
    );

    if (!confirmed) return; // User cancelled deletion

    // Delete selected weights using a batch write operation
    final batch = FirebaseFirestore.instance.batch();
    for (final weightRef in _selectedWeights) {
      batch.delete(weightRef);
    }
    await batch.commit();

    setState(() {
      _selectedWeights.clear(); // Clear selected weights after deletion
    });

    // Show success or error message (optional)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: _handleDeleteSelected,
          ),
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('weights').orderBy('date', descending: true).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          var weights = snapshot.data!.docs;
          return ListView.builder(
            itemCount: weights.length,
            itemBuilder: (context, index) {
              var weight = weights[index];
              Timestamp timestamp = weight['date'];
              DateTime date = timestamp.toDate();
              String formattedDate = DateFormat('dd/MM/yyyy ').format(date);

              return ListTile(
                leading: Checkbox(
                  value: _selectedWeights.contains(weight.reference),
                  onChanged: (value) => setState(() {
                    if (value!) {
                      _selectedWeights.add(weight.reference);
                    } else {
                      _selectedWeights.remove(weight.reference);
                    }
                  }),
                ),
                title: Text('${weight['weight']} KG'),
                subtitle: Text(formattedDate),
              );
            },
          );
        },
      ),
    );
  }
}
