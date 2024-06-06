import 'package:flutter/material.dart';

class RoleSelection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose Your Role'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Navigate to login page with role parameter
                Navigator.pushNamed(context, '/login_client', arguments: 'Sportif');
              },
              child: Text('Sportif'),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigate to login page with role parameter
                Navigator.pushNamed(context, '/login_coach', arguments: 'Coach');
              },
              child: Text('Coach'),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigate to login page with role parameter
                Navigator.pushNamed(context, '/login_responsable', arguments: 'Responsable');
              },
              child: Text('Responsable'),
            ),
          ],
        ),
      ),
    );
  }
}
