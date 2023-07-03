import 'package:aster_hf/controllers/auth.dart';
import 'package:aster_hf/widgets/auth_widgets.dart';
import 'package:provider/provider.dart';

import '../widgets/button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignupScreen extends StatelessWidget {
  static const routename = '/signup';

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailAuth = Provider.of<EmailAuth>(context, listen: false);
    final emailAuthListen = Provider.of<EmailAuth>(context, listen: true);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(title: 'Lets\'s Sign Up'),
      body: (emailAuthListen.isLoading)
          ? Container(
              color: Colors.grey[50],
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
                      CustomTextformfield(
                          isEmail: false, controller: _nameController),
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
                        height: 18.h,
                      ),
                      Consumer<EmailAuth>(
                        builder: (context, value, child) => Row(
                          children: [
                            SizedBox(
                              height: 18.h,
                              width: 18.w,
                              child: Checkbox(
                                  side:
                                      BorderSide(width: 2, color: value.colori),
                                  value: value.isChecked,
                                  activeColor: Colors.transparent,
                                  checkColor:
                                      const Color.fromARGB(223, 138, 137, 137),
                                  onChanged: (value) {
                                    emailAuth.check();
                                    if (emailAuthListen.isChecked) {
                                      emailAuth.changeColor1();
                                    }
                                  }),
                            ),
                            SizedBox(
                              width: 9.w,
                            ),
                            Text(
                              'I agree to the terms and conditions',
                              style: TextStyle(
                                color: value.colori,
                                fontWeight: FontWeight.w500,
                                fontSize: 15.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Material(
                        color: Theme.of(context).primaryColor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        child: InkWell(
                          splashColor: const Color.fromRGBO(105, 92, 212, 0.8),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          onTap: () async {
                            if (_key.currentState!.validate()) {
                              emailAuthListen.isChecked
                                  ? emailAuth.createEmailPassword(
                                      _emailController.text,
                                      _passwordController.text,
                                      _nameController.text)
                                  : emailAuth.changeColor();
                            }
                          },
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
                      // Text(
                      //   'or continue with',
                      //   textAlign: TextAlign.center,
                      //   style: TextStyle(
                      //     color: const Color.fromRGBO(140, 142, 151, 1),
                      //     fontWeight: FontWeight.w500,
                      //     fontSize: 15.sp,
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: 15.h,
                      // ),
                      // Container(
                      //   padding: EdgeInsets.symmetric(horizontal: 120.w),
                      //   child: OutlinedButton(
                      //     style: ButtonStyle(
                      //       shape: MaterialStateProperty.all(
                      //         const RoundedRectangleBorder(
                      //           borderRadius: BorderRadius.all(
                      //             Radius.circular(10),
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //     onPressed: () async {
                      //       await emailAuth.googleSignIn();
                      //     },
                      //     child: SizedBox(
                      //       height: 60.h,
                      //       child: Row(
                      //         mainAxisAlignment: MainAxisAlignment.center,
                      //         children: [
                      //           Image.asset(
                      //             'assets/images/google.png',
                      //             height: 24.0.h,
                      //           ),
                      //           SizedBox(
                      //             width: 10.h,
                      //           ),
                      //           Text(
                      //             'Google',
                      //             style: TextStyle(
                      //               color:
                      //                   const Color.fromRGBO(140, 142, 151, 1),
                      //               fontWeight: FontWeight.w500,
                      //               fontSize: 14.sp,
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: 80.h,
                      // ),
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
                                style: TextStyle(
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
