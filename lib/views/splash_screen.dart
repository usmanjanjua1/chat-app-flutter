import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_chat/views/Login.dart';
import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'homepage.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() {
    Future.delayed(const Duration(milliseconds: 3000), () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const LoginScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double widht = MediaQuery.of(context).size.width;
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: AnimatedSplashScreen(
              duration: 15000,
              splash: const SpinKitSquareCircle(
                color: Colors.black,
                size: 50.0,
              ),

              // const SizedBox(
              //   child: Image(
              //     image: AssetImage('chat.jpg'),
              //   ),
              // ),

              // Column(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     crossAxisAlignment: CrossAxisAlignment.center,
              //     children: [
              //       const SizedBox(
              //         child: Image(
              //           image: AssetImage('chat.jpg'),
              //         ),
              //       ),
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         crossAxisAlignment: CrossAxisAlignment.center,
              //         children: const [
              //           Text(
              //             'Connect to friends Globally',
              //             style: TextStyle(color: Colors.black, fontSize: 22),
              //           )
              //         ],
              //       )
              //     ]),
              nextScreen: const LoginScreen(),
              splashTransition: SplashTransition.fadeTransition,
              backgroundColor: Colors.white60),
        ));
  }
}
