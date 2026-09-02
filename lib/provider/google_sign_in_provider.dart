import 'package:firebase_auth/firebase_auth.dart';
import 'package:flower_app/pages/home.dart';
import 'package:flower_app/shared/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider with ChangeNotifier {
  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  signInWithGoogle({context}) async {
    debugPrint('Inside signInWithGoogle');
    try {
      // begin interactive sign in process
      final GoogleSignInAccount? user = await GoogleSignIn().signIn();
      // obtain auth details from request
      if (user != null) {
        final GoogleSignInAuthentication googleAuthentication =
            await user.authentication; // how to handle A null value ?????

        // create a new credential for user
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuthentication.accessToken,
          idToken: googleAuthentication.idToken,
        );
        // finally, lets sign in
        await FirebaseAuth.instance.signInWithCredential(credential);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Home()),
        );
      } else {
        return;
      }
      showSnackBar(context, "successfully signInWithGoogle", 3);
      debugPrint('successfully signInWithGoogle');
    } on FirebaseAuthException catch (e) {
      debugPrint('signIn Error: ${e.toString()}');
      showSnackBar(context, "Check Your Internet", 3);
    }
    debugPrint('finished signInWithGoogle');

    notifyListeners();
  }
}
