import 'package:flutter/material.dart';
import 'package:voice_recognation_demo_sample/view/home/controller/home_view_controller.dart';

class HomeView extends StatefulWidget {

  const HomeView({ Key? key }) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late final HomeViewController _controller;
  @override
  void initState() {
    _controller = HomeViewController();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(),
    );
  }
}