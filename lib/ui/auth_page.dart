import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kenya_yetu_admin/ui/splash_screen.dart';

import 'bottom_navigation_controller.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
         // If User is logged in
          if (snapshot.hasData) {
            return const BottomNavigation();
          }

         // If User is not logged in
          else{
            return SplashScreen();
          }
        },
      ),
    );
  }
}




