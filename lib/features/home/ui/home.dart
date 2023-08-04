import 'dart:math';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:omnitrix/constants.dart';
import 'package:omnitrix/features/boxes/boxes.dart';
import 'package:omnitrix/features/home/ui/omnitrix.dart';
import 'package:omnitrix/features/home/ui/quick_reminder.dart';
import 'package:omnitrix/features/home/ui/task_progress_indicator.dart';
import 'package:omnitrix/features/home/ui/window_buttons.dart';
import 'package:omnitrix/features/managespace/ui/managespace.dart';
import 'package:omnitrix/features/menu/ui/menu.dart';
import 'package:omnitrix/features/tags/data/models/tags_model.dart';
import 'package:omnitrix/features/tags/data/models/task_model.dart';
import 'package:omnitrix/features/tags/ui/tags.dart';
import '../../quotes/data/models/quotes_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color hoverColor = green;
  int? hoverIndex;
  OmnitrixWidget _omnitrix = OmnitrixWidget();
  int oldHoverIndex = 0;
  QuotesModel? _randomQuote;
  Map<TaskModel, TagModel>? m;
  String? username;
  bool? soundOn;

  @override
  void initState() {
    fn();
    getUsername();

    super.initState();
  }

  void fn() async {
    var data = Boxes.getTags().values.toList().cast<TagModel>();
    data.shuffle();
    if (data.length == 0) {
      return;
    } else {
      for (int i = 0; i < data.length && i < 20; i++) {
        if (data[i].tasks.length == 0) {
          continue;
        }

        for (int j = 0; j < data[i].tasks.length && j < 10;j++){
             

            if (data[i].tasks[j].isCompleted == true) {
              continue;
            }
            if (m == null) {
              m = {};
            }
            m![data[i].tasks[j]] = data[i];
        }  
      }
      
    }
  }

  Future<dynamic> _getRandomQuote() async {
    var rq = await Hive.openBox("randomquote");
    var quoteBox = Boxes.getQuotes();

    if (quoteBox.isEmpty) {
      rq.put("randomquote", null);
    }

    if (rq.get("randomquote") == null) {
      if (quoteBox.isNotEmpty) {
        rq.put("randomquote", Random().nextInt(quoteBox.length));
      }
    } else {
      if (quoteBox.isEmpty) {
        rq.put("randomquote", null);
      } else if (rq.get("randomquote") >= quoteBox.length) {
        rq.put("randomquote", Random().nextInt(quoteBox.length));
      } else if (rq.get('today') != DateTime.now().day.toString()) {
        rq.put("randomquote", Random().nextInt(quoteBox.length));
      }
    }
    rq.put("today", DateTime.now().day.toString());
    _randomQuote = rq.get('randomquote') != null
        ? quoteBox.getAt(rq.get('randomquote'))
        : null;
    return rq;
  }

  //get username
  Future<dynamic> getUsername() async {
    var rq = await Hive.openBox("user");
    username = rq.get("name");

    return rq;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double DEVICEHEIGHT = MediaQuery.of(context).size.height;
    double DEVICEWIDTH = MediaQuery.of(context).size.width;

    //*notification box parameters
    double nbiconsize = 20;
    double nbtextleftpad = 20;
    double nbtextsize = 15;
    double nblistheight = 165;
    if (DEVICEWIDTH < 1304) {
      nbiconsize = 18;
      nbtextleftpad = 16;
      nbtextsize = 13;
    }
    if (DEVICEHEIGHT < 715) {
      nblistheight = 151;
    }

    //*tagdisplay params
    double tdlistheight = 384;
    if (DEVICEHEIGHT < 715) {
      tdlistheight = 370;
    }

    //*quotebox params
    double qbheight = 190;

    return Scaffold(
      body: ValueListenableBuilder<Box<TagModel>>(
          valueListenable: Boxes.getTags().listenable(),
          builder: (context, tagBox, _) {
            var tagData = tagBox.values.toList().cast<TagModel>();

            return Container(
              height: DEVICEHEIGHT,
              width: DEVICEWIDTH,
              decoration: const BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment(0, -0),
                  radius: 0.7,
                  colors: [
                    Color.fromARGB(255, 32, 32, 32),
                    Color.fromARGB(255, 16, 16, 16),
                    Color.fromARGB(255, 18, 18, 18),
                    Color.fromARGB(255, 9, 9, 9),
                  ],
                  focalRadius: 3,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      Container(
                        width: DEVICEWIDTH + 20,
                        height: 70,
                      ),
                      Positioned(
                        top: -5,
                        left: -10,
                        child: Container(
                          width: DEVICEWIDTH + 20,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(50),
                              bottomRight: Radius.circular(50),
                            ),
                            border: Border.all(width: 5, color: green),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 25, top: 10),
                                child: WindowTitleBarBox(
                                  child: Row(
                                    children: const [
                                      WindowButtons(),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Center(
                        child: FutureBuilder(
                            future: getUsername(),
                            builder: (context, snap) {
                              return Text(
                                "OMNITRIX ${DEVICEWIDTH > 1084 ? "- WELCOME ${username ?? "USERNAME"}" : ""}",
                                style: GoogleFonts.kronaOne(
                                  color: bright_green,
                                  fontSize: 33,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.fade,
                              );
                            }),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 100),
                        child: InkWell(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MenuScreen()));
                            },
                            child: _omnitrix),
                      ),

                      //*Quick Remider
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 50, right: 86),
                          child: QuickReminder(
                            data: m,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //* alien progress indiacator
                      hoverIndex != null
                          ? TaskProgressIndicator(
                              borderImage: tagData[hoverIndex!].borderImage,
                              progressImage: tagData[hoverIndex!].glowImage,
                              taskleft: tagData[hoverIndex!].leftTask,
                              percentDone: (tagData[hoverIndex!].tasks.length -
                                      tagData[hoverIndex!].leftTask) /
                                  (tagData[hoverIndex!].tasks.isNotEmpty
                                      ? tagData[hoverIndex!].tasks.length
                                      : 1),
                            )
                          : const TaskProgressIndicator(),

                      //tags display
                      const Spacer(),
                      Expanded(
                        flex: 3,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(width: 2, color: green),
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(30),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.only(
                                    left: 20, top: 5, bottom: 5),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(color: green, width: 2),
                                  ),
                                ),
                                child: Text(
                                  "TAGS",
                                  style: GoogleFonts.kronaOne(
                                    color: bright_green,
                                    fontSize: 20,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.fade,
                                ),
                              ),

                              //tags list
                              tagData.isNotEmpty
                                  ? SizedBox(
                                      height: tdlistheight,
                                      child: ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        itemCount: tagData.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return MouseRegion(
                                            onEnter: (PointerEnterEvent event) {
                                              setState(() {
                                                hoverIndex = index;
                                                _omnitrix = OmnitrixWidget(
                                                  rotate: true,
                                                  rcw: oldHoverIndex <= index
                                                      ? true
                                                      : false,
                                                );
                                              });
                                              oldHoverIndex = index;
                                            },
                                            onExit: (PointerExitEvent event) {
                                              setState(() {
                                                hoverIndex = null;
                                              });
                                            },
                                            child: InkWell(
                                              onTap: () {
                                                addTag(context,
                                                    tag: tagData[index],
                                                    refreshPage: HomePage());
                                              },
                                              child: Stack(
                                                children: [
                                                  ClipPath(
                                                    clipper: ClipBottom(),
                                                    child: Container(
                                                      height: 43,
                                                      width: 400,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            const BorderRadius
                                                                .only(
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  15),
                                                        ),
                                                        border: Border.all(
                                                            width: 1,
                                                            color: green),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 15, left: 20),
                                                    child: Text(
                                                      tagData[index].title,
                                                      style: GoogleFonts.amiko(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            hoverIndex == index
                                                                ? FontWeight
                                                                    .w800
                                                                : FontWeight
                                                                    .w500,
                                                        color:
                                                            hoverIndex == index
                                                                ? bright_green
                                                                : green,
                                                      ),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ))
                                  : Container(
                                      height: tdlistheight,
                                      child: Center(
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ManageSpacce()));
                                          },
                                          child: Text(
                                            "Go to manage space",
                                            style: GoogleFonts.amiko(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w800,
                                              color: bright_green,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.fade,
                                          ),
                                        ),
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      ),

                      //notification and quotes
                      const Spacer(),
                      Expanded(
                        flex: 2,
                        child: SizedBox(
                          // height: 420,
                          child: Column(
                            children: [
                              //* Notifications
                              Container(
                                padding: const EdgeInsets.only(
                                  left: 10,
                                  right: 10,
                                  top: 5,
                                ),
                                // height: 200,
                                width: 350,

                                decoration: BoxDecoration(
                                  border: Border.all(color: green, width: 1),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "NOTIFICATIONS",
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: bright_green,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.fade,
                                    ),
                                    Container(
                                      height: nblistheight,
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.vertical,
                                        child: Column(
                                          children: tagData.map((tag) {
                                            return Column(
                                              children: tag.tasks.map((t) {
                                                String dl = t.deadline!;

                                                bool expired = false;
                                                if (dl != "none" &&
                                                    DateTime.now().compareTo(
                                                            DateFormat(
                                                                    "yyyy-MM-dd HH:mm:ss")
                                                                .parse(
                                                                    "$dl:00")) >
                                                        0) {
                                                  expired = true;
                                                } else if (dl == "none" ||
                                                    dl.substring(0, 10) !=
                                                        DateTime.now()
                                                            .toString()
                                                            .substring(0, 10)) {
                                                  return Container();
                                                }
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 10),
                                                  child: InkWell(
                                                    onTap: () {
                                                      addTag(context, tag: tag);
                                                    },
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        expired
                                                            ? Icon(
                                                                Icons
                                                                    .dangerous_outlined,
                                                                color:
                                                                    Colors.red,
                                                                size:
                                                                    nbiconsize,
                                                              )
                                                            : Icon(
                                                                Icons
                                                                    .crisis_alert_sharp,
                                                                color: Colors
                                                                    .orange,
                                                                size:
                                                                    nbiconsize,
                                                              ),
                                                        Padding(
                                                          padding: EdgeInsets.only(
                                                              left:
                                                                  nbtextleftpad),
                                                          child: expired
                                                              ? Text(
                                                                  "task expired",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        nbtextsize,
                                                                    color: Colors
                                                                        .red,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                  ),
                                                                )
                                                              : Text(
                                                                  "dealine today",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        nbtextsize,
                                                                    color: Colors
                                                                        .orange,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                  ),
                                                                ),
                                                        ),
                                                        const Spacer(),
                                                        DEVICEWIDTH >= 1167
                                                            ? Text(
                                                                dl.substring(
                                                                    expired
                                                                        ? 0
                                                                        : 11),
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      nbtextsize,
                                                                  color: expired
                                                                      ? Colors
                                                                          .red
                                                                      : Colors
                                                                          .orange,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                              )
                                                            : const SizedBox(),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              }).toList(),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              //* Quotes
                              SizedBox(height: 20),
                              ClipRRect(
                                clipper: _LeftClipper(),
                                child: Container(
                                  padding: const EdgeInsets.only(
                                    left: 10,
                                    right: 10,
                                    top: 5,
                                  ),
                                  height: 190,
                                  // width: 400,
                                  decoration: BoxDecoration(
                                    border:
                                        Border.all(color: green, width: 0.5),
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(80),
                                    ),
                                  ),
                                  child: FutureBuilder<dynamic>(
                                      future: _getRandomQuote(),
                                      builder: (context, snapshot) {
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "QUOTE",
                                              style: GoogleFonts.kronaOne(
                                                fontSize: 18,
                                                color: bright_green,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Stack(
                                              clipBehavior: Clip.none,
                                              children: [
                                                Container(
                                                  // height: 110,
                                                  width: 350,
                                                  child: Text(
                                                    _randomQuote != null
                                                        ? _randomQuote!.title
                                                        : "No quotes available!\nGo to manage space and add quotes",
                                                    style: GoogleFonts.amiko(
                                                      fontSize: 12,
                                                      color: bright_green,
                                                    ),
                                                  ),
                                                ),
                                                _randomQuote != null
                                                    ? Positioned(
                                                        right: -25,
                                                        top: 60,
                                                        child: Container(
                                                          height: 90,
                                                          width: 90,
                                                          decoration:
                                                              BoxDecoration(
                                                            image:
                                                                DecorationImage(
                                                              image: AssetImage(
                                                                  _randomQuote!
                                                                      .image),
                                                              fit: BoxFit
                                                                  .contain,
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    : Container(),
                                              ],
                                            ),
                                          ],
                                        );
                                      }),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
    );
  }
}

class ClipBottom extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double clippedy = size.height - (size.height * 0.14);

    final path = Path();

    path.moveTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.lineTo(0.0, clippedy);
    path.lineTo(size.width, size.height);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class _LeftClipper extends CustomClipper<RRect> {
  @override
  RRect getClip(Size size) {
    double clipWidth = size.width * 0.98;
    Rect rect = Rect.fromLTWH(0, 0, clipWidth, size.height);
    return RRect.fromRectAndCorners(
      rect,
    );
  }

  @override
  bool shouldReclip(CustomClipper<RRect> oldClipper) {
    return false;
  }
}
