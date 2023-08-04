import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:omnitrix/constants.dart';

class OmnitrixWidget extends StatefulWidget {
  final bool rotate;

  final bool rcw;

  

  OmnitrixWidget(
      {super.key, this.rotate = false, this.rcw = true,});

  @override
  State<OmnitrixWidget> createState() => _OmnitrixWidgetState();
}

class _OmnitrixWidgetState extends State<OmnitrixWidget>
    with SingleTickerProviderStateMixin {
  double _rotateAngle = 0.0;
  late Animation _animation;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _animation = Tween<double>(begin: 0.0, end: 90.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void didUpdateWidget(OmnitrixWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.rotate) {
      if (widget.rcw) {
        rcw();
      } else {
        racw();
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void rcw() {
    setState(() {
      _animation = Tween<double>(begin: 0.0, end: 90).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
      );
    });
    _animationController.forward(from: 0.0);
  }

  void racw() {
    setState(() {
      _animation = Tween<double>(begin: 0.0, end: -90).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
      );
    });
    _animationController.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipOval(
          child: Container(
            height: 150,
            width: 150,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 28, 28, 28),
                  Color.fromARGB(173, 82, 82, 82)
                ],
              ),
            ),
            child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: _animation.value * 0.0174533,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: ClipOval(
                            child: Container(
                              color: bright_green,
                              height: 10,
                              width: 10,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: ClipOval(
                            child: Container(
                              color: bright_green,
                              height: 10,
                              width: 10,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: ClipOval(
                            child: Container(
                              color: bright_green,
                              height: 10,
                              width: 10,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: ClipOval(
                            child: Container(
                              color: bright_green,
                              height: 10,
                              width: 10,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          ),
        ),
        Positioned(
          left: 10,
          top: 10,
          child: ClipOval(
            child: Container(
              height: 130,
              width: 130,
              color: Colors.black,
              child: Center(
                child: ClipOval(
                  child: Container(
                    height: 120,
                    width: 120,
                    color: green,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Positioned(
                          top: -40,
                          left: -135,
                          child: Transform.rotate(
                            angle: -0.785398,
                            child: ClipPath(
                              clipper: _OmniClipper(),
                              child: Container(
                                height: 200,
                                width: 200,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: -40,
                          right: -135,
                          child: Transform.rotate(
                            angle: 2.35619,
                            child: ClipPath(
                              clipper: _OmniClipper(),
                              child: Container(
                                height: 200,
                                width: 200,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _OmniClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    double clipped = 0.80;

    path.moveTo(0.0, 0.0);
    path.lineTo(0.0, size.height);
    path.lineTo(size.width * clipped, size.height * clipped);
    path.lineTo(size.width, 0.0);
    path.lineTo(0.0, 0.0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
