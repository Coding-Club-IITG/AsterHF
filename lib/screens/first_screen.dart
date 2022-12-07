import 'login_screen.dart';
import 'package:aster_hf/widgets/button.dart';
import 'package:flutter/material.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 62),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                child: Text(
                  'Track your \nHealth variables',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 28),
                  maxLines: 2,
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              SizedBox(
                height: 260,
                child: Image.asset('assets/images/logo1.png'),
              ),
              Material(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                color: Theme.of(context).primaryColor,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(LoginScreen.routename);
                  },
                  child: const Button(
                    text: 'Continue',
                    width: 240,
                    fontsize: 16,
                    fontweight: FontWeight.w600,
                    height: 60,
                  ),
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text:
                          'Your Privacy matters to us. You can learn how we use the information when you use our services by reading our ',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Color.fromRGBO(134, 134, 134, 1),
                          fontSize: 15,
                          height: 1.5),
                    ),
                    TextSpan(
                      text: 'Privacy Policy',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).primaryColor,
                          fontSize: 15,
                          height: 1.5),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
