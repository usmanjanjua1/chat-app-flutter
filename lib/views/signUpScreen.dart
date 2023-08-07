// ignore_for_file: unused_local_variable

import 'package:firebase_chat/constants/common_functions.dart';
import 'package:firebase_chat/services/signup_provider.dart';
import 'package:firebase_chat/views/utils/strings.dart';
import 'package:firebase_chat/widgets/show_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/controllers.dart';
import '../widgets/customEmailTextField.dart';
import '../widgets/customPasswordTExtField.dart';
import '../widgets/welcomBar.dart';
import 'homePage.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _emailRegex = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
  final _passwordRegex = r'^.{6,}$';
  final _formKey = GlobalKey<FormState>();
  final pswdcontroller = TextEditingController();

  @override
  void dispose() {
    Controllers.emailController.dispose();
    Controllers.passwordController.dispose();

    super.dispose();
  }

  bool _validateForm() {
    final isValid = _formKey.currentState?.validate();
    return isValid ?? false;
  }

  void _handleLoginButtonPressed() {
    bool isSignedUp = false;
    if (CommonFuncs.validateForm(_formKey)) {
      String email = Controllers.emailController.text;
      String password = Controllers.passwordController.text;
      SignUpProvider authProvider =
          Provider.of<SignUpProvider>(context, listen: false);
      var user = authProvider.signUp(email, password);
      isSignedUp = true;
    } else {
      showCustomSnackBar(context, "Error signingUp/User Already Created");
    }
    if (isSignedUp) {
      print('Created');
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.grey, Colors.blue.shade200],
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
          ),
        ),
        child: ListView(children: [
          AppBar(
            backgroundColor: Colors.blue.shade200,
            title: const Text('Firebase Auth'),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    welcomTextBar(CommonStrings.signUpText),
                    Icon(
                      Icons.person_add_alt,
                      size: MediaQuery.of(context).size.height * 0.3,
                    ),
                    emailTextField(),

                    SizedBox(height: 16),
                    passwordTExtField(),

                    SizedBox(height: 16),
                    // TextFormField(
                    //   controller: pswdcontroller,
                    //   obscureText: true,
                    //   decoration: const InputDecoration(
                    //     labelText: 'Enter Password Again',
                    //   ),
                    //   validator: (value) {
                    //     if (value == null || value.isEmpty) {
                    //       return 'Please enter your password';
                    //     }
                    //     if (!RegExp(_passwordRegex).hasMatch(value)) {
                    //       return 'Password must be at least 6 characters long';
                    //     }
                    //     if (Controllers.passwordController.text !=
                    //         pswdcontroller.text) {
                    //       return 'Password must match';
                    //     }
                    //     return null;
                    //   },
                    // ),
                    passwordTExtField(),
                    SizedBox(
                      height: 25,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.indigo.shade400,
                          alignment: Alignment.center,
                          elevation: 10,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)))),
                      onPressed: _handleLoginButtonPressed,
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Create Account/SignUp',
                            style: TextStyle(fontSize: 20)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
