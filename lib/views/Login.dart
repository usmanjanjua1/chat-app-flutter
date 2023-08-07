import 'package:firebase_chat/services/auth_provider.dart';
import 'package:firebase_chat/views/signUpScreen.dart';
import 'package:firebase_chat/views/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/common_functions.dart';
import '../constants/controllers.dart';
import '../constants/strings.dart';
import '../widgets/customEmailTextField.dart';
import '../widgets/customPasswordTExtField.dart';
import '../widgets/welcomBar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    Controllers.emailController.clear();
    Controllers.passwordController.clear();
    super.dispose();
  }

  void _handleLoginButtonPressed() async {
    if (CommonFuncs.validateForm(_formKey)) {
      String email = Controllers.emailController.text;
      String password = Controllers.passwordController.text;
      AuthProvider authProvider = Provider.of<AuthProvider>(context,
          listen: false); ///////////////////////Provider is here

      // Call the signIn method from the AuthProvider
      var user = await authProvider.signIn(email, password, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double widht = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white70, Colors.white38],
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
                    welcomTextBar(CommonStrings.welcomText),
                    const Image(
                      image: AssetImage('assets/chat.jpg'),
                    ),
                    emailTextField(),
                    const SizedBox(height: 16),
                    passwordTExtField(),
                    const SizedBox(height: 16),
                    loginButton(),
                    const SizedBox(
                      height: 10,
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
        ]),
      ),
    );
  }

  Widget loginButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          alignment: Alignment.center,
          elevation: 10,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)))),
      onPressed: _handleLoginButtonPressed,
      child: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          'Login',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
