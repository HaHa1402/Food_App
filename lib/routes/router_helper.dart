


import 'package:food_delivery_app/pages/address/ad_address_page.dart';
import 'package:food_delivery_app/pages/auth/sign_in_page.dart';
import 'package:food_delivery_app/pages/cart/cart_page.dart';
import 'package:food_delivery_app/pages/food/popular_food_detail.dart';
import 'package:food_delivery_app/pages/food/recomended_fodd_detail.dart';
import 'package:food_delivery_app/pages/home/home_page.dart';
import 'package:food_delivery_app/pages/splash/splash_page.dart';
import 'package:get/get.dart';

class RouteHelper {
  // Route names
  static const String splashPage = "/splash-page";
  static const String initial = "/";
  static const String popularFood = "/popular-food";
  static const String recommendedFood = "/recommended-food";
  static const String cartPage = "/cart-page";
  static const String signIn = "/sign-in";
  static const String addAddress = "/add-address";

  // Route generators
  static String getSplashPage() => splashPage;
  static String getInitial() => initial;
  static String getPopularFood(int pageId, String page) => '$popularFood?pageId=$pageId&page=$page';
  static String getRecommendedFood(int pageId, String page) => '$recommendedFood?pageId=$pageId&page=$page';
  static String getCartPage() => cartPage;
  static String getSignInPage() => signIn;
  // static String getAddressPage() => addAddress;
  static String getAddresssPage() => '$addAddress';


  // Routes list
  static List<GetPage> routes = [
    GetPage(name: splashPage, page: () => const SplashScreen()),

    GetPage(name: initial, page: () => const HomePage(), transition: Transition.fade),

    GetPage(name: signIn, page: () => const SignInPage(), transition: Transition.fade),

    GetPage(
      name: popularFood,
      page: () {
        var pageId = Get.parameters['pageId'];
        var page = Get.parameters['page'];
        return PopularFoodDetail(pageId: int.parse(pageId!), page: page!);
      },
      transition: Transition.fadeIn,
    ),

    GetPage(
      name: recommendedFood,
      page: () {
        var pageId = Get.parameters['pageId'];
        var page = Get.parameters['page'];
        return RecomendFoodDetail(pageId: int.parse(pageId!), page: page!);
      },
      transition: Transition.fadeIn,
    ),

    GetPage(
      name: cartPage,
      page: () => const CartPage(),
      transition: Transition.fadeIn,
    ),

    GetPage(
      name: addAddress,
      page: () => const AddAddressPage(),
    ),
  ];
}
