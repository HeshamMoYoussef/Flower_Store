import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flower_app/firebase_options.dart';
import 'package:flower_app/pages/home.dart';
import 'package:flower_app/pages/login.dart';
import 'package:flower_app/provider/cart_provider.dart';
import 'package:flower_app/provider/google_sign_in_provider.dart';
import 'package:flower_app/provider/registered_user_provider.dart';
import 'package:flower_app/shared/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  // Provider.debugCheckInvalidValueType = null;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ListenableProvider<GoogleSignInProvider>(
          create: (BuildContext context) => GoogleSignInProvider(),
        ),
        ListenableProvider<Cart>(create: (BuildContext context) => Cart()),
        ListenableProvider<RegisteredUserProvider>(
          create: (BuildContext context) => RegisteredUserProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,

        // VerifyEmailPage(), =>> set Functionality later =>> Don't Forget this Screen <<<<<<<<<<<<<<<<<
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.white),
              );
            } else if (snapshot.hasData) {
              debugPrint('inSide Home Screen');
              return const Home();
            } else if (snapshot.hasError) {
              return showSnackBar(context, "Something went wrong", 2);
            } else {
              debugPrint(
                '"StartRunMainFunction. Then> RunAppMyAppClass. Then>(home:StreamBuilder) Finally ">@@@@@@@@@@@@@@@@@> InSide Login Screen <@@@@@@@@@@@@@@@@@<',
              );
              return const Login();
            }
          },
        ),
      ),
    );
  }
}
