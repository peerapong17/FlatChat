import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:login_ui/utils/show_snackbar.dart';

class Auth {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> signInOrCreate(BuildContext context, String email,
      String password, Widget page, String type) async {
    try {
      if (type == "SIGNIN") {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => page,
          ),
          (route) => false,
        );
      } else {
        await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => page,
          ),
        );
      }
    } on FirebaseException catch (error) {
      showSnack(error.message!, context);
    }
  }

  Future<void> signInWithGoogle(BuildContext context, Widget page) async {
    final GoogleSignInAccount? googleSignInAccount =
        await _googleSignIn.signIn();

    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount!.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);

    try {
      await _auth.signInWithCredential(credential);
      Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (context) => page,
        ),
      );
    } on FirebaseAuthException catch (error) {
      showSnack(error.message!, context);
    }
  }
}
