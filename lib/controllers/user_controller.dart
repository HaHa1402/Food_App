
import 'package:food_delivery_app/data/repository/user_repo.dart';
import 'package:food_delivery_app/model/reponse_model.dart';
import 'package:food_delivery_app/model/user_model.dart';
import 'package:get/get.dart';

class UserController extends GetxController implements GetxService {
  final UserRepo userRepo;
  UserController({
    required this.userRepo,
  });

  bool _isLoading = false;
  late UserModel _userModel;
  bool get isLoading => _isLoading;
  UserModel get userModel => _userModel;

  Future<ResponseModel> getUserInfo() async {
    // _isLoading = true;
    // update();
    Response response = await userRepo.getUserInfo();
    late ResponseModel responseModel;
    print("test" + response.body.toString());
    if (response.statusCode == 200) {
      _userModel = UserModel.fromJson(response.body);
      _isLoading = true;
      responseModel = ResponseModel(true, "thành công");
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    // _isLoading = false;
    update();
    return responseModel;
  }
}
