import 'dart:html';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Auth with ChangeNotifier {
  static Future<void> googleSignIn(context) async {
    final googleAccount = await GoogleSignIn().signIn();
    if (googleAccount != null) {
      final googleAuth = await googleAccount.authentication;

      if (googleAuth.accessToken != null && googleAuth.idToken != null) {
        try {
          final name = googleAccount.displayName;
          final email = googleAccount.email;
          await FirebaseAuth.instance.signInWithCredential(
            GoogleAuthProvider.credential(
              accessToken: googleAuth.accessToken,
              idToken: googleAuth.idToken,
            ),
          );
          await FirebaseFirestore.instance
              .collection('users')
              .doc(email)
              .set({'email': email, 'name': name});
          final snackbar = SnackBar(
            content: const Text('You have successfully signed in with Google'),

            // ignore: use_build_context_synchronously
            backgroundColor: Theme.of(context).primaryColor,
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.all(50),
          );

          ScaffoldMessenger.of(context).showSnackBar(snackbar);
        } on FirebaseException catch (error) {
          final snackbar = SnackBar(
            content: Text(error.message ?? 'Something went wrong'),

            // ignore: use_build_context_synchronously
            backgroundColor: Theme.of(context).primaryColor,
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.all(50),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackbar);
        }
      } else {
        final snackbar = SnackBar(
          content: const Text('Something went wrong'),

          // ignore: use_build_context_synchronously
          backgroundColor: Theme.of(context).primaryColor,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(50),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackbar);
      }
    }
  }

  static Future<void> google_logout(context) async {
    try {
      await GoogleSignIn().disconnect();
      FirebaseAuth.instance.signOut();
    } on FirebaseAuthException catch (error) {
      final snackbar = SnackBar(
        content: Text(error.message ?? 'Something went wrong'),

        // ignore: use_build_context_synchronously
        backgroundColor: Theme.of(context).primaryColor,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(50),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    } catch (err) {
      final snackbar = SnackBar(
        content: Text(err.toString()),

        // ignore: use_build_context_synchronously
        backgroundColor: Theme.of(context).primaryColor,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(50),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }
}
