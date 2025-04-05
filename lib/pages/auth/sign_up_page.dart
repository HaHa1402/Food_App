// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:food_delivery_app/base/custom_loader.dart';
// import 'package:food_delivery_app/base/show_custom_snack_bar.dart';
// import 'package:food_delivery_app/controllers/auth_controller.dart';
// import 'package:food_delivery_app/model/signup_body_model.dart';
// import 'package:food_delivery_app/routes/router_helper.dart';
// import 'package:food_delivery_app/utils/colors.dart';
// import 'package:food_delivery_app/utils/dimensions.dart';
// import 'package:food_delivery_app/widgets/app_text_filed.dart';
// import 'package:food_delivery_app/widgets/big_text.dart';

// import 'package:get/get.dart';

// class SigUpPage extends StatelessWidget {
//   const SigUpPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     var emialController = TextEditingController();
//     var passwordController = TextEditingController();
//     var nameController = TextEditingController();
//     var phoneController = TextEditingController();
//     var sigupImages = [
//       "t.png",
//       "f.png",
//       "g.png",
//     ];

//     void _registration(AuthController authController) {
//       // var authController = Get.find<AuthController>();

//       String name = nameController.text.trim();
//       String phone = phoneController.text.trim();
//       String email = emialController.text.trim();
//       String password = passwordController.text.trim();
//       if (name.isEmpty) {
//         showCustomSnackBar("Nhập tên của bạn", title: "Tên");
//       } else if (phone.isEmpty) {
//         showCustomSnackBar("Nhập tên điện thoại", title: "Số điện thoại");
//       } else if (email.isEmpty) {
//         showCustomSnackBar("Nhập địa chỉ email của bạn", title: "Địa chỉ email");
//       } else if (!GetUtils.isEmail(email)) {
//         showCustomSnackBar("Nhập địa chỉ email hợp lệ", title: "Địa chỉ email hợp lệ");
//       } else if (password.isEmpty) {
//         showCustomSnackBar("Nhập mật khẩu của bạn", title: "mật khẩu");
//       } else if (password.length < 6) {
//         showCustomSnackBar("Mật khẩu không được ít hơn sáu ký tự", title: "Mật khẩu");
//       } else {
//         SignUpBody signUpBody = SignUpBody(
//           name: name,
//           phone: phone,
//           email: email,
//           password: password,
//         );
//         authController.registration(signUpBody).then((status) {
//           if (!status.isSuccess) {
//             // Get.toNamed(RouteHelper.getInitial());
//             Get.offNamed(RouteHelper.getInitial());

//             print("Đăng ký thành công");
//           } else {
//             showCustomSnackBar(status.message);
//           }
//         });
//       }
//     }

//     return Scaffold(
//         backgroundColor: Colors.white,
//         body: GetBuilder<AuthController>(builder: (_authController) {
//           return !_authController.isLoading
//               ? SingleChildScrollView(
//                   physics: BouncingScrollPhysics(),
//                   child: Column(
//                     children: [
//                       SizedBox(height: Dimensions.screenHeight * 0.05),
//                       //app logo
//                       Container(
//                         height: Dimensions.screenHeight * 0.25,
//                         child: Center(
//                           child: CircleAvatar(
//                             radius: 80,
//                             backgroundColor: Colors.white,
//                             backgroundImage: AssetImage("assets/images/logo part 1.png"),
//                           ),
//                         ),
//                       ),
//                       //email
//                       AppTextFiled(textEditingController: emialController, hintText: "Email", icon: Icons.email),
//                       SizedBox(height: Dimensions.height20),
//                       //password
//                       AppTextFiled(textEditingController: passwordController, hintText: "Mật khẩu", icon: Icons.password_sharp, isObscure: true),
//                       SizedBox(height: Dimensions.height20),
//                       //Name
//                       AppTextFiled(textEditingController: nameController, hintText: "Tên", icon: Icons.person),
//                       SizedBox(height: Dimensions.height20),
//                       //Phone
//                       AppTextFiled(textEditingController: phoneController, hintText: "Điện thoại", icon: Icons.phone),
//                       SizedBox(height: Dimensions.height20),
//                       //Sig Up
//                       GestureDetector(
//                         onTap: () {
//                           _registration(_authController);
//                         },
//                         child: Container(
//                           width: Dimensions.screenWeight / 2,
//                           height: Dimensions.screenHeight / 13,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(Dimensions.radius30),
//                             color: AppColors.mainColor,
//                           ),
//                           child: Center(child: BigText(text: "Đăng ký", size: Dimensions.font20 + Dimensions.font20 / 2, color: Colors.white)),
//                         ),
//                       ),
//                       SizedBox(height: Dimensions.height10),
//                       //Have an account alredy?
//                       RichText(
//                         text: TextSpan(
//                           text: "Bạn đã có tài khoản chưa?",
//                           recognizer: TapGestureRecognizer()..onTap = () => Get.back(),
//                           style: TextStyle(color: Colors.grey[500], fontSize: Dimensions.font20),
//                         ),
//                       ),
//                       //
//                       SizedBox(height: Dimensions.screenHeight * 0.05),
//                       //sigup options
//                       RichText(
//                         text: TextSpan(
//                           text: "Đăng ký bằng một trong những phương pháp sau?",
//                           style: TextStyle(color: Colors.grey[500], fontSize: Dimensions.font16),
//                         ),
//                       ),
//                       Wrap(
//                         children: List.generate(
//                             3,
//                             (index) => Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: CircleAvatar(
//                                     radius: Dimensions.radius30,
//                                     backgroundImage: AssetImage("assets/images/" + sigupImages[index]),
//                                   ),
//                                 )),
//                       ),
//                     ],
//                   ),
//                 )
//               : const CustomLoader();
//         }));
//   }
// }






import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import 'package:food_delivery_app/base/custom_loader.dart';
import 'package:food_delivery_app/base/show_custom_snack_bar.dart';
import 'package:food_delivery_app/routes/router_helper.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:food_delivery_app/utils/dimensions.dart';
import 'package:food_delivery_app/widgets/app_text_filed.dart';
import 'package:food_delivery_app/widgets/big_text.dart';

class SigUpPage extends StatefulWidget {
  const SigUpPage({Key? key}) : super(key: key);

  @override
  State<SigUpPage> createState() => _SigUpPageState();
}

class _SigUpPageState extends State<SigUpPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  bool isLoading = false;

  final List<String> signupImages = ["t.png", "f.png", "g.png"];

  void _registerWithFirebase() async {
    String name = nameController.text.trim();
    String phone = phoneController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (name.isEmpty) {
      showCustomSnackBar("Nhập tên của bạn", title: "Tên");
      return;
    } else if (phone.isEmpty) {
      showCustomSnackBar("Nhập số điện thoại", title: "Số điện thoại");
      return;
    } else if (email.isEmpty) {
      showCustomSnackBar("Nhập địa chỉ email", title: "Email");
      return;
    } else if (!GetUtils.isEmail(email)) {
      showCustomSnackBar("Email không hợp lệ", title: "Email");
      return;
    } else if (password.isEmpty) {
      showCustomSnackBar("Nhập mật khẩu", title: "Mật khẩu");
      return;
    } else if (password.length < 6) {
      showCustomSnackBar("Mật khẩu phải từ 6 ký tự trở lên", title: "Mật khẩu");
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Đăng ký thành công → chuyển sang trang chính
      Get.offAllNamed(RouteHelper.getInitial());
    } on FirebaseAuthException catch (e) {
      showCustomSnackBar(e.message ?? "Đăng ký thất bại");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: isLoading
          ? const CustomLoader()
          : SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(height: Dimensions.screenHeight * 0.05),
                  // logo
                  Container(
                    height: Dimensions.screenHeight * 0.25,
                    child: Center(
                      child: CircleAvatar(
                        radius: 80,
                        backgroundColor: Colors.white,
                        backgroundImage:
                            AssetImage("assets/images/logo part 1.png"),
                      ),
                    ),
                  ),
                  AppTextFiled(
                    textEditingController: emailController,
                    hintText: "Email",
                    icon: Icons.email,
                  ),
                  SizedBox(height: Dimensions.height20),
                  AppTextFiled(
                    textEditingController: passwordController,
                    hintText: "Mật khẩu",
                    icon: Icons.password_sharp,
                    isObscure: true,
                  ),
                  SizedBox(height: Dimensions.height20),
                  AppTextFiled(
                    textEditingController: nameController,
                    hintText: "Tên",
                    icon: Icons.person,
                  ),
                  SizedBox(height: Dimensions.height20),
                  AppTextFiled(
                    textEditingController: phoneController,
                    hintText: "Điện thoại",
                    icon: Icons.phone,
                  ),
                  SizedBox(height: Dimensions.height20),
                  GestureDetector(
                    onTap: _registerWithFirebase,
                    child: Container(
                      width: Dimensions.screenWeight / 2,
                      height: Dimensions.screenHeight / 13,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius30),
                        color: AppColors.mainColor,
                      ),
                      child: Center(
                        child: BigText(
                          text: "Đăng ký",
                          size: Dimensions.font20 + Dimensions.font20 / 2,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: Dimensions.height10),
                  RichText(
                    text: TextSpan(
                      text: "Bạn đã có tài khoản chưa?",
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Get.back(),
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: Dimensions.font20,
                      ),
                    ),
                  ),
                  SizedBox(height: Dimensions.screenHeight * 0.05),
                  RichText(
                    text: TextSpan(
                      text: "Đăng ký bằng một trong những phương pháp sau?",
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: Dimensions.font16,
                      ),
                    ),
                  ),
                  Wrap(
                    children: List.generate(
                      signupImages.length,
                      (index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          radius: Dimensions.radius30,
                          backgroundImage:
                              AssetImage("assets/images/${signupImages[index]}"),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
