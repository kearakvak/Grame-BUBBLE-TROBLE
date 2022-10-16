import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Player extends StatelessWidget {
  const Player({this.PlayerX, super.key});
  final PlayerX;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(PlayerX, 1),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          color: Colors.lightBlueAccent.shade400,
          height: 50,
          width: 50,
        ),
      ),
    );
  }
}
