import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:raj_dootam/auth/auth_gate.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:raj_dootam/constants/theme/theme_provider.dart';
// import 'auth/login_or_register.dart';
import 'constants/theme/dark_mode.dart';
// import 'constants/theme/light_mode.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    // const MyApp(),
    ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
      child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Raj Dootam',
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context).themeData,
      home: const AuthGate(),
    );
  }
}