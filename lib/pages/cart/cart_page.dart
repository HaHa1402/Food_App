import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:food_delivery_app/base/no_data_pages.dart';
import 'package:food_delivery_app/controllers/cart_controller.dart';
import 'package:food_delivery_app/utils/app_constants.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:food_delivery_app/utils/dimensions.dart';
import 'package:food_delivery_app/widgets/app_icon.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:food_delivery_app/widgets/small.text.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  Map<String, dynamic>? paymentIntent;

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
                    Get.toNamed('/'); // Route to home
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
          GetBuilder<CartController>(builder: (_cartController) {
            return _cartController.getItems.isNotEmpty
                ? Positioned(
                    top: Dimensions.height20 * 5,
                    left: Dimensions.width20,
                    right: Dimensions.width20,
                    bottom: 0,
                    child: ListView.builder(
                      itemCount: _cartController.getItems.length,
                      itemBuilder: (_, index) {
                        var cartItem = _cartController.getItems[index];
                        return Container(
                          margin: EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          '${AppConstants.BASE_URL}${AppConstants.UPLOAD_URL}${cartItem.img}'),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    BigText(text: cartItem.name ?? ''),
                                    SmallText(text: "Cay"),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        BigText(
                                          text:
                                              '${NumberFormat("#,###", "vi_VN").format((cartItem.price ?? 0) * 1000)} vnđ',
                                          color: Colors.redAccent,
                                        ),
                                        Row(
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                _cartController.addItem(
                                                    cartItem.product!, -1);
                                              },
                                              icon: Icon(Icons.remove),
                                            ),
                                            BigText(
                                              text: cartItem.quantity.toString(),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                _cartController.addItem(
                                                    cartItem.product!, 1);
                                              },
                                              icon: Icon(Icons.add),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  )
                : NoDataPage(text: "Giỏ hàng của bạn đã trống!");
          }),
        ],
      ),
      bottomNavigationBar: GetBuilder<CartController>(builder: (cartController) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          decoration: BoxDecoration(
            color: AppColors.buttomBacgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(Dimensions.radius20 * 2),
              topRight: Radius.circular(Dimensions.radius20 * 2),
            ),
          ),
          child: cartController.getItems.isNotEmpty
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BigText(
                      text:
                          "${NumberFormat("#,###", "vi_VN").format(cartController.totalAmount * 1000)} vnđ",
                      color: Colors.black,
                    ),
                    GestureDetector(
                      onTap: () async {
                        await makePayment(
                          (cartController.totalAmount * 1000).toString(),
                          'vnd',
                        );
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        decoration: BoxDecoration(
                          color: AppColors.mainColor,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: BigText(text: "Đặt món", color: Colors.white),
                      ),
                    ),
                  ],
                )
              : SizedBox.shrink(),
        );
      }),
    );
  }

  Future<void> makePayment(String amount, String currency) async {
    try {
      print("Tạo payment intent với số tiền: $amount $currency");
      paymentIntent = await createPaymentIntent(amount, currency);
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent!['client_secret'],
          style: ThemeMode.light,
          merchantDisplayName: 'FoodApp',
        ),
      );
      await displayPaymentSheet();
    } catch (e) {
      print("Lỗi thanh toán: $e");
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text("Lỗi thanh toán"),
          content: Text("Không thể thanh toán, vui lòng thử lại sau."),
        ),
      );
    }
  }

  Future<void> displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();
      print("Thanh toán thành công");
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text("Thanh toán thành công"),
          content: Icon(Icons.check_circle, color: Colors.green, size: 80),
        ),
      );
      setState(() {
        paymentIntent = null;
      });
    } catch (e) {
      print("Lỗi hiển thị payment sheet: $e");
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text("Thanh toán thất bại"),
          content: Text("Lỗi: $e"),
        ),
      );
    }
  }

  Future<Map<String, dynamic>> createPaymentIntent(
    String amount, String currency) async {
  try {
    Map<String, dynamic> body = {
      'amount': amount,
      'currency': currency,
      'payment_method_types[]': 'card',
    };

    var response = await http.post(
      Uri.parse('https://api.stripe.com/v1/payment_intents'),
      headers: {
        'Authorization': 'Bearer sk_test_51RBAS5PTYhy9W7L6fLElQlbNRr8S9uJ6bLbazNyz66xLJHPhHeXH3NU7xptfkkoZMcwIVtoPlinJpQ0DnHrQtcMQ00oEpFAUCh', // <-- Sửa lại khóa secret key của bạn ở đây
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: body,
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print("Stripe API error: ${response.body}");
      throw Exception('Failed to create payment intent: ${response.body}');
    }
  } catch (err) {
    print("Lỗi khi gọi API: $err");
    throw Exception('Không thể tạo payment intent');
  }
}

}
