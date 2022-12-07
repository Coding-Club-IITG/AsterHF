import 'package:aster_hf/screens/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import './screens/login_screen.dart';
import './screens/signup_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: const Color.fromRGBO(105, 92, 212, 1),
        textTheme: GoogleFonts.poppinsTextTheme(),
        splashColor: const Color.fromRGBO(239, 224, 255, 1),
        
      
      ),
      home: const SplashScreen(),
      routes: {
        LoginScreen.routename: (context) => const LoginScreen(),
        SignupScreen.routename: (context) => const SignupScreen(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('hello')),
      body: ElevatedButton(
        onPressed: () {
          Navigator.of(context).pushNamed(LoginScreen.routename);
        },
        child: const Text('Go to next page'),
      ),
    );
  }
}
