import 'package:vexana/src/interface/INetworkService.dart';
import 'package:vexana/vexana.dart';
import 'package:voice_recognation_demo_sample/view/home/model/comment_model.dart';
import 'package:voice_recognation_demo_sample/view/home/service/IHome_service.dart';

class HomeService extends IHomeService {
  HomeService(INetworkManager manager) : super(manager);


  Future<List<Comments>?> fecthComments(String baseUrl, String endPoint) async {
    final response = await manager.send<Comments,List<Comments>>(
      "$baseUrl"+"$endPoint",
      parseModel: Comments(),
      method: RequestType.GET,
    );
    if (response.data != null) {
      return response.data;
    }
  }
}
