import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:voice_recognation_demo_sample/core/cache/local_manager.dart';
import 'package:voice_recognation_demo_sample/core/constants/shared_enums.dart';

class HomeViewController extends GetxController {
  final SpeechToText speechController = SpeechToText();
  final String baseUrl = "https://cataas.com/cat/says";
  late final LocaleManager _localeManager;

  @override
  void onInit() {
    _localeManager = LocaleManager.instance;
    speechController.initialize();

    super.onInit();
  }

  final Rx<String> _speechText = "".obs;
  String get speechText => _speechText.value;
  set speechText(String val) => _speechText.value = val;

  final Rx<String> _endPoint = "".obs;
  String get endPoint => _endPoint.value;
  set endPoint(String val) => _endPoint.value = val;

  final Rx<bool> _isListening = false.obs;
  bool get isListening => _isListening.value;
  set isListening(bool val) => _isListening.value = val;

  void startListening() async {
    isListening = true;
    await speechController.listen(
      onResult: _onSpeechResult,
     // pauseFor: Duration(seconds: 2),
      cancelOnError: false,
      listenMode: ListenMode.dictation,
    );
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    if (getValidateRobotName(result)) {
      speechText = result.recognizedWords.replaceAll('tavuk', '');
    }
    stopListening();
  }

  String getCatURL(String input) {
    if (speechText.isNotEmpty) {
      return "$baseUrl/$speechText";
    } else {
      return "$baseUrl/BirseylerSöyle";
    }
  }

  void stopListening() {
    speechController.stop().whenComplete(() => isListening=false);
  }

  bool getValidateRobotName(SpeechRecognitionResult result) {
    return result.recognizedWords.toLowerCase().contains(_localeManager.getStringValue(PreferencesKeys.ROBOT_NAME));
  }
}
