import 'package:aster_hf/main.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../screens/user_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EmailAuth extends ChangeNotifier {
  bool isLoading = false;
  var colori = const Color.fromARGB(223, 138, 137, 137);
  bool isChecked = false;

  void changeColor() {
    colori = Colors.red;
   
    notifyListeners();
  }

  void changeColor1() {
    colori = const Color.fromARGB(223, 138, 137, 137);


    notifyListeners();
  }

  void check() {
    isChecked = !isChecked;
    notifyListeners();
  }

  void resetPasswordDialog(String email) {
    showDialog(
        context: navigatorKey.currentContext!,
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
              title: Text('Send a mail to $email to reset password?'),
              actions: [
                TextButton(
                  style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(
                          Theme.of(context).splashColor)),
                  onPressed: () async {
                    Navigator.pop(context);
                    await resetPassword(email, context);
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

  Future<void> resetPassword(String email, BuildContext context) async {
    try {
      isLoading = true;
      notifyListeners();

      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      isLoading = false;
      notifyListeners();

      // ignore: use_build_context_synchronously
      showSnackBar('An email has been sent to reset your password');
    } on FirebaseAuthException catch (error) {
      showError(error.message ?? 'Something went Wrong!');
    } catch (err) {
      showError(err.toString());
    }
  }

  void showSnackBar(String message) {
    final snackbar = SnackBar(
      content: Text(message),

      // ignore: use_build_context_synchronously
      backgroundColor: Theme.of(navigatorKey.currentContext!).primaryColor,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(50),
    );

    ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(snackbar);
  }

  void showError(String errorMessage) {
    isLoading = false;
    notifyListeners();

    showDialog(
        context: navigatorKey.currentContext!,
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

  void signEmailPassword(String email, String password) async {
    try {
      isLoading = true;
      notifyListeners();

      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      final bool1 = FirebaseAuth.instance.currentUser!.emailVerified;

      if (!bool1) {
        showDialog(
            context: navigatorKey.currentContext!,
            builder: (context) {
              return Center(
                child: AlertDialog(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                        color: Theme.of(context).splashColor, width: 2),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  title: Text(
                      'Your Email not verfied , Send a verfication link to $email ?'),
                  actions: [
                    TextButton(
                      style: ButtonStyle(
                          overlayColor: MaterialStateProperty.all(
                              Theme.of(context).splashColor)),
                      onPressed: () async {
                        Navigator.pop(context);
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
                      onPressed: () async {
                        Navigator.of(context).pop();
                        final user = FirebaseAuth.instance.currentUser!;
                        await user.sendEmailVerification();
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
      } else {
        isLoading = false;
        notifyListeners();
        showSnackBar('You\'ve successfully logged in!');

        Navigator.of(navigatorKey.currentContext!).pushReplacementNamed(
            UserData.routename,
            arguments: {'page': 'blood_pressure', 'progress': 20});

        // ignore: use_build_context_synchronously
      }
    } on FirebaseAuthException catch (error) {
      showError(error.message ?? 'Something went Wrong!');
    } catch (err) {
      showError(err.toString());
    }
  }

  void createEmailPassword(String email, String password, String name) async {
    try {
      isLoading = true;
      notifyListeners();

      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();

      isLoading = false;
      notifyListeners();

      await FirebaseFirestore.instance
          .collection('users')
          .doc(email)
          .set({'name': name, 'email': email});

      showSnackBar('Check your inbox to verfify your account');

      Navigator.of(navigatorKey.currentContext!).pop();
    } on FirebaseAuthException catch (error) {
      showError(error.message ?? 'Something went Wrong!');
    } on FirebaseException catch (error) {
      showError(error.message ?? 'Something went Wrong!');
    } catch (err) {
      showError(err.toString());
    }
  }
}
