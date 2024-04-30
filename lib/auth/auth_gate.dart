import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:raj_dootam/auth/login_or_register.dart';

import '../pages/home_page.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot){
            // User is logged in
            if(snapshot.hasData){
              return HomePage();
            }
            // User is NOT logged in
            else{
              return const LoginOrRegister();
            }
          },
      ),
    );
  }
}
