import '../widgets/button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
        title: Text(
          'Let\'s Sign Up',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
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
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            height: 900.h,
            margin: EdgeInsets.only(
              left: 25.w,
              right: 25.w,
              top: 56.h,
              bottom: 48.h,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Create Account',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 36.h,
                ),
                Text(
                  'Name',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15.sp,
                  ),
                ),
                SizedBox(
                  height: 8.h,
                ),
                TextField(
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.name,
                  cursorColor: const Color.fromRGBO(140, 142, 151, 1),
                  decoration: InputDecoration(
                    hintText: 'Enter your name',
                    hintStyle: TextStyle(
                      color: const Color.fromRGBO(140, 142, 151, 1),
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
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
                SizedBox(
                  height: 8.h,
                ),
                Text(
                  'Email Address',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15.sp,
                  ),
                ),
                SizedBox(
                  height: 8.h,
                ),
                TextField(
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  cursorColor: const Color.fromRGBO(140, 142, 151, 1),
                  decoration: InputDecoration(
                    hintText: 'Enter your email',
                    hintStyle: TextStyle(
                      color: const Color.fromRGBO(140, 142, 151, 1),
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
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
                SizedBox(
                  height: 8.h,
                ),
                Text(
                  'Password',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15.sp,
                  ),
                ),
                SizedBox(
                  height: 8.h,
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
                    hintStyle: TextStyle(
                      color: const Color.fromRGBO(140, 142, 151, 1),
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
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
                SizedBox(
                  height: 18.h,
                ),
                Row(
                  children: [
                    SizedBox(
                      height: 18.h,
                      width: 18.w,
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
                    SizedBox(
                      width: 9.w,
                    ),
                    Text(
                      'I agree to the terms and conditions',
                      style: TextStyle(
                        color: const Color.fromRGBO(140, 142, 151, 1),
                        fontWeight: FontWeight.w500,
                        fontSize: 15.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                Material(
                  color: Theme.of(context).primaryColor,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  child: InkWell(
                    onTap: () {},
                    child: Button(
                      text: 'Sign Up',
                      width: 240.w,
                      fontsize: 16.sp,
                      fontweight: FontWeight.w600,
                      height: 60.h,
                    ),
                  ),
                ),
                SizedBox(
                  height: 12.h,
                ),
                 Text(
                  'or continue with',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color.fromRGBO(140, 142, 151, 1),
                    fontWeight: FontWeight.w500,
                    fontSize: 15.sp,
                  ),
                ),
                 SizedBox(
                  height: 15.h,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 120.w),
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
                      height: 60.h,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/google.png',
                            height: 24.0.h,
                          ),
                          SizedBox(
                            width: 10.h,
                          ),
                           Text(
                            'Google',
                            style: TextStyle(
                              color: const Color.fromRGBO(140, 142, 151, 1),
                              fontWeight: FontWeight.w500,
                              fontSize: 14.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 50.h,),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Already have an account? ',
                        style: TextStyle(
                          color: const Color.fromRGBO(140, 142, 151, 1),
                          fontWeight: FontWeight.w500,
                          fontSize: 15.sp,
                        ),
                      ),
                      TextSpan(
                          text: 'Login',
                          style:  TextStyle(
                            color: const Color.fromRGBO(105, 92, 212, 1),
                            fontWeight: FontWeight.w600,
                            fontSize: 15.sp,
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
      ),
    );
  }
}
