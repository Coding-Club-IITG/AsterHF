import 'package:aster_hf/main.dart';
import 'package:aster_hf/screens/first_screen.dart';
import 'package:aster_hf/screens/home_screen.dart';
import 'package:aster_hf/screens/user_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controllers/user_data.dart';

class SplashScreen extends StatefulWidget {
  final bool isLogin;

  const SplashScreen(this.isLogin, {super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    //TODO: remove this line , inserted only for testing

    final prefs = await SharedPreferences.getInstance();
    prefs.clear();

    await Future.delayed(const Duration(seconds: 2), () {});
    if (!mounted) return;

    if (!widget.isLogin) {
      Navigator.pushReplacement(
          context,
          PageTransition(
              child: const FirstScreen(), type: PageTransitionType.fade));
    } else {
      final data = await UserDataController.getNextScreen();

      if (data['page'] == 'home_screen') {
        Navigator.pushReplacement(navigatorKey.currentContext!,
            PageTransition(child: const Home(), type: PageTransitionType.fade));
      } else {
        Navigator.pushReplacement(
            navigatorKey.currentContext!,
            PageTransition(
                child: UserData(
                  progress: data['progress'],
                  page: data['page'],
                ),
                type: PageTransitionType.fade));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 100.h,
              width: 92.w,
              child: Image.asset('assets/images/logo.png'),
            ),
            Text(
              'WellBe',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w600,
                fontSize: 20.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
