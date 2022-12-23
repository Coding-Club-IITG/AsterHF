import 'package:aster_hf/controllers/email_auth.dart';
import 'package:aster_hf/screens/signup_screen.dart';

import 'package:aster_hf/widgets/auth_widgets.dart';
import 'package:aster_hf/widgets/button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/validation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../controllers/google_auth.dart';

class LoginScreen extends StatelessWidget {

  static const routename = '/login';
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailAuth = Provider.of<EmailAuth>(context, listen: false);
    final emailAuthListen = Provider.of<EmailAuth>(context, listen: true);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(title: 'Login'),
      body: (emailAuthListen.isLoading)
          ? Container(
              color: const Color.fromARGB(24, 172, 167, 167),
              child: Center(
                  child: SizedBox(
                width: 100.w,
                child: LinearProgressIndicator(
                  backgroundColor: Theme.of(context).splashColor,
                  color: Theme.of(context).primaryColor,
                ),
              )),
            )
          : SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Container(
           
                margin: EdgeInsets.only(
                  left: 25.w,
                  right: 25.w,
                  top: 56.h,
                  bottom: 48.h,
                ),
                child: Form(
                  key: _key,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: 80.h,
                        width: 75.w,
                        child: Image.asset('assets/images/logo.png'),
                      ),
                      Text(
                        'WellBe',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 20.sp,
                        ),
                      ),
                      SizedBox(
                        height: 36.h,
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
                      CustomTextformfield(
                          isEmail: true, controller: _emailController),
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
                      CustomPasswordField(controller: _passwordController),
                      SizedBox(
                        height: 8.h,
                      ),
                      Row(
                        children: [
                          TextButton(
                            onPressed: () async {
                              if (validateEmail(_emailController.text) !=
                                  null) {
                                emailAuth.showError(
                                    validateEmail(_emailController.text) ??
                                        'Something went Wrong');
                              } else {
                                try {
                                  emailAuth.resetPasswordDialog(
                                      _emailController.text);
                                } on FirebaseAuthException catch (error) {
                                  emailAuth.showError(
                                      error.message ?? 'Something went Wrong!');
                                }
                              }
                            },
                            style: ButtonStyle(
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              padding: MaterialStateProperty.all(
                                  const EdgeInsets.all(0)),
                              overlayColor:
                                  MaterialStateProperty.all(Colors.red[50]),
                            ),
                            child: Text(
                              'Forgot password? Click here to reset',
                              style: TextStyle(
                                color: const Color.fromRGBO(243, 70, 70, 1),
                                fontWeight: FontWeight.w500,
                                fontSize: 15.sp,
                              ),
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Material(
                        color: Theme.of(context).primaryColor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        child: InkWell(
                          splashColor: const Color.fromRGBO(105, 92, 212, 0.8),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          onTap: () {
                            if (_key.currentState!.validate()) {
                              emailAuth.signEmailPassword(_emailController.text,
                                  _passwordController.text);
                            }
                          },
                          child: Button(
                              text: 'Login',
                              width: 240.w,
                              fontsize: 16.sp,
                              fontweight: FontWeight.w600,
                              height: 60.h),
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
                            overlayColor: MaterialStateProperty.all(
                                Theme.of(context).splashColor),
                            shape: MaterialStateProperty.all(
                              const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                            ),
                          ),
                          onPressed: () async {
                            await Auth.googleSignIn(context);
                          },
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
                                  width: 10.w,
                                ),
                                Text(
                                  'Google',
                                  style: TextStyle(
                                    color:
                                        const Color.fromRGBO(140, 142, 151, 1),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 100.h,
                      ),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Don\'t have an account? ',
                              style: TextStyle(
                                color: const Color.fromRGBO(140, 142, 151, 1),
                                fontWeight: FontWeight.w500,
                                fontSize: 15.sp,
                              ),
                            ),
                            TextSpan(
                                text: 'Sign Up',
                                style: TextStyle(
                                  color: const Color.fromRGBO(105, 92, 212, 1),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15.sp,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => Navigator.of(context)
                                      .pushNamed(SignupScreen.routename)),
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
