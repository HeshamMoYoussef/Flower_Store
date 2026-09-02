import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flower_app/pages/home.dart';
import 'package:flower_app/pages/login.dart';
import 'package:flower_app/shared/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' show basename;

class RegisteredUserProvider with ChangeNotifier {
  // UserData? userEmail;
  String? userEmail;
  File? imgPath;
  String? imgName;
  String? url;

  newRegisterUser({context, email, password, username, age, title}) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      // Upload image to firebase storage
      final storageRef = FirebaseStorage.instance.ref('userImages/$imgName');
      await storageRef.putFile(imgPath!);
      // Get img url
      url = await storageRef.getDownloadURL();
      debugPrint("url is : $url");

      // User Added Data  <<
      CollectionReference users = FirebaseFirestore.instance.collection(
        'userS',
      );
      users
          .doc(credential.user!.uid)
          .set({
            'username': username,
            'age': age,
            "title": title,
            "email": email,
            "imgLink": url,
          })
          .then((value) => debugPrint("User Added"))
          .catchError((error) => debugPrint("Failed to add user: $error"));

      showSnackBar(context, "Successfully Register", 2);
      debugPrint('Successfully Register');
      // userEmail = email;
      setUserEmail(email);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Login()),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        debugPrint('The account already exists for that email.');
        showSnackBar(context, "The account already exists for that email.", 3);
      }
    } catch (e) {
      showSnackBar(context, "Error : $e", 3);
      debugPrint("Error is : $e");
    }
    notifyListeners();
  }

  loginUserHasRegistered({context, email, password}) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Home()),
      );
      showSnackBar(context, "Welcome", 2);
      debugPrint('LoginByRegisteredUser successfully');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        // print('No user found for that email.');
        showSnackBar(context, "No user found for that email.", 2);
      } else if (e.code == 'wrong-password') {
        // print('Wrong password provided for that user.');
        showSnackBar(context, "Wrong password provided for that user.", 2);
      } else {
        showSnackBar(context, "No Internet Connection", 2);
      }
    }
    notifyListeners();
  }

  void setUserEmail(userEmail) {
    this.userEmail = userEmail;
    notifyListeners();
  }

  uploadImage2Screen({setState, imageSource}) async {
    debugPrint("will select img");
    final pickedImg = await ImagePicker().pickImage(source: imageSource);
    debugPrint("Noooooo select img");
    try {
      debugPrint("TRY select img");

      if (pickedImg != null) {
        setState(() {
          imgPath = File(pickedImg.path);
          imgName = basename(pickedImg.path);
          imgName = "${Random().nextInt(9999999)}$imgName";
        });
        debugPrint('imgName: $imgName \n imgPath: $imgPath');
        debugPrint("Have selected img");
      } else {
        debugPrint("NO img selected");
      }
    } catch (e) {
      debugPrint("Error => $e");
    }
    notifyListeners();
  }
}
