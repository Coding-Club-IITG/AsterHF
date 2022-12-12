import '../widgets/button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../controllers/validation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../controllers/google_auth.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);
  static const routename = '/signup';

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  var _passwordvisble = false;
  var _colori = const Color.fromARGB(223, 138, 137, 137);
  String errorMessage = "";
  var _isLoading = false;
  String _email = '', _password = '', _name = '';

  bool _isChecked = false;
  void showError() {
    setState(() {
      _isLoading = false;
    });
    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                side:
                    BorderSide(color: Theme.of(context).splashColor, width: 2),
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              title: Text(errorMessage),
              actions: [
                TextButton(
                  style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(
                          Theme.of(context).splashColor)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Dismiss',
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                ),
              ],
            ),
          );
        });
  }

  void function() async {
    try {
      setState(() {
        _isLoading = true;
      });
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: _email, password: _password);
      setState(() {
        _isLoading = false;
      });
      await FirebaseFirestore.instance
          .collection('users')
          .doc(_email)
          .set({'name': _name, 'email': _email});
      final snackbar = SnackBar(
        content: const Text('Your account has been successfully created'),

        // ignore: use_build_context_synchronously
        backgroundColor: Theme.of(context).primaryColor,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(50),
      );

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (error) {
      errorMessage = error.message ?? 'Something went Wrong!';
      showError();
    } on FirebaseException catch (error) {
      errorMessage = error.message ?? 'Something went Wrong!';
      showError();
    } catch (err) {
      errorMessage = err.toString();
      showError();
    }
  }

  void function2() {
    setState(() {
      _colori = Colors.red;
    });
  }

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
          iconSize: 24,
          onPressed: Navigator.of(context).pop,
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.black,
          ),
        ),
      ),
      body: (_isLoading)
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
                height: 900.h,
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
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.name,
                        onChanged: (value) {
                          _name = value;
                        },
                        validator: validateName,
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
                          errorBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                              color: Colors.red,
                              width: 1,
                            ),
                          ),
                          focusedErrorBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                              color: Colors.red,
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
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) => _email = value,
                        validator: validateEmail,
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
                          errorBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                              color: Colors.red,
                              width: 1,
                            ),
                          ),
                          focusedErrorBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                              color: Colors.red,
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
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        validator: validatePassword,
                        onChanged: (value) {
                          _password = value;
                        },
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: !_passwordvisble,
                        cursorColor: const Color.fromRGBO(140, 142, 151, 1),
                        decoration: InputDecoration(
                          suffixIcon: InkWell(
                            splashColor:
                                const Color.fromARGB(224, 224, 224, 224),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(50)),
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
                          errorBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                              color: Colors.red,
                              width: 1,
                            ),
                          ),
                          focusedErrorBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                              color: Colors.red,
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
                                side: BorderSide(width: 2, color: _colori),
                                value: _isChecked,
                                activeColor: Colors.transparent,
                                checkColor:
                                    const Color.fromARGB(223, 138, 137, 137),
                                onChanged: (value) {
                                  setState(() {
                                    _isChecked = value ?? false;
                                    if (_isChecked) {
                                      _colori = const Color.fromARGB(
                                          223, 138, 137, 137);
                                    }
                                  });
                                }),
                          ),
                          SizedBox(
                            width: 9.w,
                          ),
                          Text(
                            'I agree to the terms and conditions',
                            style: TextStyle(
                              color: _colori,
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
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        child: InkWell(
                          onTap: () async {
                            if (_key.currentState!.validate()) {
                              _isChecked ? function() : function2();
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
                          onPressed: () {
                            Auth.googleSignIn(context);
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
                                  width: 10.h,
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
                        height: 50.h,
                      ),
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
