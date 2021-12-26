import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:voice_recognation_demo_sample/view/home/view/home_view.dart';
import 'package:voice_recognation_demo_sample/view/onboarding/controller/onboarding_view_controller.dart';

class OnboardingView extends StatelessWidget {
  final _controller = Get.put(OnboardingViewController());
  OnboardingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 40.h,
          ),
          _buildTextFormField(),
          SizedBox(
            height: 30.h,
          ),
          _buildButtonRow()
        ],
      ),
    );
  }

  Row _buildButtonRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Obx(() => _buildListenButton()),
        SizedBox(
          width: 15.w,
        ),
        _buildCacheButton(),
        SizedBox(
          width: 15.w,
        ),
        _buildForwardButton()
      ],
    );
  }

  IconButton _buildForwardButton() {
    return IconButton(
        onPressed: () => _controller.isCacheRobotNameEmpty ? _buildSnackBar() : Get.off(() => HomeView()),
        icon: const Icon(Icons.arrow_forward));
  }

  SnackbarController _buildSnackBar() =>
      Get.snackbar("uyarı", "Robot ismi seçilmek zorunda !", snackPosition: SnackPosition.BOTTOM);

  IconButton _buildCacheButton() =>
      IconButton(onPressed: () => _controller.cacheRobotName(), icon: const Icon(Icons.save));

  IconButton _buildListenButton() {
    return IconButton(
        onPressed: () => _controller.startListening(), icon: Icon(_controller.isListening ? Icons.mic_off : Icons.mic));
  }

  SizedBox _buildTextFormField() {
    return SizedBox(
        width: 80.w,
        child: TextFormField(
          decoration: InputDecoration(hintText: "Robot ismi"),
          controller: _controller.textController,
          keyboardType: TextInputType.none,
        ));
  }
}
