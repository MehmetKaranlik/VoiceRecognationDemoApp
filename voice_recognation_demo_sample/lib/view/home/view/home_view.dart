import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voice_recognation_demo_sample/view/home/controller/home_view_controller.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late final HomeViewController _controller;
  @override
  void initState() {
    _controller = Get.put(HomeViewController());
    _controller.speechController.initialize();
    _controller.getComments(0,5);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () => _controller.startListening(),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Obx(() {
                return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _controller.comments.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_controller.comments[index].id.toString()),
                  );
                },
              );
              }),
              SizedBox(
                height: 200,
              ),
              Obx(()=> Text(_controller.speechText))
           
            ],
          ),
        ));
  }
}
