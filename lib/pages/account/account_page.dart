
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
