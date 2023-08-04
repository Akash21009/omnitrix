import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:omnitrix/constants.dart';
import 'package:omnitrix/features/boxes/boxes.dart';
import 'package:omnitrix/features/quotes/data/models/quotes_model.dart';

void addQuote(BuildContext context, {QuotesModel? quote}) {
  final textController = TextEditingController();
  if (quote != null) {
    textController.text = quote.title;
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
                              quote == null
                                  ? "Write Your Quote"
                                  : "Edit Your Quote",
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
                              maxLines: null,
                              maxLength: 236,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: bright_green, width: 1),
                                ),
                                hintText: "write your quote here",
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

                                    if (textController.text.isEmpty) {
                                      if (quote != null) {
                                        quote.delete();
                                      }
                                      Navigator.pop(context);
                                      return;
                                    }

                                    if (quote == null) {
                                      var newQuote = QuotesModel(
                                          title: textController.text,
                                          image:
                                              "assets/alien${Random().nextInt(31)}.png",
                                          dateTime: DateTime.now().toString());
                                      var box = Boxes.getQuotes();
                                      box.add(newQuote);
                                      newQuote.save();
                                      Navigator.pop(context);
                                    } else {
                                      String oldTitle = quote.title;

                                      quote.title = textController.text;
                                      if (oldTitle != quote.title) {
                                        quote.image =
                                            "assets/alien${Random().nextInt(31)}.png";
                                        quote.dateTime =
                                            DateTime.now().toString();
                                      }
                                      print(
                                          "${oldTitle} ${quote.title} ${oldTitle != quote.title}");
                                      quote.save();
                                      Navigator.pop(context);
                                    }
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
                                quote != null
                                    ? InkWell(
                                        onTap: () {
                                          quote.delete();
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

              //quote image
              quote != null
                  ? Positioned(
                      right: 50,
                      top: MediaQuery.of(context).size.height / 2,
                      child: Container(
                        margin: const EdgeInsets.only(right: 50),
                        height: 250,
                        width: 250,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(quote.image),
                          ),
                        ),
                      ),
                    )
                  : Container(),
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
