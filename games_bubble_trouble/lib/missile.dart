import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Missile extends StatelessWidget {
  const Missile({this.height, this.missileX, super.key});
  final missileX;
  final height;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(missileX, 1),
      child: Container(
        height: height,
        width: 2,
        color: Colors.red,
      ),
    );
  }
}
