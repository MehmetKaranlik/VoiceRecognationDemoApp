import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:vexana/vexana.dart';
import 'package:voice_recognation_demo_sample/view/home/model/comment_model.dart';
import 'package:voice_recognation_demo_sample/view/home/service/home_service.dart';

class HomeViewController extends GetxController {
  final SpeechToText speechController = SpeechToText();
  final String baseUrl = "https://jsonplaceholder.typicode.com";
  final String endPoint = "/comments";

  final Rx<String> _speechText = "".obs;
  String get speechText => _speechText.value;
  set speechText(String val) => _speechText.value = val;

  final Rx<int> _minRange = 0.obs;
  int get minRange => _minRange.value;
  set minRange(int val) => _minRange.value = val;

  final Rx<int> _maxRange = 5.obs;
  int get maxRange => _maxRange.value;
  set maxRange(int val) => _maxRange.value = val;

  late final RxList<Comments> _comments = <Comments>[].obs;
  List<Comments> get comments => _comments.value;
  set comments(List<Comments> val) => _comments.value = val;

  void startListening() async {
    await speechController.listen(
      onResult: _onSpeechResult,
      listenFor: const Duration(seconds: 2),
      cancelOnError: true,
      listenMode: ListenMode.search,
    );
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    speechText = result.recognizedWords;
    if (result.recognizedWords== "geç" || result.recognizedWords == "Geç") {
      minRange = minRange +5;
      maxRange = maxRange +5 ;
      print("hello");
      getComments(minRange, maxRange);
    }
  }

  void getComments(int minRange, int maxRange) async {
    INetworkManager _manager = NetworkManager(options: BaseOptions(baseUrl: baseUrl));
    HomeService _homeService = HomeService(_manager);
    final response = await _homeService.fecthComments(baseUrl, endPoint);

    if (response != null) {
      comments = response.getRange(minRange, maxRange).toList();
    }
  }
}
