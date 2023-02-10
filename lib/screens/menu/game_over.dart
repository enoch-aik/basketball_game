import 'package:basketball_game/components/ball.dart';
import 'package:basketball_game/game/basketball_game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lottie/lottie.dart';

class GameOverScreen extends StatelessWidget {
  final BasketBallGame game;

  const GameOverScreen({Key? key, required this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Center(
      child: Material(
        color: Colors.transparent,
        elevation: 0,
        child: Container(
          width: screenSize.width * 0.9,
          height: screenSize.height * 0.4,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(15)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                  height: 150,
                  child: Lottie.asset('assets/animation/gameover.json')),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 32.0),
                child: Text(
                  'You scored ${game.score.value} points',
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Enhanced LED Board-7',
                      fontSize: 17),
                ),
              ),
              SizedBox(
                  height: 40,
                  width: screenSize.width * 0.7,
                  child: ElevatedButton(
                      onPressed: () {
                        game.resetScore();
                        game.resetTimer();
                        game.resumeEngine();
                        game.overlays.remove(GameOverlays.gameOver.name);
                        game.overlays.add(GameOverlays.scoreboard.name);
                        game.add(BallComponent());
                        FlameAudio.bgm.resume();
                      },
                      child: const Text(
                        'Play Again',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Enhanced LED Board-7',
                            fontSize: 14),
                      ).animate().fade(duration: 500.ms).scale(delay: 500.ms)))
            ],
          ),
        ),
      ),
    );
  }
}
