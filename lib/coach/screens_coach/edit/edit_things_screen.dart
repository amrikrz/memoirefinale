import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sportapplication/coach/screens_coach/edit/ajouter_client.dart';

class MembersProvider with ChangeNotifier {
  List<Member> _members = [
    Member(
        name: 'Boutiba',
        prenom: 'Sarah',
        dateEnrolled: 'Jan 11',
        dateExpiration: 'Feb 11'),
    Member(  name: 'Boutiba',
        prenom: 'Amina', dateEnrolled: 'Jan 11', dateExpiration: 'Feb 11'),
    Member(  name: 'Boutiba',
        prenom: 'Sarah',dateEnrolled: 'Jan 20', dateExpiration: 'Feb 20'),
    Member(  name: 'Boutiba',
        prenom: 'Sarah', dateEnrolled: 'Mar 20', dateExpiration: 'Avr 20'),
  ];

  List<Member> get members => _members;

  void updateMember(int index, Member member) {
    _members[index] = member;
    notifyListeners();
  }
}

class Member {
  String name;
  String prenom;
  String dateEnrolled;
  String dateExpiration;

  Member(
      {required this.name,
      required this.prenom,
      required this.dateEnrolled,
      required this.dateExpiration});
}

class EditProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final membersProvider = Provider.of<MembersProvider>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            tooltip: 'Ajouter sportif',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ResponsableAjouterClient()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Center(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                      child: SizedBox(
                        width: 350,
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Chercher un  sportif',
                            prefixIcon: Icon(Icons.search),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: [
                    DataColumn(label: Text('Nom')),
                    DataColumn(label: Text('Date d\'inscription')),
                    DataColumn(label: Text('Date Expiration')),
                    DataColumn(label: Text('Actions')),
                  ],
                  rows: membersProvider.members
                      .asMap()
                      .entries
                      .map(
                        (entry) => DataRow(
                          cells: [
                            DataCell(Text(entry.value.name)),
                            DataCell(Text(entry.value.dateEnrolled)),
                            DataCell(Text(entry.value.dateExpiration)),
                            DataCell(
                              ElevatedButton(
                                onPressed: () {
                                  _editMember(context, entry.key, entry.value);
                                },
                                child: Text('Edit'),
                              ),
                            ),
                          ],
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _editMember(BuildContext context, int index, Member member) {
    final membersProvider =
        Provider.of<MembersProvider>(context, listen: false);
    showDialog(
      context: context,
      builder: (context) {
        final TextEditingController nameController =
            TextEditingController(text: member.name);
            final TextEditingController prenomController =
            TextEditingController(text: member.prenom);
        final TextEditingController dateEnrolledController =
            TextEditingController(text: member.dateEnrolled);
        final TextEditingController dateExpirationController =
            TextEditingController(text: member.dateExpiration);

        return AlertDialog(
          title: Text('Edit Member'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
                TextField(
                controller: prenomController,
                decoration: InputDecoration(labelText: 'Prenom'),
              ),
              TextField(
                controller: dateEnrolledController,
                decoration: InputDecoration(labelText: 'Date Enrolled'),
              ),
              TextField(
                controller: dateExpirationController,
                decoration: InputDecoration(labelText: 'Date Expiration'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                membersProvider.updateMember(
                  index,
                  Member(
                    name: nameController.text,
                    prenom: prenomController.text,
                    dateEnrolled: dateEnrolledController.text,
                    dateExpiration: dateExpirationController.text,
                  ),
                );
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
