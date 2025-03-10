import 'package:get/get.dart';


//kich thuoc
class Dimensions {
  static double screenHeight = Get.context!.height;
  static double screenWeight = Get.context!.width;

  //  844/220 => 3.84
  static double pageView = screenHeight / 2.64;
  static double pageViewContainer = screenHeight / 3.84;
  static double pageViewTextContainer = screenHeight / 7.03;

//height padding and margin
 static double height5 = screenHeight / 100.4; // => 10
  static double height10 = screenHeight / 84.4; // => 10
  static double height15 = screenHeight / 56.27; // => 15
  static double height20 = screenHeight / 42.2; // = 20
  static double height30 = screenHeight / 28.13; // => 30
  static double height45 = screenHeight / 18.76; // => 30

//width padding and margin
  static double width10 = screenHeight / 84.4; // => 10
  static double width15 = screenHeight / 56.27; // => 15
  static double width20 = screenHeight / 42.2; // => 20
  static double width30 = screenHeight / 28.13; // => 30

  // fonts size

  static double font16 = screenHeight / 53.75; // => 20
  static double font20 = screenHeight / 42.2; // => 20
  static double font26 = screenHeight / 32.4; // => 26
  //radius
  static double radius10 = screenHeight / 76.27; // => 20
  static double radius15 = screenHeight / 56.27; // => 20
  static double radius20 = screenHeight / 42.2; // => 20
  static double radius30 = screenHeight / 28.13; // => 30

  // icons size
  static double iconSize24 = screenHeight / 35.17;
  static double iconSize16 = screenHeight / 52.75;

  //list view siz 390
  static double listViewImageSize = screenWeight / 3.25;
  static double listViewTextConatinerSize = screenWeight / 3.9;

  // popular food
  static double popularFoodImageSize = screenHeight / 2.41; // = > 240

  // bottom height
  static double bottomHeightBar = screenHeight / 7.03; // = > 240

  //splash srenn dimensions

  static double splashImg = screenHeight / 3.38;

  
}
