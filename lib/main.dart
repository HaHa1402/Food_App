import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:food_delivery_app/controllers/cart_controller.dart';
import 'package:food_delivery_app/controllers/popular_product_controller.dart';
import 'package:food_delivery_app/controllers/recommended_product_controller.dart';
import 'package:food_delivery_app/data/repository/cart_repo.dart';
import 'package:food_delivery_app/pages/home/home_page.dart';
import 'package:food_delivery_app/routes/router_helper.dart';
import 'package:food_delivery_app/widgets/const.dart';

import 'package:get/get.dart';
import 'helper/dependeccies.dart' as dep;
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Khởi tạo sharedPreferences
  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  // Khởi tạo cartRepo
  var cartRepo = CartRepo(sharedPreferences: sharedPreferences);

  // Đăng ký CartController với cartRepo đã được khởi tạo
  Get.put(CartController(cartRepo: cartRepo));  // Đăng ký controller tại đây

  // Khởi tạo Stripe
  Stripe.publishableKey = stripePublishableKey;
  await Stripe.instance.applySettings(); // Đảm bảo cấu hình Stripe được áp dụng

  // await Firebase.initializeApp();
await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);


  await dep.init();
  runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PopularProductController>(builder: (_) {
      return GetBuilder<RecommendedProductController>(builder: (_) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Flutter Demo",
          // home: HomePage(),

          //  home: PopularFoodDetail());
      // home: RecommenededFoodDetail());
          initialRoute: RouteHelper.getSplashPage(),
          getPages: RouteHelper.routes,
       
        );
      });
    });
  }
}


