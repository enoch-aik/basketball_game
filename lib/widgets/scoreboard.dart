import 'package:basketball_game/game/basketball_game.dart';
import 'package:flutter/material.dart';

class ScoreBoard extends StatelessWidget {
  final BasketBallGame game;

  const ScoreBoard({Key? key, required this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle style = const TextStyle(
      fontSize: 20,
      color: Colors.white,
      fontWeight: FontWeight.w700,
      fontFamily: 'Enhanced LED Board-7',
    );
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 10),
      child: Material(
        elevation: 0,
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          width: MediaQuery.of(context).size.width * 0.95,
          height: 65,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 4),
              color: Colors.black,
              borderRadius: BorderRadius.circular(15)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ValueListenableBuilder(
                  valueListenable: game.score,
                  builder: (context, score, _) {
                    return Text(
                      'PTS=> $score',
                      style: style,
                    );
                  }),
              ValueListenableBuilder(
                  valueListenable: game.timer,
                  builder: (context, time, _) {
                    String newTime = time < 10 ? '0$time' : time.toString();
                    return Text('00:$newTime <=TIME', style: style);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
