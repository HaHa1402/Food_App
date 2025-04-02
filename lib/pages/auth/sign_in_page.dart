import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/base/custom_loader.dart';
import 'package:food_delivery_app/base/show_custom_snack_bar.dart';
import 'package:food_delivery_app/controllers/auth_controller.dart';
import 'package:food_delivery_app/pages/auth/sign_up_page.dart';
import 'package:food_delivery_app/routes/router_helper.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:food_delivery_app/utils/dimensions.dart';
import 'package:food_delivery_app/widgets/app_text_filed.dart';
import 'package:food_delivery_app/widgets/big_text.dart';

import 'package:get/get.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var phoneController = TextEditingController();
    var passwordController = TextEditingController();
    void _login(AuthController authController) {
      // var authController = Get.find<AuthController>();
      String phone = phoneController.text.trim();
      String password = passwordController.text.trim();
      if (phone.isEmpty) {
        showCustomSnackBar("Nhập địa chỉ email của bạn", title: "Địa chỉ email");
      } else if (!GetUtils.isEmail(phone)) {
        showCustomSnackBar(
          "Nhập địa chỉ email hợp lệ",
          title: "Địa chỉ email hợp lệ",
        );
      } else if (password.isEmpty) {
        showCustomSnackBar("Nhập mật khẩu của bạn", title: "mật khẩu");
      } else if (password.length < 6) {
        showCustomSnackBar(
          "Mật khẩu không được ít hơn sáu ký tự",
          title: "Mật khẩu",
        );
      } else {
        authController.login(phone, password).then((status) {
          if (!status.isSuccess) {
            Get.toNamed(RouteHelper.getInitial());
            // Get.toNamed(RouteHelper.getCartPage());
            // Get.offAllNamed(RouteHelper.getInitial());
            print("Đăng ký thành công");
          } else {
            showCustomSnackBar(status.message);
          }
        });
        // Get.toNamed(RouteHelper.getInitial());
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(
        builder: (authController) {
          return !authController.isLoading
              ? SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(height: Dimensions.screenHeight * 0.05),
                    //app logo
                    Container(
                      height: Dimensions.screenHeight * 0.25,
                      child: Center(
                        child: CircleAvatar(
                          radius: 80,
                          backgroundColor: Colors.white,
                          backgroundImage: AssetImage(
                            "assets/images/logo part 1.png",
                          ),
                        ),
                      ),
                    ),
                    // Hello 
                    Center(
                      child: Container(
                        margin: EdgeInsets.only(
                          left: Dimensions.width20,
                        ), 
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.center, // Căn giữa các text
                          children: [
                            Text(
                              "Xin chào",
                              style: TextStyle(
                                fontSize:
                                    Dimensions.font20 * 3 +
                                    Dimensions.font20 / 2,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center, // Căn giữa text
                            ),
                            SizedBox(
                              height: Dimensions.height10,
                            ), // Khoảng cách giữa 2 dòng
                            Text(
                              "Đăng nhập vào tài khoản của bạn",
                              style: TextStyle(
                                fontSize: Dimensions.font20,
                                color: Colors.grey[500],
                              ),
                              textAlign: TextAlign.center, // Căn giữa text
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: Dimensions.screenHeight * 0.05),
                    //email
                    AppTextFiled(
                      textEditingController: phoneController,
                      hintText: "Email",
                      icon: Icons.email,
                    ),
                    SizedBox(height: Dimensions.height20),
                    //password
                    AppTextFiled(
                      textEditingController: passwordController,
                      hintText: "Mật khẩu",
                      icon: Icons.password,
                      isObscure: true,
                    ),
                    SizedBox(height: Dimensions.height20),

                    SizedBox(height: Dimensions.height10),
                    //Have an account alredy?
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(child: Container()),
                        RichText(
                          text: TextSpan(
                            text: "Đăng nhập vào tài khoản của bạn",
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: Dimensions.font20,
                            ),
                          ),
                        ),
                        SizedBox(width: Dimensions.width20),
                      ],
                    ),
                    //
                    SizedBox(height: Dimensions.screenHeight * 0.05),
                    //sigin
                    GestureDetector(
                      onTap: () {
                        _login(authController);
                      },
                      child: Container(
                        width: Dimensions.screenWeight / 2,
                        height: Dimensions.screenHeight / 13,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            Dimensions.radius30,
                          ),
                          color: AppColors.mainColor,
                        ),
                        child: Center(
                          child: BigText(
                            text: "Đăng nhập",
                            size: Dimensions.font20 + Dimensions.font20 / 2,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: Dimensions.screenHeight * 0.05),

                    RichText(
                      text: TextSpan(
                        text: "Không có tài khoản?",
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: Dimensions.font20,
                        ),
                        children: [
                          TextSpan(
                            recognizer:
                                TapGestureRecognizer()
                                  ..onTap =
                                      () => Get.to(
                                        () => SigUpPage(),
                                        transition: Transition.fade,
                                      ),
                            text: " Tạo tài khoản?",
                            style: TextStyle(
                              color: AppColors.mainBlackColor,
                              fontSize: Dimensions.font20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
              : CustomLoader();
        },
      ),
    );
  }
}
