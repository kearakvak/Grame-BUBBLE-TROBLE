import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:games_bubble_trouble/ball.dart';
import 'package:games_bubble_trouble/button.dart';
import 'package:games_bubble_trouble/missile.dart';
import 'package:games_bubble_trouble/player.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

enum direction { LEFT, RIGHT }

class _HomePageState extends State<HomePage> {
  static double PlayerX = 0;

  double missileX = PlayerX;
  double missileHeight = 10;
  bool midShot = false;

  double ballX = 0.5;
  double ballY = 1;
  var ballDirection = direction.LEFT;

  void startGame() {
    double time = 0;
    double height = 0;
    double velocity = 60;
    Timer.periodic(Duration(milliseconds: 10), (timer) {
      height = -5 * time * time + velocity * time;

      if (height < 0) {
        time = 0;
      }

      setState(() {
        ballY = heightToPosition(height);
      });

      if (ballX - 0.05 < -1) {
        ballDirection = direction.RIGHT;
      } else if (ballX + 0.05 > 1) {
        ballDirection = direction.LEFT;
      }
      if (ballDirection == direction.LEFT) {
        setState(() {
          ballX -= 0.05;
        });
      } else if (ballDirection == direction.RIGHT) {
        setState(() {
          ballX += 0.05;
        });
      }

      if (playerDies()) {
        timer.cancel();
        _showDialog();
      }

      time += 0.1;
    });
  }

  void _showDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.grey.shade700,
            title: Text(
              'You dead bro',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          );
        });
  }

  void MoveLeft() {
    setState(() {
      print(PlayerX);
      // if (PlayerX > -0.9) {
      //   PlayerX -= 0.1;
      //   print(PlayerX);
      // } else {}

      if (PlayerX - 0.1 < -1) {
      } else {
        PlayerX -= 0.1;
      }
      if (!midShot) {
        missileX = PlayerX;
      }
    });
  }

  void MoveRight() {
    setState(() {
      print(PlayerX);
      // if (PlayerX < 0.9) {
      //   PlayerX += 0.1;
      //   print(PlayerX);
      // } else {}

      if (PlayerX + 0.1 > 1) {
      } else {
        PlayerX += 0.1;
      }
      if (!midShot) {
        missileX = PlayerX;
      }
    });
  }

  void FireMissile() {
    if (midShot == false) {
      Timer.periodic(
        Duration(milliseconds: 20),
        (timer) {
          midShot = true;
          setState(() {
            missileHeight += 10;
          });

          if (missileHeight > MediaQuery.of(context).size.height * 3 / 4) {
            resetMissile();
            timer.cancel();
          }

          if (ballY > heightToPosition(missileHeight) &&
              (ballX - missileX).abs() < 0.03) {
            resetMissile();
            ballX = 5;
            timer.cancel();
          }
        },
      );
    }
  }

  double heightToPosition(double height) {
    double totalHeight = MediaQuery.of(context).size.height * 3 / 4;
    double prosition = 1 - 2 * height / totalHeight;
    return prosition;
  }

  void resetMissile() {
    missileX = PlayerX;
    missileHeight = 10;
    midShot = false;
  }

  bool playerDies() {
    if ((ballX - PlayerX).abs() < 0.05 && ballY > 0.95) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      onKey: (event) {
        if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
          MoveLeft();
        } else if (event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
          MoveRight();
        } else if (event.isKeyPressed(LogicalKeyboardKey.space)) {
          FireMissile();
        }
      },
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              color: Colors.pink.shade200,
              child: Center(
                child: Stack(
                  children: [
                    Ball(
                      ballX: ballX,
                      ballY: ballY,
                    ),
                    Missile(
                      height: missileHeight,
                      missileX: missileX,
                    ),
                    Player(
                      PlayerX: PlayerX,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.blueGrey.shade400,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Button(
                    icon: Icons.play_arrow,
                    function: startGame,
                  ),
                  Button(
                    icon: Icons.arrow_back_ios_new_outlined,
                    function: MoveLeft,
                  ),
                  Button(
                    icon: Icons.arrow_circle_up_outlined,
                    function: FireMissile,
                  ),
                  Button(
                    icon: Icons.arrow_forward_ios_rounded,
                    function: MoveRight,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
