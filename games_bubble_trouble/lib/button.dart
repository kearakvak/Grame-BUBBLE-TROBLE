import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Button extends StatelessWidget {
  Button({this.icon, this.function});
  final icon;
  final function;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          color: Color.fromARGB(255, 255, 245, 245),
          width: 50,
          height: 50,
          child: Center(
            child: Icon(
              icon ?? Icons.logo_dev_outlined,
              color: Color.fromARGB(255, 27, 189, 238),
            ),
          ),
        ),
      ),
    );
  }
}
