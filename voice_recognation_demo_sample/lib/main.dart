

import 'package:flutter/material.dart';
import 'package:voice_recognation_demo_sample/view/home/view/home_view.dart';

void main() {
  runApp(StartApp());
}

class StartApp extends StatelessWidget {
  const StartApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(

      home: HomeView(),
    );
  }
}