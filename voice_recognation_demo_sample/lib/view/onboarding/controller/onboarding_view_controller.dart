import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:voice_recognation_demo_sample/core/cache/local_manager.dart';
import 'package:voice_recognation_demo_sample/core/constants/shared_enums.dart';

class OnboardingViewController extends GetxController {
  SpeechToText robotNameRegister = SpeechToText();
  TextEditingController textController = TextEditingController();
  late final LocaleManager _localeManager;

  final Rx<String> _speechText = "".obs;
  String get speechText => _speechText.value;
  set speechText(String val) => _speechText.value = val;

  final Rx<bool> _isListening = false.obs;
  bool get isListening => _isListening.value;
  set isListening(bool val) => _isListening.value = val;

  bool get isCacheRobotNameEmpty => _localeManager.getStringValue(PreferencesKeys.ROBOT_NAME).isEmpty;

  @override
  void onInit() {
    _localeManager = LocaleManager.instance;
    robotNameRegister.initialize();
    super.onInit();
  }

  void cacheRobotName() async {
    await _localeManager.setStringValue(PreferencesKeys.ROBOT_NAME, textController.text.toLowerCase());
  }

  void startListening() async {
    isListening = true;
    await robotNameRegister.listen(
      onResult: _onSpeechResult,
      listenFor: const Duration(seconds: 2),
      cancelOnError: true,
      listenMode: ListenMode.search,
    );
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    speechText = result.recognizedWords;
    textController.text = speechText;
    isListening=false;
  }
}
