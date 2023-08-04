import 'package:firebase_chat/services/auth_provider.dart';
import 'package:firebase_chat/views/signUpScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/common_functions.dart';
import '../constants/controllers.dart';
import '../constants/strings.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    Controllers.emailController.dispose();
    Controllers.passwordController.dispose();
    super.dispose();
  }

  void _handleLoginButtonPressed() async {
    if (CommonFuncs.validateForm(_formKey)) {
      String email = Controllers.emailController.text;
      String password = Controllers.passwordController.text;
      AuthProvider authProvider = Provider.of<AuthProvider>(context,
          listen: false); ///////////////////////Provider is here
      print("Provider created");
      // Call the signIn method from the AuthProvider
      var user = await authProvider.signIn(email, password, context);
      print("signin called");
      print('Email: ${Controllers.emailController.text}');
      print('Password: ${Controllers.passwordController.text}');
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
                  size: MediaQuery.of(context).size.height * 0.28,
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
                    if (!RegExp(MyStrings.emailRegex).hasMatch(value)) {
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
                    if (!RegExp(MyStrings.passwordRegex).hasMatch(value)) {
                      return 'Password must be at least 6 characters long';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _handleLoginButtonPressed,
                  child: const Text(
                    'Login',
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Not a user?'),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignUpScreen(),
                              ));
                        },
                        child: const Text("SignUp>"))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
