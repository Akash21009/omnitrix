import 'dart:io';
import 'dart:ui';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:hive/hive.dart';
import 'package:omnitrix/features/home/ui/home.dart';

import 'package:omnitrix/features/managespace/ui/managespace.dart';
import 'package:omnitrix/features/menu/ui/menu.dart';
import 'package:omnitrix/features/quotes/data/models/quotes_model.dart';


import 'features/tags/data/models/tags_model.dart';
import 'features/tags/data/models/task_model.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  doWhenWindowReady(() {
    appWindow.show();
    appWindow.maximize();
  });

  var path = Directory.current.path;
  Hive.init(path);

  Hive.registerAdapter(QuotesModelAdapter());
  Hive.registerAdapter(TagModelAdapter());
  Hive.registerAdapter(TaskModelAdapter());
  await Hive.openBox<QuotesModel>('quotes');
  await Hive.openBox<TagModel>('tags');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'OMNITRIX-todoapplication',
      home: HomePage(),
    );
  }
}
