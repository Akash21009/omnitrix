import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:omnitrix/constants.dart';

class WindowButtons extends StatelessWidget {
  const WindowButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MinimizeWindowButton(
          colors: WindowButtonColors(
            iconNormal: green,
            mouseOver: bright_green,
             
          ),
        ),
        MaximizeWindowButton(
          colors: WindowButtonColors(
            iconNormal: green,
            mouseOver: bright_green,
             
          ),
        ),
        CloseWindowButton(
          colors: WindowButtonColors(
            iconNormal: green,
            mouseOver: bright_green,
             
          ),
        ),
      ],
    );
  }
}