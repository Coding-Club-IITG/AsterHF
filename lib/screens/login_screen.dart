import 'package:aster_hf/screens/signup_screen.dart';
import 'package:aster_hf/widgets/button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../controllers/validation.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const routename = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  var _isLoading = false;
  var _passwordvisble = false;
  bool? _isChecked = false;

  String errorMessage = "";

  var _email = '', _password = '';

  void function() async {
    try {
      setState(() {
        _isLoading = true;
      });
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: _email, password: _password);
      setState(() {
        _isLoading = false;
      });

      // ignore: use_build_context_synchronously

    } on FirebaseAuthException catch (error) {
      errorMessage = error.message ?? 'Something went Wrong!';

      showError();
    } catch (err) {
      errorMessage = err.toString();
      showError();
    }
  }

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

  void resetPasswordDialog() {
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
              title: Text('Send a mail to $_email to reset password?'),
              actions: [
                TextButton(
                  style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(
                          Theme.of(context).splashColor)),
                  onPressed: () async {
                    Navigator.pop(context);
                    await resetPassword();
                  },
                  child: Text(
                    'Confirm',
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                ),
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

  Future<void> resetPassword() async {
    try {
      setState(() {
        _isLoading = true;
      });
      await FirebaseAuth.instance.sendPasswordResetEmail(email: _email);
      setState(() {
        _isLoading = false;
      });

      final snackbar = SnackBar(
        content: const Text('An email has been sent to reset your password'),

        // ignore: use_build_context_synchronously
        backgroundColor: Theme.of(context).primaryColor,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(50),
      );

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    } on FirebaseAuthException catch (error) {
      errorMessage = error.message ?? 'Something went Wrong!';

      showError();
    } catch (err) {
      errorMessage = err.toString();
      showError();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Login',
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
      body: (_isLoading)
          ? Container(
              color: Colors.grey[50],
              child: Center(
                  child: SizedBox(
                width: 100,
                child: LinearProgressIndicator(
                  backgroundColor: Theme.of(context).splashColor,
                  color: Theme.of(context).primaryColor,
                ),
              )),
            )
          : Container(
              margin: const EdgeInsets.only(
                left: 25,
                right: 25,
                top: 56,
                bottom: 48,
              ),
              child: Form(
                key: _key,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: 80,
                      width: 75,
                      child: Image.asset('assets/images/logo.png'),
                    ),
                    Text(
                      'WellBe',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(
                      height: 36,
                    ),
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
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      validator: validateEmail,
                      onChanged: (value) {
                        _email = value;
                      },
                      keyboardType: TextInputType.emailAddress,
                      cursorColor: const Color.fromRGBO(140, 142, 151, 1),
                      decoration: const InputDecoration(
                        hintText: 'Enter your email',
                        hintStyle: TextStyle(
                          color: Color.fromRGBO(140, 142, 151, 1),
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                            color: Colors.red,
                            width: 1,
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                            color: Colors.red,
                            width: 1,
                          ),
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
                    TextFormField(
                      validator: validatePassword,
                      keyboardType: TextInputType.visiblePassword,
                      onChanged: (value) {
                        _password = value;
                      },
                      obscureText: !_passwordvisble,
                      cursorColor: const Color.fromRGBO(140, 142, 151, 1),
                      decoration: InputDecoration(
                        suffixIcon: InkWell(
                          splashColor: const Color.fromARGB(224, 224, 224, 224),
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
                        hintStyle: const TextStyle(
                          color: Color.fromRGBO(140, 142, 151, 1),
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                        focusedErrorBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                            color: Colors.red,
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
                            checkColor:
                                const Color.fromARGB(223, 138, 137, 137),
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
                          'Remember Me',
                          style: TextStyle(
                            color: Color.fromRGBO(140, 142, 151, 1),
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                          ),
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: () async {
                            if (validateEmail(_email) != null) {
                              errorMessage = validateEmail(_email) ??
                                  'Something went Wrong';
                              showError();
                            } else {
                              try {
                                resetPasswordDialog();
                              } on FirebaseAuthException catch (error) {
                                errorMessage =
                                    error.message ?? 'Something went Wrong!';
                                showError();
                              }
                            }
                          },
                          style: ButtonStyle(
                            overlayColor:
                                MaterialStateProperty.all(Colors.red[50]),
                          ),
                          child: const Text(
                            'Forgot Password',
                            style: TextStyle(
                              color: Color.fromRGBO(243, 70, 70, 1),
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
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
                        onTap: () {
                          if (_key.currentState!.validate()) {
                            function();
                          }
                        },
                        child: const Button(
                            text: 'Login',
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
                            text: 'Don\'t have an account? ',
                            style: TextStyle(
                              color: Color.fromRGBO(140, 142, 151, 1),
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                          TextSpan(
                              text: 'Sign Up',
                              style: const TextStyle(
                                color: Color.fromRGBO(105, 92, 212, 1),
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
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
    );
  }
}
