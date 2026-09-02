import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ImgUser extends StatefulWidget {
  const ImgUser({Key? key}) : super(key: key);

  @override
  State<ImgUser> createState() => _ImgUserState();
}

class _ImgUserState extends State<ImgUser> {
  final credential = FirebaseAuth.instance.currentUser;
  CollectionReference users = FirebaseFirestore.instance.collection('userS');
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(credential!.uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          //**********//
          debugPrint("Document does not exist");
          return const CircleAvatar(
            backgroundColor: Color.fromARGB(255, 225, 225, 225),
            radius: 70,
            backgroundImage: AssetImage("assets/img/avatar.png"),
          );
          // Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;

          return user.photoURL != null
              ? ClipOval(
                  child: Image(
                    width: 145,
                    height: 145,
                    fit: BoxFit.cover,
                    image: NetworkImage("${user.photoURL}"),
                  ),
                )
              : CircleAvatar(
                  backgroundColor: const Color.fromARGB(255, 225, 225, 225),
                  radius: 70,
                  // backgroundImage: AssetImage("assets/img/avatar.png"),
                  backgroundImage: NetworkImage(data["imgLink"]),
                );
        }

        return const Text("loading");
      },
    );
  }
}
