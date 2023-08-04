import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:omnitrix/constants.dart';

class TaskProgressIndicator extends StatefulWidget {
  final String? borderImage;
  final String? progressImage;
  final int? taskleft;
  final double? percentDone;
  const TaskProgressIndicator(
      {super.key,
      this.borderImage,
      this.progressImage,
      this.taskleft,
      this.percentDone});

  @override
  State<TaskProgressIndicator> createState() => _TaskProgressIndicatorState();
}

class _TaskProgressIndicatorState extends State<TaskProgressIndicator>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    double DEVICEHEIGHT = MediaQuery.of(context).size.height;
    double DEVICEWIDTH = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Container(
          height: 420,
          width: 350,
          // color: Colors.white,
        ),
        Positioned(
          top: 0,
          child: Container(
            height: 400,
            width: 350,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(green_glow), fit: BoxFit.contain),
            ),
          ),
        ),
        Positioned(
          bottom: -15,
          left: 82,
          child: Container(
            height: 60,
            width: 180,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(watch_side_view),
              ),
            ),
          ),
        ),

        //image
        Positioned(
            left: 30,
            child: Container(
              height: 350,
              width: 280,
              decoration: widget.borderImage != null
                  ? BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          widget.borderImage!,
                        ),
                        fit: BoxFit.fitWidth,
                      ),
                    )
                  : BoxDecoration(),
            )),
        widget.progressImage != null
            ? Positioned(
                left: 30,
                child: ClipRRect(
                  clipper: _PercentClipper(widget.percentDone!),
                  child: Container(
                    height: 350,
                    width: 280,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          widget.progressImage!,
                        ),
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                ))
            : Container(),

        //showing percentage
        widget.percentDone != null
            ? Positioned(
                top: 298,
                left: 125,
                child: Container(
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${(widget.percentDone! * 100).toInt()}%",
                          style: GoogleFonts.kronaOne(
                            fontSize: 35,
                            color: bright_green,
                          ),
                        ),
                        Column(
                          children: [
                            const SizedBox(height: 21),
                            Text(
                              "DONE",
                              style: GoogleFonts.kronaOne(
                                fontSize: 5,
                                color: bright_green,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : Container(),

        //showing task left
        widget.percentDone != null
            ? Positioned(
                top: 350,
                left: 125,
                child: Text(
                  "${widget.taskleft} tasks left",
                  style: GoogleFonts.kronaOne(
                    fontSize: 12,
                    color: bright_green,
                  ),
                ))
            : Positioned(
                left: 120,
                child: SizedBox(
                  width: 110,
                  child: Center(
                    child: Text(
                      "click on watch\n to go to menu",
                      style: GoogleFonts.kronaOne(
                        fontSize: 12,
                        color: bright_green,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
      ],
    );
  }
}

class _PercentClipper extends CustomClipper<RRect> {
  double _percent;

  _PercentClipper(
    this._percent,
  );

  @override
  RRect getClip(Size size) {
    double clipHeight = size.height * _percent;

    // Calculate the left position of the clipping area
    double top = size.height - clipHeight - 45;

    // Create a Rect to define the clipping area
    Rect rect = Rect.fromLTWH(0, top, size.width, clipHeight);

    // Create a RRect from the Rect with a border radius
    return RRect.fromRectAndCorners(
      rect,
    );
  }

  @override
  bool shouldReclip(covariant CustomClipper<RRect> oldClipper) => true;
}
