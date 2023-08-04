import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:omnitrix/features/boxes/boxes.dart';
import 'package:omnitrix/features/home/ui/home.dart';
import 'package:omnitrix/features/tags/data/models/tags_model.dart';
import 'package:omnitrix/features/tags/data/models/task_model.dart';

import '../../../constants.dart';

void addTag(BuildContext context, {TagModel? tag, HomePage? refreshPage}) {
  final textController = TextEditingController();

  final tasktitlecontroller = TextEditingController();
  final taskdescriptiomController = TextEditingController();
  final taskdeadlineController = TextEditingController();

  bool showAddTask = false;
  String? pickedDate;
  String? pickedTime;
  String? rpickedDate;
  String? rpickedTime;

  if (tag != null) {
    textController.text = tag.title;
  }

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          double DEVICEHEIGHT = MediaQuery.of(context).size.height;
          double DEVICEWIDTH = MediaQuery.of(context).size.width;
          return Center(
            child: Stack(
              children: [
                //dummy container
                SizedBox(
                  height: double.infinity,
                  width: double.infinity,
                ),

                //*all tags in background
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: DEVICEHEIGHT - 118,
                    width: 900,
                    child: Material(
                      color: Colors.transparent,
                      child: CustomPaint(
                        painter: _ClipCornersPainter(),
                        child: ValueListenableBuilder<Box<TagModel>>(
                            valueListenable: Boxes.getTags().listenable(),
                            builder: (context, box, _) {
                              return Stack(
                                children: [
                                  SizedBox(
                                    height: 650,
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 10),

                                            //*Enter Tag Name or Show Tag Name
                                            child: TextField(
                                              controller: textController,
                                              cursorColor: bright_green,
                                              maxLines: 1,
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.kronaOne(
                                                fontSize: 25,
                                                color: bright_green,
                                              ),
                                              decoration: InputDecoration(
                                                hintText: "Enter Tag Name",
                                                hintStyle: GoogleFonts.kronaOne(
                                                  fontSize: 25,
                                                  color: bright_green
                                                      .withOpacity(0.5),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.transparent,
                                                      width: 1),
                                                ),
                                              ),
                                            ),
                                          ),

                                          //*Enter new task
                                          showAddTask == false
                                              ? InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      showAddTask = true;
                                                    });
                                                  },
                                                  child: Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            top: 20),
                                                    height: 60,
                                                    width: 600,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                        width: 0.7,
                                                        color: bright_green,
                                                      ),
                                                    ),
                                                    child: Center(
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            "add new task",
                                                            style: GoogleFonts
                                                                .amiko(
                                                              color:
                                                                  bright_green,
                                                              fontSize: 20,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            width: 10,
                                                          ),
                                                          Icon(
                                                            Icons.add,
                                                            color: bright_green,
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ))
                                              : Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10,
                                                          right: 10,
                                                          top: 10,
                                                          bottom: 10),
                                                  margin: const EdgeInsets.only(
                                                      top: 20),
                                                  width: 600,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      width: 0.7,
                                                      color: bright_green,
                                                    ),
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      //add task title
                                                      TextField(
                                                        controller:
                                                            tasktitlecontroller,
                                                        cursorColor:
                                                            bright_green,
                                                        maxLines: 3,
                                                        style:
                                                            GoogleFonts.amiko(
                                                          color: bright_green,
                                                          fontSize: 15,
                                                        ),
                                                        decoration:
                                                            InputDecoration(
                                                          hintText:
                                                              "Enter Task",
                                                          hintStyle: TextStyle(
                                                              color: bright_green
                                                                  .withOpacity(
                                                                      0.5),
                                                              fontSize: 15),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                                    color:
                                                                        green,
                                                                    width: 0.1),
                                                          ),
                                                        ),
                                                      ),

                                                      //add task description
                                                      TextField(
                                                        controller:
                                                            taskdescriptiomController,
                                                        maxLines: 3,
                                                        cursorColor:
                                                            bright_green,
                                                        style:
                                                            GoogleFonts.amiko(
                                                          color: bright_green,
                                                          fontSize: 15,
                                                        ),
                                                        decoration:
                                                            InputDecoration(
                                                          hintText:
                                                              "Enter Task Description(optional)",
                                                          hintStyle: TextStyle(
                                                              color: bright_green
                                                                  .withOpacity(
                                                                      0.5),
                                                              fontSize: 15),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                                    color:
                                                                        green,
                                                                    width: 0.1),
                                                          ),
                                                        ),
                                                      ),

                                                      //deadline
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            "Deadline(optional)",
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                color:
                                                                    bright_green),
                                                          ),

                                                          //*pick date
                                                          const SizedBox(
                                                            width: 20,
                                                          ),

                                                          InkWell(
                                                            onTap: () async {
                                                              String?
                                                                  selectedDate =
                                                                  await showCalendarDatePicker(
                                                                      context);
                                                              setState(() {
                                                                pickedDate =
                                                                    selectedDate;
                                                              });
                                                            },
                                                            child: Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top: 3,
                                                                      left: 5,
                                                                      right: 5),
                                                              height: 20,
                                                              decoration:
                                                                  BoxDecoration(
                                                                border: Border.all(
                                                                    width: 0.2,
                                                                    color:
                                                                        bright_green),
                                                              ),
                                                              child: Text(
                                                                pickedDate ??
                                                                    "pick date",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        10,
                                                                    color:
                                                                        bright_green),
                                                              ),
                                                            ),
                                                          ),

                                                          //*pick time
                                                          const SizedBox(
                                                            width: 20,
                                                          ),
                                                          InkWell(
                                                            onTap: () async {
                                                              String?
                                                                  selectedTime =
                                                                  await showCustomTimePicker(
                                                                      context);
                                                              setState(() {
                                                                pickedTime =
                                                                    selectedTime;
                                                              });
                                                            },
                                                            child: Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top: 3,
                                                                      left: 10,
                                                                      right:
                                                                          10),
                                                              height: 20,
                                                              decoration:
                                                                  BoxDecoration(
                                                                border: Border.all(
                                                                    width: 0.2,
                                                                    color:
                                                                        bright_green),
                                                              ),
                                                              child: Text(
                                                                pickedTime ??
                                                                    "pick time",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        10,
                                                                    color:
                                                                        bright_green),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),

                                                      // buttons
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                bottom: 10,
                                                                right: 10),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            //add task confirm button
                                                            InkWell(
                                                              onTap: () {
                                                                if (textController
                                                                    .text
                                                                    .isEmpty) {
                                                                  print(
                                                                      textController
                                                                          .text);
                                                                  missingField(
                                                                      context,
                                                                      "Enter Tag Name First");
                                                                  return;
                                                                }
                                                                if (tasktitlecontroller
                                                                    .text
                                                                    .isEmpty) {
                                                                  missingField(
                                                                      context,
                                                                      "Enter Task");
                                                                  return;
                                                                } else {
                                                                  if (tag ==
                                                                      null) {
                                                                    String s = alienloadbar[
                                                                        Random()
                                                                            .nextInt(alienloadbar.length)];

                                                                    setState(
                                                                        () {
                                                                      tag = TagModel(
                                                                          tasks: [],
                                                                          glowImage:
                                                                              "${s}_glow.png",
                                                                          borderImage:
                                                                              "${s}_border.png",
                                                                          creatDate: DateTime.now()
                                                                              .toString(),
                                                                          title: textController
                                                                              .text,
                                                                          leftTask:
                                                                              0);

                                                                      box.add(
                                                                          tag!);
                                                                    });
                                                                  } else if (tag!
                                                                          .title !=
                                                                      textController
                                                                          .text) {
                                                                    tag!.title =
                                                                        textController
                                                                            .text;
                                                                    tag!.save();
                                                                  }

                                                                  //*checking if user inputs correct datetime or not
                                                                  if (pickedDate !=
                                                                          null &&
                                                                      pickedTime ==
                                                                          null) {
                                                                    pickedTime =
                                                                        "23:59";
                                                                  }
                                                                  if (pickedDate ==
                                                                          null &&
                                                                      pickedTime !=
                                                                          null) {
                                                                    pickedDate = DateTime
                                                                            .now()
                                                                        .toString()
                                                                        .substring(
                                                                            0,
                                                                            10);
                                                                  }

                                                                  if (pickedDate !=
                                                                          null &&
                                                                      pickedTime !=
                                                                          null) {
                                                                    // taskdeadlineController
                                                                    //         .text =
                                                                    String s =
                                                                        "${pickedDate} ${pickedTime}";
                                                                    if (DateTime.now()
                                                                            .compareTo(DateFormat("yyyy-MM-dd HH:mm:ss").parse("${s}:00")) >
                                                                        0) {
                                                                      pickedTime =
                                                                          null;
                                                                      missingField(
                                                                          context,
                                                                          "please enter appropriate time");
                                                                      return;
                                                                    }
                                                                    taskdeadlineController
                                                                        .text = s;
                                                                  }

                                                                  TaskModel t =
                                                                      TaskModel(
                                                                    title:
                                                                        tasktitlecontroller
                                                                            .text,
                                                                    description: taskdescriptiomController
                                                                            .text
                                                                            .isEmpty
                                                                        ? "none"
                                                                        : taskdescriptiomController
                                                                            .text,
                                                                    deadline: taskdeadlineController
                                                                            .text
                                                                            .isEmpty
                                                                        ? "none"
                                                                        : taskdeadlineController
                                                                            .text,
                                                                    isCompleted:
                                                                        false,
                                                                    creatDate: DateTime
                                                                            .now()
                                                                        .toString(),
                                                                  );

                                                                  setState(() {
                                                                    tag!.tasks
                                                                        .add(t);
                                                                    tag!.leftTask +=
                                                                        1;
                                                                    tag!.save();
                                                                    tasktitlecontroller
                                                                        .clear();
                                                                    taskdeadlineController
                                                                        .clear();
                                                                    taskdescriptiomController
                                                                        .clear();
                                                                    pickedDate =
                                                                        null;
                                                                    pickedTime =
                                                                        null;
                                                                    showAddTask =
                                                                        false;
                                                                  });
                                                                }
                                                              },
                                                              child: Text(
                                                                "add",
                                                                style: TextStyle(
                                                                    color:
                                                                        bright_green,
                                                                    fontSize:
                                                                        12),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              width: 20,
                                                            ),
                                                            InkWell(
                                                                onTap: () {
                                                                  setState(() {
                                                                    tasktitlecontroller
                                                                        .clear();
                                                                    taskdeadlineController
                                                                        .clear();
                                                                    taskdescriptiomController
                                                                        .clear();
                                                                    pickedDate =
                                                                        null;
                                                                    pickedTime =
                                                                        null;
                                                                    showAddTask =
                                                                        false;
                                                                  });
                                                                },
                                                                child: Text(
                                                                  "cancle",
                                                                  style: TextStyle(
                                                                      color:
                                                                          bright_green,
                                                                      fontSize:
                                                                          12),
                                                                )),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),

                                          //show tasks in this tag
                                          tag != null
                                              ? Column(
                                                  children:
                                                      tag!.tasks.map((val) {
                                                    return Column(
                                                      children: [
                                                        Container(
                                                          margin:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 20),
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 5,
                                                                  left: 10,
                                                                  right: 10,
                                                                  bottom: 5),
                                                          width: 600,
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                              width: 0.7,
                                                              color:
                                                                  bright_green,
                                                            ),
                                                          ),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                val.title,
                                                                style:
                                                                    GoogleFonts
                                                                        .amiko(
                                                                  color:
                                                                      bright_green,
                                                                  fontSize: 25,
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                height: 20,
                                                              ),
                                                              Text(
                                                                  "description: ${val.description!}",
                                                                  style:
                                                                      GoogleFonts
                                                                          .amiko(
                                                                    color:
                                                                        green,
                                                                    fontSize:
                                                                        15,
                                                                  )),
                                                            ],
                                                          ),
                                                        ),

                                                        //*deadline,edit,delete,mark as done
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 150,
                                                                  right: 150),
                                                          child: Row(
                                                            children: [
                                                              //*handel deadline
                                                              Container(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        top: 3,
                                                                        left:
                                                                            10,
                                                                        right:
                                                                            10),
                                                                height: 20,
                                                                color: val.isCompleted ==
                                                                        false
                                                                    ? val.deadline ==
                                                                            "none"
                                                                        ? Color.fromRGBO(
                                                                            255,
                                                                            230,
                                                                            0,
                                                                            0.911)
                                                                        : val.deadline == "none" ||
                                                                                DateTime.now().compareTo(DateFormat("yyyy-MM-dd HH:mm:ss").parse("${val.deadline}:00")) < 0
                                                                            ? Colors.orange
                                                                            : Colors.red
                                                                    : bright_green,
                                                                child: val.isCompleted ==
                                                                        false
                                                                    ? val.deadline ==
                                                                                "none" ||
                                                                            DateTime.now().compareTo(DateFormat("yyyy-MM-dd HH:mm:ss").parse("${val.deadline}:00")) <
                                                                                0
                                                                        ? Text(
                                                                            "deadline :${val.deadline!}",
                                                                            style:
                                                                                GoogleFonts.amiko(
                                                                              color: Colors.white,
                                                                              fontSize: 12,
                                                                            ),
                                                                          )
                                                                        : Text(
                                                                            "Expired",
                                                                            style:
                                                                                GoogleFonts.amiko(
                                                                              color: Colors.white,
                                                                              fontSize: 12,
                                                                            ),
                                                                          )
                                                                    : Text(
                                                                        "completed",
                                                                        style: GoogleFonts
                                                                            .amiko(
                                                                          color:
                                                                              Colors.white,
                                                                          fontSize:
                                                                              12,
                                                                        ),
                                                                      ),
                                                              ),
                                                              const Spacer(),
                                                              val.isCompleted ==
                                                                      false
                                                                  ? InkWell(
                                                                      onTap:
                                                                          () {
                                                                        if ((val.deadline == "none" ||
                                                                                DateTime.now().compareTo(DateFormat("yyyy-MM-dd HH:mm:ss").parse("${val.deadline}:00")) <= 0) ==
                                                                            true) {
                                                                          val.isCompleted =
                                                                              true;
                                                                          val.deadline =
                                                                              "none";
                                                                          tag!.leftTask -=
                                                                              1;
                                                                          tag!.save();
                                                                        }

                                                                        setState(
                                                                            () {});
                                                                      },
                                                                      child: val.deadline == "none" ||
                                                                              DateTime.now().compareTo(DateFormat("yyyy-MM-dd HH:mm:ss").parse("${val.deadline}:00")) <= 0
                                                                          ? Container(
                                                                              padding: const EdgeInsets.only(top: 3, left: 10, right: 10),
                                                                              height: 20,
                                                                              color: green,
                                                                              child: Text(
                                                                                "done?",
                                                                                style: GoogleFonts.amiko(
                                                                                  color: Colors.white,
                                                                                  fontSize: 12,
                                                                                ),
                                                                              ),
                                                                            )
                                                                          : Container(),
                                                                    )
                                                                  : Container(),

                                                              const SizedBox(
                                                                  width: 15),
                                                              InkWell(
                                                                onTap: () {
                                                                  tag!.leftTask -=
                                                                      val.isCompleted ==
                                                                              false
                                                                          ? 1
                                                                          : 0;
                                                                  tag!.tasks
                                                                      .remove(
                                                                          val);
                                                                  setState(
                                                                      () {});
                                                                },
                                                                child:
                                                                    Container(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      top: 3,
                                                                      left: 10,
                                                                      right:
                                                                          10),
                                                                  height: 20,
                                                                  color: Colors
                                                                      .red,
                                                                  child: Text(
                                                                    "delete",
                                                                    style: GoogleFonts
                                                                        .amiko(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          12,
                                                                    ),
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    );
                                                  }).toList(),
                                                )
                                              : Container(),
                                        ],
                                      ),
                                    ),
                                  ),

                                  //buttons to navigate
                                  Align(
                                    alignment: Alignment(0, 1.3),
                                    child: Container(
                                      width: 600,
                                      height: 200,
                                      child: Padding(
                                        padding: const EdgeInsets.only(),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            //save
                                            InkWell(
                                              onTap: () {
                                                if (textController
                                                    .text.isEmpty) {
                                                  missingField(context,
                                                      "Enter Tag Name");
                                                  return;
                                                }
                                                if (tag == null) {
                                                  String s = alienloadbar[
                                                      Random().nextInt(
                                                          alienloadbar.length)];
                                                  tag = TagModel(
                                                      tasks: [],
                                                      glowImage:
                                                          "${s}_glow.png",
                                                      borderImage:
                                                          "${s}_border.png",
                                                      creatDate: DateTime.now()
                                                          .toString(),
                                                      title:
                                                          textController.text,
                                                      leftTask: 0);
                                                  box.add(tag!);
                                                }
                                                if (tag != null &&
                                                    textController.text ==
                                                        tag!.title) {
                                                  tag!.title =
                                                      textController.text;
                                                  tag!.save();
                                                }
                                                Navigator.pop(context);
                                                if (refreshPage != null) {
                                                  Navigator.pushReplacement(
                                                      context, PageRouteBuilder(
                                                          pageBuilder: ((context,
                                                              animation,
                                                              secondaryAnimation) {
                                                    return refreshPage;
                                                  }),transitionDuration: Duration(microseconds: 0)));
                                                }
                                              },
                                              child: Container(
                                                padding: const EdgeInsets.only(
                                                    left: 20, right: 20),
                                                height: 30,
                                                decoration: BoxDecoration(
                                                  gradient:
                                                      LinearGradient(colors: [
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
                                                    "save",
                                                    style: GoogleFonts.amiko(
                                                        fontSize: 18,
                                                        color: bright_green),
                                                  ),
                                                ),
                                              ),
                                            ),

                                            //delete
                                            tag != null
                                                ? InkWell(
                                                    onTap: () {
                                                      tag!.delete();
                                                      Navigator.pop(context);
                                                      if (refreshPage != null) {
                                                        Navigator.pushReplacement(
                                                      context, PageRouteBuilder(
                                                          pageBuilder: ((context,
                                                              animation,
                                                              secondaryAnimation) {
                                                    return refreshPage;
                                                  }),transitionDuration: Duration(microseconds: 0)));
                                                      }
                                                    },
                                                    child: Container(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 20,
                                                              right: 20),
                                                      height: 30,
                                                      decoration: BoxDecoration(
                                                        gradient:
                                                            LinearGradient(
                                                                colors: [
                                                              Colors.black,
                                                              Colors
                                                                  .grey.shade700
                                                                  .withOpacity(
                                                                      0.5),
                                                            ]),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        border: Border.all(
                                                            width: 0.7,
                                                            color:
                                                                bright_green),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          "delete",
                                                          style: GoogleFonts.amiko(
                                                              fontSize: 18,
                                                              color:
                                                                  bright_green),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                : Container(),

                                            //close
                                            InkWell(
                                              onTap: () {
                                                Navigator.pop(context);
                                                if (refreshPage != null) {
                                                  Navigator.pushReplacement(
                                                      context, PageRouteBuilder(
                                                          pageBuilder: ((context,
                                                              animation,
                                                              secondaryAnimation) {
                                                    return refreshPage;
                                                  }),transitionDuration: Duration(microseconds: 0)));
                                                  // Navigator.pushReplacement(
                                                  //     context,
                                                  //     MaterialPageRoute(
                                                  //         builder: (context) =>
                                                  //             HomePage()));
                                                }
                                              },
                                              child: Container(
                                                padding: const EdgeInsets.only(
                                                    left: 20, right: 20),
                                                height: 30,
                                                decoration: BoxDecoration(
                                                  gradient:
                                                      LinearGradient(colors: [
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
                                                    "close",
                                                    style: GoogleFonts.amiko(
                                                        fontSize: 18,
                                                        color: bright_green),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}

// Rest of your code remains the same.

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

void missingField(context, String s) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 100,
          width: 100,
          child: Material(
            color: Colors.red.withOpacity(0.1),
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Center(
                child: Text(
                  s,
                  style: GoogleFonts.kronaOne(
                    color: Colors.red,
                    fontSize: 40,
                  ),
                ),
              ),
            ),
          ),
        );
      });
}

//datepicker

Future<String?> showCalendarDatePicker(BuildContext context) async {
  DateTime? selectedDate;

  selectedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime.now(),
    lastDate: DateTime(DateTime.now().year + 3),
    builder: (BuildContext context, Widget? child) {
      return Center(
        child: Container(
          height: 300,
          width: 500,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: bright_green),
          ),
          child: Theme(
            data: ThemeData().copyWith(
              colorScheme: ColorScheme.dark(
                primary: bright_green,
                onPrimary: Colors.white,
                surface: Colors.black.withOpacity(0.9),
                onSurface: green,
              ),
              dialogBackgroundColor: Colors.black.withOpacity(0.9),
            ),
            child: child!,
          ),
        ),
      );
    },
  );

  if (selectedDate != null) {
    // Format the selected date to the desired format
    String formattedDate =
        "${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}";
    return formattedDate;
  }

  return null; // User canceled the date picker
}

//Time picker
Future<String?> showCustomTimePicker(BuildContext context) async {
  TimeOfDay? selectedTime = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
    builder: (BuildContext context, Widget? child) {
      return Center(
        child: Container(
          height: 300,
          width: 500,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: bright_green),
          ),
          child: Theme(
            data: ThemeData.light().copyWith(
              colorScheme: ColorScheme.dark(
                primary: bright_green,
                onPrimary: Colors.white,
                surface: Colors.black.withOpacity(0.9),
                onSurface: green,
              ),
              dialogBackgroundColor: Colors.black.withOpacity(0.9),
            ),
            child: child!,
          ),
        ),
      );
    },
  );

  if (selectedTime != null) {
    // Format the selected time to the desired format
    String formattedTime = selectedTime.format(context);
    return formattedTime;
  }

  return null; // User canceled the time picker
}
