import 'package:lmloan/config/constants.dart';
import 'package:lmloan/styles/color.dart';
import 'package:lmloan/styles/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 23, 18, 90),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width:300, height: 300, child: Image(image: AssetImage('assets/images/loan_2.png'))),
            // const Icon(
            //   Icons.monetization_on_outlined,
            //   size: 150,
            // ),
            Text(
              appName,
              style: AppTheme.splashScreenStyle(color: whiteColor),
              
            ),
            Text(
              'For a Better Life!.',
              style: AppTheme.titleStyle(color: primaryColor),
            )
          ],
        ),
      ),
    );
  }

  void _navigate() {
    Future.delayed(const Duration(seconds: 3), () {
      if (FirebaseAuth.instance.currentUser != null) {
        context.go('/loan_dashboard');
      } else {
        context.go('/register_screen');
      }
    });
  }
}
