import 'package:flutter/material.dart';
import 'package:food_delivery_app/base/custom_loader.dart';
import 'package:food_delivery_app/controllers/auth_controller.dart';
import 'package:food_delivery_app/controllers/cart_controller.dart';
import 'package:food_delivery_app/controllers/location_controller.dart';
import 'package:food_delivery_app/controllers/user_controller.dart';
import 'package:food_delivery_app/routes/router_helper.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:food_delivery_app/utils/dimensions.dart';
import 'package:food_delivery_app/widgets/account_widget.dart';
import 'package:food_delivery_app/widgets/app_icon.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:get/get.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool defold = false;
    bool userLoggedIn = Get.find<AuthController>().userLoggedIn();
    if (userLoggedIn) {
      Get.find<UserController>().getUserInfo();
    }
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: BigText(text: "Profile", size: 24, color: Colors.white),
        backgroundColor: AppColors.mainColor,
      ),  
      body: Stack(
        children: [
          GetBuilder<UserController>(
            builder: (userController) {
              return userLoggedIn
                  ? (userController.isLoading
                      ? Container(
                          width: double.maxFinite,
                          margin: EdgeInsets.only(top: Dimensions.height20),
                          child: Column(
                            children: [
                              //profile icon
                              AppIcon(
                                icon: Icons.person,
                                backgroundColor: AppColors.mainColor,
                                iconColor: Colors.white,
                                IconSize: Dimensions.height45 + Dimensions.height30,
                                size: Dimensions.height15 * 10,
                              ),

                              SizedBox(height: Dimensions.height30),
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      // name
                                      AccountWidget(
                                        appIcon: AppIcon(
                                          icon: Icons.phone,
                                          backgroundColor: AppColors.yellowColor,
                                          iconColor: Colors.white,
                                          IconSize: Dimensions.height10 * 5 / 2,
                                          size: Dimensions.height10 * 5,
                                        ),
                                        bigText: BigText(text: "+ 99 899 325 30 01"),
                                        // bigText: BigText(text: userController.userModel.phone),
                                      ),
                                      SizedBox(height: Dimensions.height20),
                                      //phone
                                      AccountWidget(
                                        appIcon: AppIcon(
                                          icon: Icons.email,
                                          backgroundColor: AppColors.yellowColor,
                                          iconColor: Colors.white,
                                          IconSize: Dimensions.height10 * 5 / 2,
                                          size: Dimensions.height10 * 5,
                                        ),
                                        bigText: BigText(text: "binhtrong1101@gmail.com"),
                                        // bigText: BigText(text: userController.userModel.email),
                                      ),
                                      SizedBox(height: Dimensions.height20),
                                      //email
                                      GetBuilder<LocationController>(builder: (locationCOntroller) {
                                        // GetBuilder<>
                                        if (userLoggedIn && locationCOntroller.addressList.isEmpty) {
                                          return GestureDetector(
                                            onTap: () {
                                              Get.offNamed(RouteHelper.getAddresssPage());
                                            },
                                            child: AccountWidget(
                                              appIcon: AppIcon(
                                                icon: Icons.location_on,
                                                backgroundColor: AppColors.yellowColor,
                                                iconColor: Colors.white,
                                                IconSize: Dimensions.height10 * 5 / 2,
                                                size: Dimensions.height10 * 5,
                                              ),
                                              bigText: BigText(text: "Fill in your address"),
                                              // bigText: BigText(text: userController.userModel.phone),
                                            ),
                                          );
                                        } else {
                                          return GestureDetector(
                                            onTap: () {
                                              Get.offNamed(RouteHelper.getAddresssPage());
                                            },
                                            child: AccountWidget(
                                              appIcon: AppIcon(
                                                icon: Icons.location_on,
                                                backgroundColor: AppColors.yellowColor,
                                                iconColor: Colors.white,
                                                IconSize: Dimensions.height10 * 5 / 2,
                                                size: Dimensions.height10 * 5,
                                              ),
                                              bigText: BigText(text: "Your address"),
                                              // bigText: BigText(text: userController.userModel.phone),
                                            ),
                                          );
                                        }
                                      }),
                                      SizedBox(height: Dimensions.height20),
                                      //adress
                                      AccountWidget(
                                        appIcon: AppIcon(
                                          icon: Icons.message,
                                          backgroundColor: Colors.redAccent,
                                          iconColor: Colors.white,
                                          IconSize: Dimensions.height10 * 5 / 2,
                                          size: Dimensions.height10 * 5,
                                        ),
                                        bigText: BigText(text: "Message"),
                                      ),
                                      SizedBox(height: Dimensions.height20),
                                      //message
                                      GestureDetector(
                                        //Bu qisimda bizda server vatincha ishlamay qolganli sabbali false bo'lsa tizimdan chiqadi => defaul tarzda hamma narsani tozalaydi
                                        onTap: () {
                                          if (Get.find<AuthController>().userLoggedIn()) {
                                            Get.find<AuthController>().clearSharedDate();
                                            Get.find<CartController>().clear();
                                            Get.find<CartController>().clearCartHistory();
                                            Get.offNamed(RouteHelper.getsigInPage());
                                          } else {
                                            print("You logged out");
                                            Get.offNamed(RouteHelper.getsigInPage());
                                          }
                                        },
                                        child: AccountWidget(
                                          appIcon: AppIcon(
                                            icon: Icons.logout,
                                            backgroundColor: Colors.redAccent,
                                            iconColor: Colors.white,
                                            IconSize: Dimensions.height10 * 5 / 2,
                                            size: Dimensions.height10 * 5,
                                          ),
                                          bigText: BigText(text: "Log Out"),
                                        ),
                                      ),
                                      SizedBox(height: Dimensions.height20),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : CustomLoader())
                  : Container(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: double.maxFinite,
                              height: Dimensions.height20 * 8,
                              margin: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(Dimensions.radius20),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage("assets/images/signintocontinue.png"),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.toNamed(RouteHelper.getsigInPage());
                              },
                              child: Container(
                                width: double.maxFinite,
                                height: Dimensions.height20 * 5,
                                margin: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                                  color: AppColors.mainColor,
                                ),
                                child: Center(child: BigText(text: "Sign in ", color: Colors.white, size: Dimensions.font26)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
            },
          ),
        ],
      ),
    );
  }
}
