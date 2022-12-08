import '../widgets/button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';



class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);
  static const routename = '/signup';

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  var _passwordvisble = false;

  bool? _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Let\'s Sign Up',
          style: TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: Navigator.of(context).pop,
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(
            left: 25,
            right: 25,
            top: 56,
            bottom: 48,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Create Account',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 36,
              ),
              const Text(
                'Name',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              const TextField(
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.name,
                cursorColor: Color.fromRGBO(140, 142, 151, 1),
                decoration: InputDecoration(
                  hintText: 'Enter your name',
                  hintStyle: TextStyle(
                    color: Color.fromRGBO(140, 142, 151, 1),
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 1,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(
                      color: Color.fromARGB(224, 224, 224, 224),
                      width: 1,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8,),
              const Text(
                'Email Address',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              const TextField(
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                cursorColor: Color.fromRGBO(140, 142, 151, 1),
                decoration: InputDecoration(
                  hintText: 'Enter your email',
                  hintStyle: TextStyle(
                    color: Color.fromRGBO(140, 142, 151, 1),
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 1,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(
                      color: Color.fromARGB(224, 224, 224, 224),
                      width: 1,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              const Text(
                'Password',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              TextField(
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.visiblePassword,
                obscureText: !_passwordvisble,
                cursorColor: const Color.fromRGBO(140, 142, 151, 1),
                decoration: InputDecoration(
                  suffixIcon: InkWell(
                    splashColor: const Color.fromARGB(224, 224, 224, 224),
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                    onTap: () {
                      setState(() {
                        _passwordvisble = !_passwordvisble;
                      });
                    },
                    child: _passwordvisble
                        ? const Icon(
                            Icons.visibility,
                            color: Colors.black54,
                          )
                        : const Icon(
                            Icons.visibility_off,
                            color: Colors.grey,
                          ),
                  ),
                  hintText: 'Enter your password',
                  hintStyle: const TextStyle(
                    color: Color.fromRGBO(140, 142, 151, 1),
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 1,
                    ),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(
                      color: Color.fromARGB(224, 224, 224, 224),
                      width: 1,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              Row(
                children: [
                  SizedBox(
                    height: 18,
                    width: 18,
                    child: Checkbox(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2.0),
                          side: const BorderSide(color: Colors.grey)),
                      value: _isChecked,
                      activeColor: Colors.transparent,
                      checkColor: const Color.fromARGB(223, 138, 137, 137),
                      onChanged: (value) {
                        setState(
                          () {
                            _isChecked = value;
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 9,
                  ),
                  const Text(
                    'I agree to the terms and conditions',
                    style: TextStyle(
                      color: Color.fromRGBO(140, 142, 151, 1),
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),
                  
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Material(
                color: Theme.of(context).primaryColor,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: InkWell(
                  onTap: () {},
                  child: const Button(
                      text: 'Sign Up',
                      width: 240,
                      fontsize: 16,
                      fontweight: FontWeight.w600,
                      height: 60),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              const Text(
                'or continue with',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromRGBO(140, 142, 151, 1),
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 120),
                child: OutlinedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  onPressed: () {},
                  child: SizedBox(
                    height: 60,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/google.png',
                          height: 24.0,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          'Google',
                          style: TextStyle(
                            color: Color.fromRGBO(140, 142, 151, 1),
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const Spacer(),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: 'Already have an account? ',
                      style: TextStyle(
                        color: Color.fromRGBO(140, 142, 151, 1),
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                    ),
                    TextSpan(
                        text: 'Login',
                        style: const TextStyle(
                          color: Color.fromRGBO(105, 92, 212, 1),
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => Navigator.of(context).pop()),
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
