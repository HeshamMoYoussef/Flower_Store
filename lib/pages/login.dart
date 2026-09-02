import 'package:flower_app/pages/forgot_password.dart';
import 'package:flower_app/pages/register.dart';
import 'package:flower_app/provider/google_sign_in_provider.dart';
import 'package:flower_app/shared/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../provider/registered_user_provider.dart';
import '../shared/constants.dart';
import '../utils/utils.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isVisible = true;
  bool isLoading = false;
  bool isLoadingGoogle = false;
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  RegisteredUserProvider? registeredProvider;

  setEmailField() {
    /////// Provider here //////
    final registeredProvider = Provider.of<RegisteredUserProvider>(
      context,
      listen: false,
    );
    if (registeredProvider.userEmail == null) {
      return;
    } else {
      emailController.text = registeredProvider.userEmail!;
    }
  }

  @override
  void initState() {
    setEmailField();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    registeredProvider ??
        Provider.of<RegisteredUserProvider>(context, listen: false);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /////////////////////// Providers here ////////////////////
    final registeredProvider = Provider.of<RegisteredUserProvider>(
      context,
      listen: false,
    );
    final googleProvider = Provider.of<GoogleSignInProvider>(
      context,
      listen: false,
    );
    ///////////////////////////////////////////////////////////
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign in'),
        centerTitle: true,
        backgroundColor: appBarGreen,
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    validator: (email) {
                      return isEmailValid(email);
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    obscureText: false,
                    decoration: decorationTextField.copyWith(
                      hintText: "Enter Your Email : ",
                      suffixIcon: const Icon(Icons.email),
                    ),
                  ),
                  const SizedBox(height: 35),
                  TextFormField(
                    validator: (value) {
                      return value!.length < 8
                          ? "Enter at least 8 characters"
                          : null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: passwordController,
                    keyboardType: TextInputType.text,
                    obscureText: isVisible,
                    decoration: decorationTextField.copyWith(
                      hintText: "Enter Your Password : ",
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isVisible = !isVisible;
                          });
                        },
                        icon: isVisible
                            ? const Icon(Icons.visibility_outlined)
                            : const Icon(Icons.visibility_off_outlined),
                      ),
                    ),
                  ),
                  const SizedBox(height: 35),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          isLoading = true;
                        });
                        await registeredProvider.loginUserHasRegistered(
                          context: context,
                          email: emailController.text,
                          password: passwordController.text,
                        );
                        setState(() {
                          isLoading = false;
                        });
                      } else {
                        showSnackBar(
                          context,
                          "Enter a valid Email And Password",
                          2,
                        );
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(btnGreen),
                      padding: WidgetStateProperty.all(
                        const EdgeInsets.all(12),
                      ),
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    child: isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text("Login", style: TextStyle(fontSize: 19)),
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ForgotPassword(),
                        ),
                      );
                    },
                    child: const Text(
                      "Forgot password?",
                      style: TextStyle(
                        fontSize: 16,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Row(
                    children: [
                      Expanded(
                        child: Divider(thickness: 0.4, color: Colors.black54),
                      ),
                      Text(
                        " OR Continue With ",
                        style: TextStyle(fontSize: 14),
                      ),
                      Expanded(
                        child: Divider(thickness: 0.4, color: Colors.black54),
                      ),
                    ],
                  ),
                  const SizedBox(height: 35),
                  ElevatedButton.icon(
                    onPressed: () async {
                      setState(() {
                        isLoadingGoogle = true;
                      });
                      await googleProvider.signInWithGoogle(context: context);
                      setState(() {
                        isLoadingGoogle = false;
                      });
                    },
                    icon: const FaIcon(
                      FontAwesomeIcons.google,
                      color: Colors.red,
                      size: 25,
                    ),
                    label: isLoadingGoogle
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            "Sign In With Google ",
                            style: TextStyle(fontSize: 19),
                          ),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blueGrey,
                      minimumSize: const Size(double.minPositive, 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 35),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Do not have an account?",
                        style: TextStyle(fontSize: 18),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Register(),
                            ),
                          );
                        },
                        child: const Text(
                          'Register Now',
                          style: TextStyle(
                            fontSize: 16,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
