
import 'package:food_delivery_app/data/repository/recomended_product_repo.dart';
import 'package:food_delivery_app/model/product_model.dart';
import 'package:get/get.dart';

class RecommendedProductController extends GetxController {
  final RecommendedProductRepo recommendedProductRepo;
  RecommendedProductController({required this.recommendedProductRepo});
  List<ProductModel> _recommendedProductList = [];
  List<ProductModel> get recommendedProductList => _recommendedProductList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

   //lấy ds từ máy chủ
  Future<void> getRecommendedProductList() async {
    Response response = await recommendedProductRepo.getRecommendedProductList();
    if (response.statusCode == 200) {
      // print("got product recommended");
      _recommendedProductList = [];
      _recommendedProductList.addAll(Product.fromJson(response.body).products);
      // print(_popularProductList);
      _isLoaded = true;
      update();
    } else {
      print("could not get product recmommended");
    }
  }
}
