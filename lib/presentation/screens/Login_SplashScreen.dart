import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:bsi_info_apps/presentation/screens/homepage_screen.dart';
import 'package:bsi_info_apps/presentation/screens/mainpage_screen.dart';
import 'package:bsi_info_apps/presentation/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoginSpalshScreen extends StatelessWidget {
  const LoginSpalshScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(splash:
    Column (
      children: [
        Center(
          child: LottieBuilder.asset("assets/Lottie/Animation - 1712279224073.json",height: 400,),
        )
      ],
    ),
      nextScreen: const MainPage(),
    splashIconSize: 400,
    backgroundColor: const Color.fromARGB(255, 107, 159, 248),
    );
  }
}
