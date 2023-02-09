import 'dart:ui';

import 'package:basketball_game/game/basketball_game.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../constants/image_assets.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Game basketballGame = BasketBallGame();
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/${ImageAssets.mural2}',
            width: screenSize.width,
            height: screenSize.height,
            fit: BoxFit.cover,
          ),
          Center(
            child: Container(
              alignment: Alignment.center,
              height: screenSize.height * 0.7,
              width: screenSize.width * 0.8,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Basketball game developed with Flame',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Enhanced LED Board-7',
                          fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: SizedBox(
                          width: screenSize.width * 0.8,
                          height: 40,
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>GameWidget(game: basketballGame)));
                              },
                              child: const Text(
                                'Start Game',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Enhanced LED Board-7',
                                    fontSize: 14),
                              )
                                  .animate()
                                  .fade(duration: 500.ms)
                                  .scale(delay: 500.ms))),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
