import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:voice_recognation_demo_sample/core/cache/local_manager.dart';
import 'package:voice_recognation_demo_sample/view/home/view/home_view.dart';
import 'package:voice_recognation_demo_sample/view/onboarding/controller/onboarding_view_controller.dart';
import 'package:voice_recognation_demo_sample/view/onboarding/view/onboarding_view.dart';

void main() async {
  await asyncInit();
  runApp(StartApp());
}

class StartApp extends StatelessWidget {
  final _controller = Get.put(OnboardingViewController());
  StartApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          home: _controller.isCacheRobotNameEmpty ? OnboardingView() : HomeView(),
        );
      },
    );
  }
}

Future<void> asyncInit() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocaleManager.prefrencesInit();
}