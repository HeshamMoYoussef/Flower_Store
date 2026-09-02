import 'package:firebase_auth/firebase_auth.dart';
import 'package:flower_app/pages/login.dart';
import 'package:flower_app/provider/google_sign_in_provider.dart';
import 'package:flower_app/shared/constants.dart';
import 'package:flower_app/shared/data_from_firestore.dart';
import 'package:flower_app/shared/profile_dialog_with_functions.dart';
import 'package:flower_app/shared/show_model_img_picker.dart';
import 'package:flower_app/shared/user_img_from_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    /////////////////////// Providers here ////////////////////
    final googleProvider = Provider.of<GoogleSignInProvider>(
      context,
      listen: false,
    );
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton.icon(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              googleProvider.googleSignIn.signOut();
              debugPrint('logout');
              if (!mounted) return;
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const Login()),
              );
            },
            label: const Text(
              "logout",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            icon: const Icon(Icons.logout, color: Colors.white, size: 25),
          ),
        ],
        backgroundColor: appBarGreen,
        title: const Text(
          "Profile Page",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: appBarGreen,
                    // Color.fromARGB(125, 78, 91, 110),
                  ),
                  child: Stack(
                    children: [
                      // registeredProvider.url == null

                      // (registeredProvider.url == null)
                      (user!.uid.isEmpty)
                          ? const CircleAvatar(
                              backgroundColor: Color.fromARGB(
                                255,
                                225,
                                225,
                                225,
                              ),
                              radius: 70,
                              // backgroundImage: AssetImage("assets/img/avatar.png"),
                              backgroundImage: AssetImage(
                                "assets/img/avatar.png",
                              ),
                            )
                          : const ImgUser(),
                      Positioned(
                        right: -10,
                        bottom: -12,
                        child: IconButton(
                          onPressed: () async {
                            await showModel(
                              context: context,
                              setState: setState,
                            );
                            //////////////////////////////////////////////////////////////////////////////
                          },
                          icon: const Icon(
                            Icons.add_a_photo,
                            color: Colors.grey,
                          ),
                          color: const Color.fromARGB(255, 94, 115, 128),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Container(
                  padding: const EdgeInsets.all(11),
                  decoration: BoxDecoration(
                    color: appBarGreen,
                    borderRadius: BorderRadius.circular(11),
                  ),
                  child: const Text(
                    "Info from firebase Auth",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 25),
                  Text("Email: ${user!.email}",
                      style: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 15),
                  Text(
                    "Created date: ${DateFormat('d, MMM, y').format(user!.metadata.creationTime!)}",
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    "Last Signed In: ${DateFormat('d, MMM, y').format(user!.metadata.lastSignInTime!)}",
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              Center(
                child: TextButton(
                  onPressed: () {
                    deleteUser(context);
                  },
                  child:
                      const Text("Delete User", style: TextStyle(fontSize: 18)),
                ),
              ),
              const SizedBox(height: 15),
              Center(
                child: Container(
                  padding: const EdgeInsets.all(11),
                  decoration: BoxDecoration(
                    color: appBarGreen,
                    borderRadius: BorderRadius.circular(11),
                  ),
                  child: const Text(
                    "Info from firebase firestore",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
              GetDataFromFirestore(documentId: user!.uid),
            ],
          ),
        ),
      ),
    );
  }
}
