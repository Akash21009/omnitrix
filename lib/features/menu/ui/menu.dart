import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:omnitrix/features/home/ui/home.dart';
import 'package:omnitrix/features/managespace/ui/managespace.dart';
import 'package:omnitrix/features/menu/ui/change_username.dart';

import '../../../constants.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    double sclFtr = 5;
    double oc = 0.80;
    double DEVICEHEIGHT = MediaQuery.of(context).size.height;
    double DEVICEWIDTH = MediaQuery.of(context).size.width;


    if (DEVICEHEIGHT < 770) {
      sclFtr = 4;

      if (DEVICEHEIGHT < 644) {
        sclFtr = 3;
      }
    }



    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/bg_image.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: ClipOval(
              child: Container(
                height: 150 * sclFtr,
                width: 150 * sclFtr,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 28, 28, 28),
                      Color.fromARGB(255, 82, 82, 82)
                    ],
                  ),
                ),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: ClipOval(
                        child: Container(
                          color: bright_green,
                          height: 10 * sclFtr,
                          width: 10 * sclFtr,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: ClipOval(
                        child: Container(
                          color: bright_green,
                          height: 10 * sclFtr,
                          width: 10 * sclFtr,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ClipOval(
                        child: Container(
                          color: bright_green,
                          height: 10 * sclFtr,
                          width: 10 * sclFtr,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: ClipOval(
                        child: Container(
                          color: bright_green,
                          height: 10 * sclFtr,
                          width: 10 * sclFtr,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Center(
            child: ClipOval(
              child: Container(
                height: 130 * sclFtr,
                width: 130 * sclFtr,
                color: Colors.black,
                child: Center(
                  child: ClipOval(
                    child: Container(
                      height: 120 * sclFtr,
                      width: 120 * sclFtr,
                      color: bright_green,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned(
                            top: -200,
                            left: -500,
                            child: Transform.rotate(
                              angle: -0.785398,
                              child: ClipPath(
                                clipper: _OmniClipper(oc),
                                child: Container(
                                  height: 200 * sclFtr,
                                  width: 200 * sclFtr,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: -200,
                            right: -500,
                            child: Transform.rotate(
                              angle: 2.35619,
                              child: ClipPath(
                                clipper: _OmniClipper(oc),
                                child: Container(
                                  height: 200 * sclFtr,
                                  width: 200 * sclFtr,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),

                          Center(
                            child: Transform.rotate(
                              angle: -0.785398,
                              child: ClipPath(
                                clipper: _OmniClipper2(oc),
                                child: Container(
                                  height: 70 * sclFtr,
                                  width: 70 * sclFtr,
                                  color: bright_green,
                                ),
                              ),
                            ),
                          ),
                          Center(
                            child: Transform.rotate(
                              angle: 2.35619,
                              child: ClipPath(
                                clipper: _OmniClipper2(oc),
                                child: Container(
                                  height: 70 * sclFtr,
                                  width: 70 * sclFtr,
                                  color: bright_green,
                                ),
                              ),
                            ),
                          ),

                          //menu items
                          Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                //change username
                                InkWell(
                                  onTap: () {
                                    changeUsername(context);
                                  },
                                  child: Text(
                                    "Change Username",
                                    style: GoogleFonts.kronaOne(
                                        fontSize: 15, color: Colors.black),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),

                                //back to workspace
                                InkWell(
                                  onTap: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => HomePage()));
                                  },
                                  child: Text(
                                    "Workspace",
                                    style: GoogleFonts.kronaOne(
                                        fontSize: 15, color: Colors.black),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),

                                //go to workspace
                                InkWell(
                                  onTap: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ManageSpacce()));
                                  },
                                  child: Text(
                                    "Manage Space",
                                    style: GoogleFonts.kronaOne(
                                        fontSize: 15, color: Colors.black),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                

                                //close
                                InkWell(
                                  onTap: () {
                                    if (Platform.isWindows ||
                                        Platform.isLinux) {
                                      exit(0);
                                    }
                                  },
                                  child: Text(
                                    "Exit",
                                    style: GoogleFonts.kronaOne(
                                        fontSize: 15, color: Colors.black),
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
            ),
          ),
        ],
      ),
    );
  }
}

class _OmniClipper extends CustomClipper<Path> {
  double oc;
  @override
  Path getClip(Size size) {
    var path = Path();
    double clipped = oc;

    path.moveTo(0.0, 0.0);
    path.lineTo(0.0, size.height);
    path.lineTo(size.width * clipped, size.height * clipped);
    path.lineTo(size.width, 0.0);
    path.lineTo(0.0, 0.0);

    return path;
  }

  _OmniClipper(
    this.oc,
  );

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class _OmniClipper2 extends CustomClipper<Path> {
  double oc;
  @override
  Path getClip(Size size) {
    var path = Path();
    double clipped = oc;

    path.lineTo(0.0, size.height);
    path.lineTo(size.width * clipped, size.height * clipped);
    path.lineTo(size.width, 0.0);
    path.lineTo(0.0, size.height);

    return path;
  }

  _OmniClipper2(
    this.oc,
  );

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
