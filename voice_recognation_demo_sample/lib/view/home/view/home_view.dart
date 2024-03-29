import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voice_recognation_demo_sample/view/home/controller/home_view_controller.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);
  final _controller = Get.put(HomeViewController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: _buildFab(),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                const SizedBox(
                  height: 100,
                ),
                _buildCatImage(),
              ],
            ),
          ),
        ));
  }

  FloatingActionButton _buildFab() {
    return FloatingActionButton(
      child: Obx(() => _controller.isListening ? Icon(Icons.mic_off) : Icon(Icons.mic)),
      onPressed: () => _controller.startListening(),
    );
  }

  Center _buildCatImage() {
    return Center(
      child: Obx(
        () => Image.network(
          _controller.getCatURL(_controller.speechText),
          fit: BoxFit.fill,
          loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) return child;
            return _buildLoadingIndicator(loadingProgress);
          },
        ),
      ),
    );
  }

  Center _buildLoadingIndicator(ImageChunkEvent loadingProgress) {
    return Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                  : null,
            ),
          );
  }
}
