import 'package:aster_hf/controllers/auth.dart';

import 'package:aster_hf/screens/splashscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      designSize: const Size(432, 930),
      builder: (context, child) => MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => EmailAuth(),
          )
        ],
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            navigatorKey: navigatorKey,
            theme: ThemeData(
              primaryColor: const Color.fromRGBO(105, 92, 212, 1),
              textTheme: GoogleFonts.poppinsTextTheme(),
              splashColor: const Color.fromRGBO(239, 224, 255, 1),
            ),
       
            home: StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) => snapshot.hasData
                  ? const SplashScreen(true)
                  : const SplashScreen(false),
            ),
          );
        },
      ),
    );
  }
}
