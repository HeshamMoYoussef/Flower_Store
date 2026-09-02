import 'package:firebase_auth/firebase_auth.dart';
import 'package:flower_app/shared/constants.dart';
import 'package:flutter/material.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({Key? key}) : super(key: key);

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  bool isEmailVerified = false;
  bool canResendEmail = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Verify Email"),
        elevation: 0,
        backgroundColor: appBarGreen,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "A verification email has been sent to your email",
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 25),
            ElevatedButton(
              onPressed: () {
                // sendVerificationEmail();
              },
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(btnGreen),
                padding: WidgetStateProperty.all(const EdgeInsets.all(12)),
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              child: const Text("Resent Email", style: TextStyle(fontSize: 20)),
            ),
            const SizedBox(height: 11),
            ElevatedButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(btnGreen),
                padding: WidgetStateProperty.all(const EdgeInsets.all(12)),
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              child: const Text("Cancel", style: TextStyle(fontSize: 20)),
            ),
          ],
        ),
      ),
    );
  }
}
