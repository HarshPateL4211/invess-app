import 'dart:async';
import 'package:flutter/material.dart';
import '../../core/routes.dart';
// import '../../screens/auth/login_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigate();
  }

  void _navigate() {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, AppRoutes.login);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2), // light grey
      body: SafeArea(
        child: Column(
          children: [
            /// Center Logo Section
            Expanded(
              child: Center(
                child: Image.asset(
                  "assets/images/invess.png",  // use your logo here
                  height: 90,
                ),
              ),
            ),

            /// Bottom Section
            Padding(
              padding: const EdgeInsets.only(bottom: 25),
              child: Column(
                children: [
                  // Image.asset(
                  //   "assets/images/lets_encrypt.png", // small lock icon image
                  //   height: 24,
                  // ),
                  // const SizedBox(height: 6),
                  const Text(
                    "Secured by\nLet's Encrypt",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
