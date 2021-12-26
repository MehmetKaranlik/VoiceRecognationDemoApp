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
          SizedBox(
              width: 80.w,
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "Robot ismi"
                ),
                controller: _controller.textController,
                keyboardType: TextInputType.none,
              )),
          SizedBox(
            height: 30.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() => IconButton(
                  onPressed: () => _controller.startListening(),
                  icon: Icon(_controller.isListening ? Icons.mic_off : Icons.mic))),
              SizedBox(
                width: 15.w,
              ),
              IconButton(onPressed: () => _controller.cacheRobotName(), icon: const Icon(Icons.save)),
              SizedBox(
                width: 15.w,
              ),
              IconButton(
                  onPressed: () => _controller.isCacheRobotNameEmpty
                      ? Get.snackbar("uyarı", "Robot ismi seçilmek zorunda !",snackPosition: SnackPosition.BOTTOM)
                      : Get.off(() =>  HomeView()),
                  icon: const Icon(Icons.arrow_forward))
            ],
          )
        ],
      ),
    );
  }
}
