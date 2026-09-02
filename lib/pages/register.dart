import 'package:flower_app/pages/login.dart';
import 'package:flower_app/provider/registered_user_provider.dart';
import 'package:flower_app/shared/show_model_img_picker.dart';
import 'package:flower_app/shared/snackbar.dart';
import 'package:flower_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:provider/provider.dart';

import '../shared/constants.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  bool isVisible = true;
  bool isLoading = false;
  bool pwValidator = false;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();
  final ageController = TextEditingController();
  final titleController = TextEditingController();

  RegisteredUserProvider? registeredProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    registeredProvider ??
        Provider.of<RegisteredUserProvider>(context, listen: false);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
    ageController.dispose();
    titleController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /////////////////////// Provider here ////////////////////
    debugPrint('Inside Register Screen');
    final registeredProvider = Provider.of<RegisteredUserProvider>(
      context,
      listen: false,
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
        centerTitle: true,
        backgroundColor: appBarGreen,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(
          top: 25,
          bottom: 25,
          left: 25,
          right: 25,
        ),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                ///////////////////////////
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: appBarGreen,
                    // Color.fromARGB(125, 78, 91, 110),
                  ),
                  child: Stack(
                    children: [
                      registeredProvider.imgPath == null
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
                          : ClipOval(
                              child: Image.file(
                                registeredProvider.imgPath!,
                                width: 145,
                                height: 145,
                                fit: BoxFit.cover,
                              ),
                            ),
                      Positioned(
                        right: -10,
                        bottom: -12,
                        child: IconButton(
                          onPressed: () async {
                            await showModel(
                              context: context,
                              setState: setState,
                            );
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

                const SizedBox(height: 20),

                TextFormField(
                  // we return "null" when something is valid
                  validator: (value) {
                    return value!.length < 6 ? "Enter Your UserName" : null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: usernameController,
                  keyboardType: TextInputType.text,
                  obscureText: false,
                  decoration: decorationTextField.copyWith(
                    hintText: "Enter UserName : ",
                    suffixIcon: const Icon(Icons.person_outlined),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  // we return "null" when something is valid
                  validator: (value) {
                    return value!.length < 2 ? "Enter Your Age" : null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: ageController,
                  keyboardType: TextInputType.number,
                  obscureText: false,
                  decoration: decorationTextField.copyWith(
                    hintText: "Enter age : ",
                    suffixIcon: const Icon(Icons.person_add_alt),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  // we return "null" when something is valid
                  validator: (value) {
                    return value!.length < 3 ? "Enter Your Title" : null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: titleController,
                  keyboardType: TextInputType.text,
                  obscureText: false,
                  decoration: decorationTextField.copyWith(
                    hintText: "Enter Title : ",
                    suffixIcon: const Icon(Icons.person_pin_sharp),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  // we return "null" when something is valid
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
                const SizedBox(height: 20),
                TextFormField(
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      setState(() {
                        pwValidator = true;
                      });
                    } else if (value.isEmpty) {
                      setState(() {
                        pwValidator = false;
                      });
                    }
                  },
                  // we return "null" when something is valid
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
                const SizedBox(height: 8),
                if (pwValidator)
                  FlutterPwValidator(
                    controller: passwordController,
                    minLength: 8,
                    uppercaseCharCount: 1,
                    lowercaseCharCount: 1,
                    numericCharCount: 1,
                    specialCharCount: 1,
                    width: 400,
                    height: 140,
                    onSuccess: () {
                      showSnackBar(context, "Right Password", 2);
                    },
                    // onFail: () {
                    //   // showSnackBar(context, "Wrong Password",1);
                    // },
                  )
                else
                  const SizedBox(height: 0),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate() &&
                        registeredProvider.imgPath != null &&
                        registeredProvider.imgName != null) {
                      setState(() {
                        isLoading = true;
                      });
                      await registeredProvider.newRegisterUser(
                        context: context,
                        username: usernameController.text,
                        age: ageController.text,
                        title: titleController.text,
                        email: emailController.text,
                        password: passwordController.text,
                      );
                      setState(() {
                        isLoading = false;
                      });
                    } else if (registeredProvider.imgPath == null) {
                      showSnackBar(context, "Enter An Image", 2);
                    } else {
                      showSnackBar(
                        context,
                        "Enter a valid Email,Password And Image",
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
                      : const Text("Register", style: TextStyle(fontSize: 19)),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "have an account?",
                      style: TextStyle(fontSize: 18),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Login(),
                          ),
                        );
                      },
                      child: const Text(
                        'SIGN IN',
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
    );
  }
}
