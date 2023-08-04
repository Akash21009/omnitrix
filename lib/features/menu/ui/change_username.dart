import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';

import '../../../constants.dart';

void changeUsername(BuildContext context) async {
  var u = await Hive.openBox("user");
  String? username = u.get("name");
  final textController = TextEditingController();
  if (username != null) {
    textController.text = username;
  }
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: Stack(
            children: [
              //dummy container
              SizedBox(
                height: double.infinity,
                width: double.infinity,
              ),

              Align(
                alignment: Alignment.center,
                child: Container(
                  height: 500,
                  width: 700,
                  child: Material(
                    color: Colors.transparent,
                    child: CustomPaint(
                      painter: _ClipCornersPainter(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              "Enter Username",
                              style: GoogleFonts.kronaOne(
                                fontSize: 25,
                                color: bright_green,
                              ),
                            ),
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: TextField(
                              cursorColor: bright_green,
                              controller: textController,
                              style: GoogleFonts.amiko(
                                fontSize: 20,
                                color: bright_green,
                              ),
                              maxLines: 1,
                              maxLength: 15,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: bright_green, width: 1),
                                ),
                                hintText: "write your username here",
                                filled: true,
                                fillColor:
                                    Colors.grey.shade800.withOpacity(0.5),
                                hoverColor:
                                    Colors.grey.shade800.withOpacity(0.8),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: bright_green, width: 1),
                                ),
                              ),
                            ),
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                //save
                                InkWell(
                                  onTap: () {
                                    textController.text =
                                        textController.text.trim();
                                    if (textController.text.isNotEmpty) {
                                     
                                      u.put("name", textController.text);
                                    }
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 20),
                                    height: 30,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(colors: [
                                        Colors.black,
                                        Colors.grey.shade700.withOpacity(0.5),
                                      ]),
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          width: 0.7, color: bright_green),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "save",
                                        style: GoogleFonts.amiko(
                                            fontSize: 18, color: bright_green),
                                      ),
                                    ),
                                  ),
                                ),

                                //delete
                                username != null
                                    ? InkWell(
                                        onTap: (){
                                          
                                          u.put("name", null);

                                          Navigator.pop(context);
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.only(
                                              left: 20, right: 20),
                                          height: 30,
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(colors: [
                                              Colors.black,
                                              Colors.grey.shade700
                                                  .withOpacity(0.5),
                                            ]),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                                width: 0.7,
                                                color: bright_green),
                                          ),
                                          child: Center(
                                            child: Text(
                                              "delete",
                                              style: GoogleFonts.amiko(
                                                  fontSize: 18,
                                                  color: bright_green),
                                            ),
                                          ),
                                        ),
                                      )
                                    : Container(),

                                //close
                                InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 20),
                                    height: 30,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(colors: [
                                        Colors.black,
                                        Colors.grey.shade700.withOpacity(0.5),
                                      ]),
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          width: 0.7, color: bright_green),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "close",
                                        style: GoogleFonts.amiko(
                                            fontSize: 18, color: bright_green),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      });
}

class _ClipCorners extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    path.moveTo(0.0, 0.0);
    path.lineTo(0.0, size.height * 0.85);
    path.lineTo(size.width * 0.15, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, size.height * 0.15);
    path.lineTo(size.width * 0.85, 0.0);
    path.lineTo(0.0, 0.0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class _ClipCornersPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var path = _ClipCorners().getClip(size);

    // Paint for fill
    var fillPaint = Paint()
      ..color =
          Colors.black.withOpacity(0.7) // Set your desired fill color here
      ..style = PaintingStyle.fill;

    // Paint for stroke (outline)
    var strokePaint = Paint()
      ..color = bright_green // Set your desired stroke color here
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0; // Set the stroke width as per your requirement

    // Draw the path with fill and stroke
    canvas.drawPath(path, fillPaint);
    canvas.drawPath(path, strokePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
