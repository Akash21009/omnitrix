import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:omnitrix/features/boxes/boxes.dart';
import 'package:omnitrix/features/quotes/data/models/quotes_model.dart';
import 'package:omnitrix/features/quotes/ui/add_quote.dart';
import 'package:omnitrix/features/tags/data/models/tags_model.dart';
import 'package:omnitrix/features/tags/ui/tags.dart';

import '../../../constants.dart';
import '../../home/ui/home.dart';
import '../../home/ui/window_buttons.dart';

class ManageSpacce extends StatelessWidget {
  const ManageSpacce({super.key});

  @override
  Widget build(BuildContext context) {
    double DEVICEHEIGHT = MediaQuery.of(context).size.height;
    double DEVICEWIDTH = MediaQuery.of(context).size.width;
    
    return Scaffold(
      body: Container(
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
          children: [
            //title
            Stack(
              children: [
                Container(
                  width: DEVICEWIDTH + 20,
                  height: 70,
                  // color: Colors.white,
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
                          padding: const EdgeInsets.only(right: 25, top: 10),
                          child: WindowTitleBarBox(
                            child: Row(
                              children: [
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
                  child: Text(
                    DEVICEWIDTH > 1084 ?"Manage Space":"",
                    style: GoogleFonts.kronaOne(
                      color: bright_green,
                      fontSize: 36,
                    ),
                  ),
                ),
                Positioned(
                  left: 30,
                  top: 5,
                  child: InkWell(
                    onTap: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => HomePage()));
                    },
                    child: Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(back_button),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //tags
                SizedBox(
                  height: DEVICEHEIGHT-200,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Text(
                          "All Tags",
                          style: GoogleFonts.kronaOne(
                            fontSize: 18,
                            color: bright_green,
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        //* new tag
                        InkWell(
                          onTap: () {
                            addTag(context);
                          },
                          child: Stack(
                            children: [
                              ClipPath(
                                clipper: ClipBottom(),
                                child: Container(
                                  height: 30,
                                  width: 500,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(15),
                                    ),
                                    border: Border.all(width: 1, color: green),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 20,
                                child: Row(
                                  children: [
                                    Text(
                                      "add new tag",
                                      style: GoogleFonts.amiko(
                                        fontSize: 15,
                                        color: bright_green,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Icon(
                                      Icons.add,
                                      color: bright_green,
                                      size: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                                  
                        ValueListenableBuilder<Box<TagModel>>(
                            valueListenable: Boxes.getTags().listenable(),
                            builder: (context, box, _) {
                              var tagsData = box.values.toList().cast<TagModel>();
                              return Column(
                                children: tagsData.map((data) {
                                  return InkWell(
                                    onTap: () {
                                      addTag(context, tag: data);
                                    },
                                    child: Stack(
                                      children: [
                                        ClipPath(
                                          clipper: ClipBottom(),
                                          child: Container(
                                            height: 30,
                                            width: 500,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.only(
                                                bottomLeft: Radius.circular(15),
                                              ),
                                              border: Border.all(
                                                  width: 1, color: green),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 10,
                                          left: 20,
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(right: 30),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                //*tag title
                                                SizedBox(
                                                  width: 350,
                                                  height: 18,
                                                  child: Text(
                                                    data.title,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: GoogleFonts.amiko(
                                                      fontSize: 15,
                                                      color: green,
                                                    ),
                                                  ),
                                                ),
                                  
                                                //*datetime
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  data.creatDate.substring(0, 19),
                                                  overflow: TextOverflow.ellipsis,
                                                  style: GoogleFonts.amiko(
                                                    fontSize: 10,
                                                    color: green,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              );
                            }),
                      ],
                    ),
                  ),
                ),

                const Spacer(),
                Container(
                  width: 5,
                  height: DEVICEHEIGHT-100,
                  color: bright_green,
                ),
                const Spacer(),

                //Manage quotes
                ValueListenableBuilder<Box<QuotesModel>>(
                    valueListenable: Boxes.getQuotes().listenable(),
                    builder: (context, box, _) {
                      var quotesData = box.values.toList().cast<QuotesModel>();
                      return SizedBox(
                        height: DEVICEHEIGHT-200,
                        
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Text(
                                "All Quotes",
                                style: GoogleFonts.kronaOne(
                                  fontSize: 20,
                                  color: bright_green,
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              //* new quote
                              InkWell(
                                onTap: () {
                                  addQuote(context);
                                },
                                child: Stack(
                                  children: [
                                    ClipPath(
                                      clipper: ClipBottom(),
                                      child: Container(
                                        height: 30,
                                        width: 500,
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.only(
                                            bottomLeft: Radius.circular(15),
                                          ),
                                          border:
                                              Border.all(width: 1, color: green),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 20,
                                      child: Row(
                                        children: [
                                          Text(
                                            "add new quote",
                                            style: GoogleFonts.amiko(
                                              fontSize: 15,
                                              color: bright_green,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Icon(
                                            Icons.add,
                                            color: bright_green,
                                            size: 20,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                children: quotesData.map((data) {
                                  return InkWell(
                                    onTap: () {
                                      addQuote(context, quote: data);
                                    },
                                    child: Stack(
                                      children: [
                                        ClipPath(
                                          clipper: ClipBottom(),
                                          child: Container(
                                            height: 30,
                                            width: 500,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.only(
                                                bottomLeft: Radius.circular(15),
                                              ),
                                              border: Border.all(
                                                  width: 1, color: green),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 10,
                                          left: 20,
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(right: 30),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                //*quote title
                                                SizedBox(
                                                  width: 350,
                                                  height: 18,
                                                  child: Text(
                                                    data.title,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: GoogleFonts.amiko(
                                                      fontSize: 15,
                                                      color: green,
                                                    ),
                                                  ),
                                                ),
                              
                                                //*datetime
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  data.dateTime.substring(0, 19),
                                                  overflow: TextOverflow.ellipsis,
                                                  style: GoogleFonts.amiko(
                                                    fontSize: 10,
                                                    color: green,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
