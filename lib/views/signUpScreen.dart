// ignore_for_file: unused_local_variable

import 'package:firebase_chat/constants/common_functions.dart';
import 'package:firebase_chat/services/signup_provider.dart';
import 'package:firebase_chat/widgets/show_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/controllers.dart';
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
    pswdcontroller.dispose();
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
      appBar: AppBar(
        elevation: 10,
        backgroundColor: Colors.black38,
        title: const Text('Firebase Auth'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Icon(
                  Icons.person_2_rounded,
                  size: MediaQuery.of(context).size.height * 0.4,
                ),
                TextFormField(
                  controller: Controllers.emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!RegExp(_emailRegex).hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: Controllers.passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (!RegExp(_passwordRegex).hasMatch(value)) {
                      return 'Password must be at least 6 characters long';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: pswdcontroller,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Enter Password Again',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (!RegExp(_passwordRegex).hasMatch(value)) {
                      return 'Password must be at least 6 characters long';
                    }
                    if (Controllers.passwordController.text !=
                        pswdcontroller.text) {
                      return 'Password must match';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _handleLoginButtonPressed,
                  child: const Text(
                    'Create Account/SignUp',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
