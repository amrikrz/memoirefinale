import 'package:flutter/material.dart';

class ChoisirWhatYouAre extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage("assets/images/login_background.png"),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 100,
          backgroundColor: Colors.transparent,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Spacer(flex: 1),
              Text(
                'Bonjour\nChoisir un des trois',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Je suis un ',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(height: 32),
              OptionCard(
                icon: Icons.person,
                text: 'Sportif',
                onTap: () {
                  Navigator.pushNamed(
                    context,'/login_'
                  );
                    }),
                
              SizedBox(height: 16),
              OptionCard(
                icon: Icons.fitness_center,
                text: 'Entraîneur',
                onTap: () {
                  Navigator.pushNamed(
                    context,'/vendorsAuth'
                  );
                    }),
                  
                
              
              SizedBox(height: 16),
              OptionCard(
                icon: Icons.sports_gymnastics,
                text: 'Responsable ',
                onTap: () {Navigator.pushNamed(context, '/responsableLogin');},
              ),
              Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}

class OptionCard extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  OptionCard({required this.icon, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Colors.red[50],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
        ),
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 40,
                color: Colors.black,
              ),
              SizedBox(width: 16),
              Text(
                text,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
