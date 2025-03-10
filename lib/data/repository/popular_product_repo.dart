
import 'package:food_delivery_app/data/api/api_client.dart';
import 'package:food_delivery_app/utils/app_constants.dart';
import 'package:get/get.dart';

class PopularProductRepo extends GetxService {
  // String api = "https://mvs.bslmeiyu.com/api/v1/products/popular";
  final ApiClent apiClent;
  PopularProductRepo({required this.apiClent});

  Future<Response> getPopularProductList() async {
    return await apiClent.getData(AppConstants.POPUPAR_PRODUCT_URL);
  }
}
