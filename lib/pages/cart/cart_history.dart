import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_delivery_app/base/no_data_pages.dart';
import 'package:food_delivery_app/controllers/cart_controller.dart';
import 'package:food_delivery_app/model/cart_model.dart';
import 'package:food_delivery_app/routes/router_helper.dart';
import 'package:food_delivery_app/utils/app_constants.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:food_delivery_app/utils/dimensions.dart';
import 'package:food_delivery_app/widgets/app_icon.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:food_delivery_app/widgets/small.text.dart';


import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var getCartHistoryList = Get.find<CartController>().getCartHistoryList().reversed.toList();
    Map<String, int> cartItemsPerOrder = Map();
    
    // Nhóm các sản phẩm theo thời gian
    for (var i = 0; i < getCartHistoryList.length; i++) {
      if (cartItemsPerOrder.containsKey(getCartHistoryList[i].time)) {
        cartItemsPerOrder.update(getCartHistoryList[i].time!, (value) => ++value);
      } else {
        cartItemsPerOrder.putIfAbsent(getCartHistoryList[i].time!, () => 1);
      }
    }
    
    // Lấy danh sách số lượng sản phẩm mỗi đơn hàng
    List<int> itemsPerOrder = cartItemsPerOrder.entries.map((e) => e.value).toList();

    var listCounter = 0;

    // Widget hiển thị thời gian đơn hàng
    Widget timeWidget(int index) {
      var outputDate = DateTime.now().toString();
      if (index < getCartHistoryList.length) {
        DateTime parseDate = DateFormat("yyyy-MM-dd HH:mm:ss").parse(getCartHistoryList[listCounter].time!);
        var inputDate = DateTime.parse(parseDate.toString());
        var outputFormat = DateFormat("MM/dd/yyyy hh:mm a");
        outputDate = outputFormat.format(inputDate);
      }
      return BigText(text: outputDate);
    }
return Scaffold(
  body: SafeArea(
    child: Column(
      children: [
        // ✅ Header cố định ở trên
        Container(
          padding: EdgeInsets.only(top: Dimensions.height20),
          color: AppColors.mainColor,
          width: double.infinity,
          height: Dimensions.height10 * 7,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              BigText(text: "Lịch sử mua hàng", color: Colors.white),
              AppIcon(
                icon: Icons.shopping_cart_outlined,
                iconColor: AppColors.mainColor,
                backgroundColor: AppColors.yellowColor,
              ),
            ],
          ),
        ),

        // ✅ Nội dung cuộn được
        Expanded(
          child: GetBuilder<CartController>(
            builder: (_cartController) {
              var cartHistoryList = _cartController.getCartHistoryList().reversed.toList();
              if (cartHistoryList.isEmpty) {
                return Center(
                  child: NoDataPage(
                    text: "Bạn vẫn chưa mua gì cả!",
                    imgPath: "assets/images/empty_box.png",
                  ),
                );
              }

              // Xử lý nhóm đơn hàng
              Map<String, int> cartItemsPerOrder = {};
              for (var item in cartHistoryList) {
                if (cartItemsPerOrder.containsKey(item.time)) {
                  cartItemsPerOrder.update(item.time!, (value) => ++value);
                } else {
                  cartItemsPerOrder.putIfAbsent(item.time!, () => 1);
                }
              }

              List<int> itemsPerOrder = cartItemsPerOrder.entries.map((e) => e.value).toList();
              var listCounter = 0;

              Widget timeWidget(int index) {
                String outputDate = "";
                if (index < cartHistoryList.length) {
                  DateTime parseDate = DateFormat("yyyy-MM-dd HH:mm:ss").parse(cartHistoryList[listCounter].time!);
                  outputDate = DateFormat("MM/dd/yyyy hh:mm a").format(parseDate);
                }
                return BigText(text: outputDate);
              }

              return SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.width20,
                    vertical: Dimensions.height20,
                  ),
                  child: Column(
                    children: List.generate(itemsPerOrder.length, (i) {
                      return Container(
                        margin: EdgeInsets.only(bottom: Dimensions.height20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            timeWidget(listCounter),
                            SizedBox(height: Dimensions.height10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Wrap(
                                  children: List.generate(itemsPerOrder[i], (index) {
                                    if (listCounter < cartHistoryList.length) listCounter++;
                                    return index <= 2
                                        ? Container(
                                            height: Dimensions.height20 * 4,
                                            width: Dimensions.height20 * 4,
                                            margin: EdgeInsets.only(right: Dimensions.width10 / 2),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(Dimensions.radius15 / 2),
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                  AppConstants.BASE_URL +
                                                      AppConstants.UPLOAD_URL +
                                                      cartHistoryList[listCounter - 1].img!,
                                                ),
                                              ),
                                            ),
                                          )
                                        : Container();
                                  }),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    SmallText(text: "Tổng cộng", color: AppColors.titleColor),
                                    BigText(text: "${itemsPerOrder[i]} món", color: AppColors.titleColor),
                                    GestureDetector(
                                      onTap: () {
                                        var orderTime = cartItemsPerOrder.keys.toList();
                                        Map<int, CartModel> moreOrder = {};
                                        for (var j = 0; j < cartHistoryList.length; j++) {
                                          if (cartHistoryList[j].time == orderTime[i]) {
                                            moreOrder.putIfAbsent(
                                              cartHistoryList[j].id!,
                                              () => CartModel.fromJson(jsonDecode(jsonEncode(cartHistoryList[j]))),
                                            );
                                          }
                                        }
                                        Get.find<CartController>().setItems = moreOrder;
                                        Get.find<CartController>().addToCartList();
                                        Get.toNamed(RouteHelper.getCartPage());
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: Dimensions.width10,
                                          vertical: Dimensions.height10 / 2,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(Dimensions.radius15),
                                          border: Border.all(width: 1, color: AppColors.mainColor),
                                        ),
                                        child: SmallText(text: "Xem thêm", color: AppColors.mainColor),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    ),
  ),
);
  }
}