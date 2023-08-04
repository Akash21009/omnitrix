import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:omnitrix/constants.dart';
import 'package:omnitrix/features/boxes/boxes.dart';
import 'package:omnitrix/features/tags/data/models/tags_model.dart';
import 'package:omnitrix/features/tags/data/models/task_model.dart';

class QuickReminder extends StatefulWidget {
  final Map<TaskModel, TagModel>? data;
  const QuickReminder({super.key, this.data});

  @override
  State<QuickReminder> createState() => _QuickReminderState();
}

//custom clipper 0
class _RightClipper extends CustomClipper<RRect> {
  @override
  RRect getClip(Size size) {
    // Calculate the width to clip (10% of the total width)
    double clipWidth = size.width * 0.99;

    // Calculate the left position of the clipping area
    double left = size.width - clipWidth;

    // Create a Rect to define the clipping area
    Rect rect = Rect.fromLTWH(left, 0, clipWidth, size.height);

    // Create a RRect from the Rect with a border radius
    return RRect.fromRectAndCorners(rect,
        topRight: Radius.circular(70), bottomRight: Radius.circular(70));
  }

  @override
  bool shouldReclip(CustomClipper<RRect> oldClipper) {
    return false;
  }
}

//custom clipper 1
class _CornerClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double clippedx = size.width * 0.1;

    final path = Path();

    path.moveTo(0.0, size.height);
    path.lineTo(clippedx, 0.0);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0.0);
    path.lineTo(clippedx, 0.0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class _QuickReminderState extends State<QuickReminder>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<int> _aniimationTask;
  late Animation<int> _aniimationTaskDes;
  String? _tagname;
  String? _taskdate;
  String? _taskdeadline;
  int index = 0;
  List<TaskModel> l = [];
  Timer? timer;

  @override
  void initState() {
    super.initState();
    if (widget.data != null) {
      l = widget.data!.keys.toList();
      l.shuffle();
    }
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _aniimationTask =
        IntTween(begin: 0, end: l.isNotEmpty ? l[index].title.length : 8)
            .animate(_animationController);
    _aniimationTaskDes =
        IntTween(begin: 0, end: l.isNotEmpty ? l[index].description!.length : 0)
            .animate(_animationController);
    _tagname = widget.data != null ? widget.data![l[index]]!.title : null;
    _taskdate = widget.data != null ? l[index].creatDate : null;
    _taskdeadline = widget.data != null ? l[index].deadline : null;
    _animationController.addListener(() {
      setState(() {});
    });

    timer = Timer.periodic(Duration(seconds: 5), (Timer timer) {
      index = l.isNotEmpty ? (index + 1) % l.length : 0;
      _aniimationTask =
          IntTween(begin: 0, end: l.isNotEmpty ? l[index].title.length : 8)
              .animate(_animationController);
      _aniimationTaskDes = IntTween(
              begin: 0, end: l.isNotEmpty ? l[index].description!.length : 0)
          .animate(_animationController);
      _tagname = widget.data != null ? widget.data![l[index]]!.title : null;
      _taskdate = widget.data != null ? l[index].creatDate : null;
      _taskdeadline = widget.data != null ? l[index].deadline : null;

      _animationController.forward(from: 0.0);
    });

    _animationController.forward(from: 0.0);
  }

  @override
  void dispose() {
    timer?.cancel();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double DEVICEHEIGHT = MediaQuery.of(context).size.height;
    double DEVICEWIDTH = MediaQuery.of(context).size.width;

    //remiderbox parameters
    double rbtitlesize = 25;
    double rbheight = 175;
    if (DEVICEHEIGHT < 715) {
      rbheight = 155;
      rbtitlesize = 20;
    }

    return ClipRRect(
      clipper: _RightClipper(),
      child: Container(
        height: rbheight,
        width: DEVICEWIDTH,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(70),
            bottomRight: Radius.circular(70),
          ),
          border: Border.all(width: 3, color: bright_green),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 30),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "QUICK REMINDER",
                  style: GoogleFonts.kronaOne(
                    color: bright_green,
                    fontSize: rbtitlesize,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              const SizedBox(height: 10),

              //task show
              Column(
                children: [
                  //*task title
                  widget.data != null
                      ? Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "${l[index].title.substring(0, _aniimationTask.value)}_",
                            style: GoogleFonts.amiko(
                              fontSize: 15.0,
                              color: bright_green,
                              fontWeight: FontWeight.w800,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        )
                      : Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "${("No Tasks_").substring(0, _aniimationTask.value)}",
                            style: GoogleFonts.amiko(
                              fontSize: 15.0,
                              color: bright_green,
                              fontWeight: FontWeight.w800,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),

                  //*task des
                  widget.data != null
                      ? Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            l[index].description != "none"
                                ? "${l[index].description!.substring(0, _aniimationTaskDes.value)}_"
                                : "",
                            style: GoogleFonts.amiko(
                              fontSize: 11.0,
                              color: bright_green,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      : Container(),
                ],
              ),

              const Spacer(),
              //details display
              Align(
                alignment: Alignment.bottomLeft,
                child: ClipPath(
                  clipper: _CornerClipper(),
                  child: IntrinsicWidth(
                    child: Container(
                      height: 20,
                      padding:
                          const EdgeInsets.only(top: 3, left: 30, right: 10),
                      color: bright_green,
                      child: Center(
                        child: widget.data != null
                            ? Text(
                                "Tag-${_tagname}  /  Edited-${_taskdate!.substring(0, 19)}  /  Deadline-${_taskdeadline}",
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                                overflow: TextOverflow.ellipsis,
                              )
                            : Container(),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
