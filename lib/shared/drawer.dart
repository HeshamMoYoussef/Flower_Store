import 'package:firebase_auth/firebase_auth.dart';
import 'package:flower_app/pages/check_out.dart';
import 'package:flower_app/pages/home.dart';
import 'package:flower_app/shared/snackbar.dart';
import 'package:flower_app/shared/user_img_from_firestore.dart';
import 'package:flutter/material.dart';

import '../pages/login.dart';
import '../pages/profile.dart';
import '../provider/google_sign_in_provider.dart';
import 'constants.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    super.key,
    required this.user,
    required this.googleProvider,
  });

  final User user;
  final GoogleSignInProvider googleProvider;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              UserAccountsDrawerHeader(
                margin: const EdgeInsets.all(0.5),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      user.photoURL ??
                          "https://img.freepik.com/free-vector/gradient-network-connection-background_23-2148881320.jpg",
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                accountName: user.displayName != null
                    ? Text(
                        "${user.displayName}",
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : const Text(''),
                accountEmail: Text(
                  "${user.email}",
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                currentAccountPictureSize: const Size.square(85),
                currentAccountPicture: const ImgUser(),

                // googleProvider.googleSignIn != null
                //     // (user.uid.isEmpty)
                //     // (registeredProvider.url == null)
                //     ? CircleAvatar(
                //         backgroundColor: Color.fromARGB(255, 225, 225, 225),
                //         radius: 70,
                //         // backgroundImage: AssetImage("assets/img/avatar.png"),
                //         backgroundImage: AssetImage("assets/img/avatar.png"),
                //       )
                //     :

                // ImgUser(),
              ),
              ListTile(
                title: const Text(
                  "Home",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                ),
                leading: const Icon(Icons.home, size: 40, color: appBarGreen),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const Home()),
                  );
                },
              ),
              ListTile(
                title: const Text(
                  "My products",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                ),
                leading: const Icon(
                  Icons.add_shopping_cart,
                  size: 40,
                  color: appBarGreen,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CheckOut()),
                  );
                },
              ),
              ListTile(
                title: const Text(
                  "About",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                ),
                leading: const Icon(
                  Icons.help_center,
                  size: 40,
                  color: appBarGreen,
                ),
                onTap: () {},
              ),
              ListTile(
                title: const Text(
                  "My Profile",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                ),
                leading: const Icon(
                  Icons.personal_injury_outlined,
                  size: 40,
                  color: appBarGreen,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProfilePage()),
                  );
                },
              ),
              ListTile(
                title: const Text(
                  "Logout",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                ),
                leading: const Icon(
                  Icons.exit_to_app,
                  size: 40,
                  color: appBarGreen,
                ),
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  googleProvider.googleSignIn.signOut();
                  debugPrint('logout');
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const Login()),
                  );
                  showSnackBar(context, "Goodbye", 3);
                },
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 12),
            child: const Text(
              "Developed by ~HESHAM^MOHAMED~ ©2023",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Colors.teal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
