
import 'package:food_delivery_app/data/api/api_client.dart';
import 'package:food_delivery_app/utils/app_constants.dart';
import 'package:get/get.dart';

class UserRepo {
  final ApiClent apiClent;
  UserRepo({required this.apiClent});

  Future<Response> getUserInfo() async {
    return await apiClent.getData(AppConstants.USER_INFO_URI);
  }
}
