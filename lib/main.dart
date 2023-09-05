import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mqtt/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoApp(title: 'Pet Control', home: MyHomePage())
        : MaterialApp(
            title: 'Pet Control',
            theme: ThemeData(primarySwatch: Colors.orange),
            home: MyHomePage(),
          );
  }
}
