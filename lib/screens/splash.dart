import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:basketball_game/constants/image_assets.dart';
import 'package:basketball_game/screens/main_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 4000), () async {
      Navigator.pushReplacement(context,
          CupertinoPageRoute(builder: (context) => const MainMenuScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Roulette(
            duration: const Duration(seconds: 4),
            infinite: true,
            child: Image.asset(
              ImageAssets.flamedBasketballSprite,
              width: 240,
            )),
      ),
    );
  }
}
