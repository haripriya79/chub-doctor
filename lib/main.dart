import 'package:doctor_consultation_app/firebase_options.dart';
import 'package:doctor_consultation_app/screens/home_screen.dart';
import 'package:doctor_consultation_app/screens/onboarding_screen.dart';
import 'package:doctor_consultation_app/screens/sign_up.dart';
import 'package:doctor_consultation_app/services/auth_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

void main() async {
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options:DefaultFirebaseConfig.platformOptions,);
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme:
            GoogleFonts.varelaRoundTextTheme(Theme.of(context).textTheme),
      ),
      home: StreamBuilder<auth.User?>(
          stream: AuthServices().userChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
            return HomeScreen();
            } else {            
                
                return OnboardingScreen() ;
              }
            
          }),
    );
  }
}
