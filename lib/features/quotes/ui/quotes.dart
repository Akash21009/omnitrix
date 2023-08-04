// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:hive/hive.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:omnitrix/constants.dart';
// import 'package:omnitrix/features/boxes/boxes.dart';
// import 'package:omnitrix/features/quotes/data/models/quotes_model.dart';

// class Quotes extends StatefulWidget {
//   const Quotes({super.key});

//   @override
//   State<Quotes> createState() => _QuotesState();
// }

// class _QuotesState extends State<Quotes> {
//   final titleController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ValueListenableBuilder<Box<QuotesModel>>(
//           valueListenable: Boxes.getQuotes().listenable(),
//           builder: (context, box, _) {
//             var data = box.values.toList().cast<QuotesModel>();
//             return Column(children: [
//               Container(
//                 child: Text("add quote"),
//               ),
//               TextFormField(
//                 controller: titleController,
//                 decoration: InputDecoration(
//                   hintText: 'title',
//                 ),
//               ),
//               ElevatedButton(
//                   onPressed: () {
//                     final data = QuotesModel(
//                         title: titleController.text,
//                         image: ghost_freak_glow,
//                         dateTime: DateTime.now().toString());
//                     titleController.clear();

//                     final box = Boxes.getQuotes();
//                     box.add(data);

//                     data.save();
//                   },
//                   child: Text('add')),
//               Container(
//                 height: 300,
//                 child: ListView.builder(
//                     itemCount: box.length,
//                     scrollDirection: Axis.vertical,
//                     itemBuilder: (BuildContext context, int index) {
//                       return Row(
//                         children: [
//                           Text(data[index].title),
//                           const SizedBox(
//                             width: 20,
//                           ),
//                           Container(
//                             height: 100,
//                             width: 100,
//                             decoration: BoxDecoration(
//                                 image: DecorationImage(
//                                     image: AssetImage(data[index].image))),
//                           ),
//                           const SizedBox(
//                             width: 20,
//                           ),
//                           Text(data[index].dateTime),
//                         ],
//                       );
//                     }),
//               ),
//               ElevatedButton(
//                   onPressed: () {
//                     box.clear();
//                   },
//                   child: Text("clear")),
//               ElevatedButton(
//                   onPressed: () {
//                     data[0].delete();
//                   },
//                   child: Text("delete top")),
//               ElevatedButton(
//                   onPressed: () {
//                     data[1].image = heat_blast_glow;
//                     data[1].save();
//                   },
//                   child: Text("edit second")),
//             ]);
//           }),
//     );
//   }
// }
