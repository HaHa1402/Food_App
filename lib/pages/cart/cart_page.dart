import 'package:flutter/material.dart';
import 'package:food_delivery_app/base/no_data_pages.dart';
import 'package:food_delivery_app/controllers/auth_controller.dart';
import 'package:food_delivery_app/controllers/cart_controller.dart';
import 'package:food_delivery_app/controllers/location_controller.dart';
import 'package:food_delivery_app/controllers/popular_product_controller.dart';
import 'package:food_delivery_app/controllers/recommended_product_controller.dart';
import 'package:food_delivery_app/routes/router_helper.dart';
import 'package:food_delivery_app/utils/app_constants.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:food_delivery_app/utils/dimensions.dart';
import 'package:food_delivery_app/widgets/app_icon.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:food_delivery_app/widgets/small.text.dart';
import 'package:intl/intl.dart';

import 'package:get/get.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: Dimensions.height20 * 3,
            left: Dimensions.width20,
            right: Dimensions.width20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // nut back
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: AppIcon(
                    icon: Icons.arrow_back_ios,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    IconSize: Dimensions.iconSize16,
                  ),
                ),
                SizedBox(width: Dimensions.width20 * 5),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(RouteHelper.getInitial());
                  },
                  child: AppIcon(
                    icon: Icons.home_outlined,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    IconSize: Dimensions.iconSize16,
                  ),
                ),
                AppIcon(
                  icon: Icons.shopping_cart,
                  iconColor: Colors.white,
                  backgroundColor: AppColors.mainColor,
                  IconSize: Dimensions.iconSize16,
                ),
              ],
            ),
          ),
          GetBuilder<CartController>(
            builder: (cartController) {
              return cartController.getItems.isNotEmpty
                  ? Positioned(
                    top: Dimensions.height20 * 5,
                    left: Dimensions.width20,
                    right: Dimensions.width20,
                    bottom: 0,
                    child: Container(
                      margin: EdgeInsets.only(top: Dimensions.height15),
                      // color: Colors.red,
                      child: MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        child: GetBuilder<CartController>(
                          builder: (cartController) {
                            var cartList = cartController.getItems;
                            return ListView.builder(
                              itemCount: cartList.length,
                              itemBuilder: (_, index) {
                                return SizedBox(
                                  width: double.maxFinite,
                                  height: Dimensions.height20 * 5,
                                  child: Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          var popularIndex = Get.find<
                                                PopularProductController
                                              >()
                                              .popularProductList
                                              .indexOf(
                                                cartList[index].product!,
                                              );
                                          if (popularIndex >= 0) {
                                            Get.toNamed(
                                              RouteHelper.getPopularFood(
                                                popularIndex,
                                                "cartpage",
                                              ),
                                            );
                                          } else {
                                            var recommendedIndex = Get.find<
                                                  RecommendedProductController
                                                >()
                                                .recommendedProductList
                                                .indexOf(
                                                  cartList[index].product!,
                                                );
                                            if (recommendedIndex < 0) {
                                              Get.snackbar(
                                                "History product",
                                                "Product review is not availble for history product!",
                                                backgroundColor:
                                                    AppColors.mainColor,
                                                colorText: Colors.white,
                                              );
                                            } else {
                                              Get.toNamed(
                                                RouteHelper.getRecommendedFood(
                                                  recommendedIndex,
                                                  "cartpage",
                                                ),
                                              );
                                            }
                                          }
                                        },
                                        child: Container(
                                          width: Dimensions.height20 * 5,
                                          height: Dimensions.height20 * 5,
                                          margin: EdgeInsets.only(
                                            bottom: Dimensions.height10,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(
                                              Dimensions.radius20,
                                            ),
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                AppConstants.BASE_URL +
                                                    AppConstants.UPLOAD_URL +
                                                    cartController
                                                        .getItems[index]
                                                        .img!,
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: Dimensions.width10),
                                      Expanded(
                                        child: SizedBox(
                                          height: Dimensions.height20 * 5,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              BigText(
                                                text:
                                                    cartController
                                                        .getItems[index]
                                                        .name!,
                                                color: Colors.black54,
                                              ),
                                              SmallText(text: "Spicy"),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  BigText(
                                                    text:
                                                        "${NumberFormat("#,###", "vi_VN").format((cartController.getItems[index].price ?? 0) * 1000)} vnđ",

                                                    color: Colors.redAccent,
                                                  ),

                                                  Container(
                                                    padding: EdgeInsets.only(
                                                      top: Dimensions.height10,
                                                      bottom:
                                                          Dimensions.height10,
                                                      left: Dimensions.width10,
                                                      right: Dimensions.width10,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            Dimensions.radius20,
                                                          ),
                                                      color: Colors.white,
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () {
                                                            cartController
                                                                .addItem(
                                                                  cartList[index]
                                                                      .product!,
                                                                  -1,
                                                                );
                                                          },
                                                          child: Icon(
                                                            Icons.remove,
                                                            color:
                                                                AppColors
                                                                    .paraColor,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width:
                                                              Dimensions
                                                                  .width10 /
                                                              2,
                                                        ),
                                                        BigText(
                                                          text:
                                                              cartList[index]
                                                                  .quantity
                                                                  .toString(),
                                                        ), //popularProduct.ionCartItems.toString(), color: AppColors.mainBlackColor),
                                                        SizedBox(
                                                          width:
                                                              Dimensions
                                                                  .width10 /
                                                              2,
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            cartController
                                                                .addItem(
                                                                  cartList[index]
                                                                      .product!,
                                                                  1,
                                                                );
                                                            // print("being tapped!");
                                                          },
                                                          child: Icon(
                                                            Icons.add,
                                                            color:
                                                                AppColors
                                                                    .paraColor,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  )
                  : NoDataPage(text: "Your cart is emty!");
            },
          ),
        ],
      ),
      bottomNavigationBar: GetBuilder<CartController>(
        builder: (cartController) {
          return Container(
            height: Dimensions.bottomHeightBar,
            padding: EdgeInsets.only(
              top: Dimensions.height30,
              bottom: Dimensions.height30,
              right: Dimensions.width20,
              left: Dimensions.width20,
            ),
            decoration: BoxDecoration(
              color: AppColors.buttomBacgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimensions.radius20 * 2),
                topRight: Radius.circular(Dimensions.radius20 * 2),
              ),
            ),
            child:
                cartController.getItems.isNotEmpty
                    ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // - or +
                        Container(
                          padding: EdgeInsets.only(
                            top: Dimensions.height20,
                            bottom: Dimensions.height15,
                            left: Dimensions.width20,
                            right: Dimensions.width20,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              Dimensions.radius20,
                            ),
                            color: Colors.white,
                          ),
                          child: Row(
                            children: [
                              SizedBox(width: Dimensions.width10 / 2),
                              BigText(
                                text:
                                    "${NumberFormat("#,###", "vi_VN").format(cartController.totalAmount * 1000)} vnđ",
                                color: AppColors.mainBlackColor,
                              ),

                              SizedBox(width: Dimensions.width10 / 2),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // popularProduct.addItem(product);

                            if (!Get.find<AuthController>().userLoggedIn()) {
                              print("tapped");
                              // cartController.addToHistory();
                              if (Get.find<LocationController>()
                                  .addressList
                                  .isEmpty) {
                                Get.toNamed(RouteHelper.getAddresssPage());
                              } else {
                                Get.offAndToNamed(RouteHelper.getInitial());
                              }
                            } else {
                              Get.toNamed(RouteHelper.getsigInPage());
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.only(
                              top: Dimensions.height20,
                              bottom: Dimensions.height15,
                              right: Dimensions.height20,
                              left: Dimensions.height20,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                Dimensions.radius20,
                              ),
                              color: AppColors.mainColor,
                            ),
                            child: BigText(
                              text: " Đặt món",
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    )
                    : Container(),
          );
        },
      ),
    );
  }
}
