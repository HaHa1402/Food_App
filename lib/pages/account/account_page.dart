// import 'package:flutter/material.dart';
// import 'package:food_delivery_app/base/custom_loader.dart';
// import 'package:food_delivery_app/controllers/auth_controller.dart';
// import 'package:food_delivery_app/controllers/cart_controller.dart';
// import 'package:food_delivery_app/controllers/location_controller.dart';
// import 'package:food_delivery_app/controllers/user_controller.dart';
// import 'package:food_delivery_app/routes/router_helper.dart';
// import 'package:food_delivery_app/utils/colors.dart';
// import 'package:food_delivery_app/utils/dimensions.dart';
// import 'package:food_delivery_app/widgets/account_widget.dart';
// import 'package:food_delivery_app/widgets/app_icon.dart';
// import 'package:food_delivery_app/widgets/big_text.dart';
// import 'package:get/get.dart';

// class AccountPage extends StatelessWidget {
//   const AccountPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     bool defold = false;
//     bool _userLoggedIn = Get.find<AuthController>().userLoggedIn();
//     if (_userLoggedIn) {
//       Get.find<UserController>().getUserInfo();
//     }
//     return Scaffold(
//       backgroundColor: Colors.grey[50],
//       appBar: AppBar(
//         title: BigText(text: "Hồ sơ", size: 24, color: Colors.white),
//         backgroundColor: AppColors.mainColor,
//       ),

//       body: Stack(
//         children: [
//           GetBuilder<UserController>(
//             builder: (userController) {
//               return _userLoggedIn
//                   ? (userController.isLoading
//                       ? Container(
//                           width: double.maxFinite,
//                           margin: EdgeInsets.only(top: Dimensions.height20),
//                           child: Column(
//                             children: [
//                               //profile icon
//                               AppIcon(
//                                 icon: Icons.person,
//                                 backgroundColor: AppColors.mainColor,
//                                 iconColor: Colors.white,
//                                 IconSize: Dimensions.height45 + Dimensions.height30,
//                                 size: Dimensions.height15 * 10,
//                               ),

//                               SizedBox(height: Dimensions.height30),
//                               Expanded(
//                                 child: SingleChildScrollView(
//                                   child: Column(
//                                     children: [
//                                       // name
//                                       AccountWidget(
//                                         appIcon: AppIcon(
//                                           icon: Icons.phone,
//                                           backgroundColor: AppColors.yellowColor,
//                                           iconColor: Colors.white,
//                                           IconSize: Dimensions.height10 * 5 / 2,
//                                           size: Dimensions.height10 * 5,
//                                         ),
//                                         bigText: BigText(text: "+ 99 899 325 30 01"),
//                                         // bigText: BigText(text: userController.userModel.phone),
//                                       ),
//                                       SizedBox(height: Dimensions.height20),
//                                       //phone
//                                       AccountWidget(
//                                         appIcon: AppIcon(
//                                           icon: Icons.email,
//                                           backgroundColor: AppColors.yellowColor,
//                                           iconColor: Colors.white,
//                                           IconSize: Dimensions.height10 * 5 / 2,
//                                           size: Dimensions.height10 * 5,
//                                         ),
//                                         bigText: BigText(text: "mansuriosdevm1@gmail.com"),
//                                         // bigText: BigText(text: userController.userModel.email),
//                                       ),
//                                       SizedBox(height: Dimensions.height20),
//                                       //email
//                                       GetBuilder<LocationController>(builder: (locationCOntroller) {
//                                         // GetBuilder<>
//                                         if (_userLoggedIn && locationCOntroller.addressList.isEmpty) {
//                                           return GestureDetector(
//                                             onTap: () {
//                                               Get.offNamed(RouteHelper.getAddresssPage());
//                                             },
//                                             child: AccountWidget(
//                                               appIcon: AppIcon(
//                                                 icon: Icons.location_on,
//                                                 backgroundColor: AppColors.yellowColor,
//                                                 iconColor: Colors.white,
//                                                 IconSize: Dimensions.height10 * 5 / 2,
//                                                 size: Dimensions.height10 * 5,
//                                               ),
//                                               bigText: BigText(text: "Fill in your address"),
//                                               // bigText: BigText(text: userController.userModel.phone),
//                                             ),
//                                           );
//                                         } else {
//                                           return GestureDetector(
//                                             onTap: () {
//                                               Get.offNamed(RouteHelper.getAddresssPage());
//                                             },
//                                             child: AccountWidget(
//                                               appIcon: AppIcon(
//                                                 icon: Icons.location_on,
//                                                 backgroundColor: AppColors.yellowColor,
//                                                 iconColor: Colors.white,
//                                                 IconSize: Dimensions.height10 * 5 / 2,
//                                                 size: Dimensions.height10 * 5,
//                                               ),
//                                               bigText: BigText(text: "Your address"),
//                                               // bigText: BigText(text: userController.userModel.phone),
//                                             ),
//                                           );
//                                         }
//                                       }),
//                                       SizedBox(height: Dimensions.height20),
//                                       //adress
//                                       AccountWidget(
//                                         appIcon: AppIcon(
//                                           icon: Icons.message,
//                                           backgroundColor: Colors.redAccent,
//                                           iconColor: Colors.white,
//                                           IconSize: Dimensions.height10 * 5 / 2,
//                                           size: Dimensions.height10 * 5,
//                                         ),
//                                         bigText: BigText(text: "Message"),
//                                       ),
//                                       SizedBox(height: Dimensions.height20),
//                                       //message
//                                       GestureDetector(
//                                         //Bu qisimda bizda server vatincha ishlamay qolganli sabbali false bo'lsa tizimdan chiqadi => defaul tarzda hamma narsani tozalaydi
//                                         onTap: () {
//                                           if (Get.find<AuthController>().userLoggedIn()) {
//                                             Get.find<AuthController>().clearSharedDate();
//                                             Get.find<CartController>().clear();
//                                             Get.find<CartController>().clearCartHistory();
//                                             Get.offNamed(RouteHelper.getsigInPage());
//                                           } else {
//                                             print("You logged out");
//                                             Get.offNamed(RouteHelper.getsigInPage());
//                                           }
//                                         },
//                                         child: AccountWidget(
//                                           appIcon: AppIcon(
//                                             icon: Icons.logout,
//                                             backgroundColor: Colors.redAccent,
//                                             iconColor: Colors.white,
//                                             IconSize: Dimensions.height10 * 5 / 2,
//                                             size: Dimensions.height10 * 5,
//                                           ),
//                                           bigText: BigText(text: "Log Out"),
//                                         ),
//                                       ),
//                                       SizedBox(height: Dimensions.height20),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         )
//                       : CustomLoader())
//                   : Container(
//                       child: Center(
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Container(
//                               width: double.maxFinite,
//                               height: Dimensions.height20 * 8,
//                               margin: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20),
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(Dimensions.radius20),
//                                 image: DecorationImage(
//                                   fit: BoxFit.cover,
//                                   image: AssetImage("assets/images/signintocontinue.png"),
//                                 ),
//                               ),
//                             ),
//                             GestureDetector(
//                               onTap: () {
//                                 Get.toNamed(RouteHelper.getsigInPage());
//                               },
//                               child: Container(
//                                 width: double.maxFinite,
//                                 height: Dimensions.height20 * 5,
//                                 margin: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20),
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(Dimensions.radius20),
//                                   color: AppColors.mainColor,
//                                 ),
//                                 child: Center(child: BigText(text: "Đăng nhập ", color: Colors.white, size: Dimensions.font26)),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:food_delivery_app/controllers/cart_controller.dart';
import 'package:food_delivery_app/controllers/location_controller.dart';
import 'package:food_delivery_app/routes/router_helper.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:food_delivery_app/utils/dimensions.dart';
import 'package:food_delivery_app/widgets/account_widget.dart';
import 'package:food_delivery_app/widgets/app_icon.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:get/get.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Bỏ kiểm tra đăng nhập
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: BigText(text: "Hồ sơ", size: 24, color: Colors.white),
        backgroundColor: AppColors.mainColor,
      ),
      body: Stack(
        children: [
          // Không cần GetBuilder<UserController> nếu không dùng dữ liệu từ API
          Container(
            width: double.maxFinite,
            margin: EdgeInsets.only(top: Dimensions.height20),
            child: Column(
              children: [
                // Avatar
                Container(
                  width:
                      Dimensions.height10 * 15, // kích thước container của ảnh
                  height:
                      Dimensions.height10 * 15, // kích thước container của ảnh
                  decoration: BoxDecoration(
                    shape: BoxShape.circle, // để ảnh tròn
                    image: DecorationImage(
                      image: AssetImage(
                        "assets/images/avatar.png",
                      ), // Đường dẫn ảnh avatar
                      fit: BoxFit.cover, // ảnh sẽ phủ kín trong vòng tròn
                    ),
                  ),
                ),

                SizedBox(height: Dimensions.height30),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // Số điện thoại
                        AccountWidget(
                          appIcon: AppIcon(
                            icon: Icons.phone,
                            backgroundColor: AppColors.yellowColor,
                            iconColor: Colors.white,
                            IconSize: Dimensions.height10 * 5 / 2,
                            size: Dimensions.height10 * 5,
                          ),
                          bigText: BigText(text: "0936485773"),
                        ),
                        SizedBox(height: Dimensions.height20),

                        // Email
                        AccountWidget(
                          appIcon: AppIcon(
                            icon: Icons.email,
                            backgroundColor: AppColors.yellowColor,
                            iconColor: Colors.white,
                            IconSize: Dimensions.height10 * 5 / 2,
                            size: Dimensions.height10 * 5,
                          ),
                          bigText: BigText(text: "ha@gmail.com"),
                        ),
                        SizedBox(height: Dimensions.height20),

                        // Địa chỉ
                        GetBuilder<LocationController>(
                          builder: (locationController) {
                            return GestureDetector(
                              onTap: () {
                                Get.toNamed(RouteHelper.getAddresssPage());
                              },
                              child: AccountWidget(
                                appIcon: AppIcon(
                                  icon: Icons.location_on,
                                  backgroundColor: AppColors.yellowColor,
                                  iconColor: Colors.white,
                                  IconSize: Dimensions.height10 * 5 / 2,
                                  size: Dimensions.height10 * 5,
                                ),
                                bigText: BigText(
                                  text:
                                      locationController.addressList.isEmpty
                                          ? "Thêm địa chỉ"
                                          : "Địa chỉ của bạn",
                                ),
                              ),
                            );
                          },
                        ),
                        SizedBox(height: Dimensions.height20),

                        // Tin nhắn
                        AccountWidget(
                          appIcon: AppIcon(
                            icon: Icons.message,
                            backgroundColor: Colors.redAccent,
                            iconColor: Colors.white,
                            IconSize: Dimensions.height10 * 5 / 2,
                            size: Dimensions.height10 * 5,
                          ),
                          bigText: BigText(text: "Tin nhắn"),
                        ),
                        SizedBox(height: Dimensions.height20),

                        // Nút đăng xuất (tùy chọn)
                        GestureDetector(
                          onTap: () {
                            // Xóa cart tạm thời thôi, không cần clear Auth
                            Get.find<CartController>().clear();
                            Get.find<CartController>().clearCartHistory();
                            Get.snackbar(
                              "Thông báo",
                              "Bạn đã thoát (giả lập)",
                              backgroundColor: Colors.orangeAccent,
                            );
                          },
                          child: AccountWidget(
                            appIcon: AppIcon(
                              icon: Icons.logout,
                              backgroundColor: Colors.redAccent,
                              iconColor: Colors.white,
                              IconSize: Dimensions.height10 * 5 / 2,
                              size: Dimensions.height10 * 5,
                            ),
                            bigText: BigText(text: "Thoát"),
                          ),
                        ),
                        SizedBox(height: Dimensions.height20),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
