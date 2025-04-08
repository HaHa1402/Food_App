import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:food_delivery_app/base/no_data_pages.dart';
import 'package:food_delivery_app/controllers/cart_controller.dart';
import 'package:food_delivery_app/model/cart_model.dart';
import 'package:food_delivery_app/model/product_model.dart';
import 'package:food_delivery_app/utils/app_constants.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:food_delivery_app/utils/dimensions.dart';
import 'package:food_delivery_app/widgets/app_icon.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:food_delivery_app/widgets/small.text.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  Map<String, dynamic>? paymentIntent;

  void safeAddToCart(ProductModel? product, int quantity) {
    if (product != null) {
      Get.find<CartController>().addItem(product, quantity);
    } else {
      print("⚠️ Product is null, không thể thêm vào giỏ.");
    }
  }

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
                  onTap: () => Get.back(),
                  child: AppIcon(
                    icon: Icons.arrow_back_ios,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    IconSize: Dimensions.iconSize16,
                  ),
                ),
                SizedBox(width: Dimensions.width20 * 5),
                GestureDetector(
                  onTap: () => Get.toNamed('/'),
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
                                        '${AppConstants.BASE_URL}${AppConstants.UPLOAD_URL}${cartItem.img}',
                                      ),
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
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        BigText(
                                          text: '${NumberFormat("#,###", "vi_VN").format((cartItem.price ?? 0) * 1000)} vnđ',
                                          color: Colors.redAccent,
                                        ),
                                        Row(
                                          children: [
                                            IconButton(
                                              onPressed: () => safeAddToCart(cartItem.product, -1),
                                              icon: Icon(Icons.remove),
                                            ),
                                            BigText(text: cartItem.quantity.toString()),
                                            IconButton(
                                              onPressed: () => safeAddToCart(cartItem.product, 1),
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
                      text: "${NumberFormat("#,###", "vi_VN").format(cartController.totalAmount * 1000)} vnđ",
                      color: Colors.black,
                    ),
                    GestureDetector(
                      onTap: () async {
                        await makePayment((cartController.totalAmount * 1000).toString(), 'vnd');
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
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

      if (paymentIntent == null || !paymentIntent!.containsKey('client_secret')) {
        print("❌ Không thể tạo payment intent hoặc client_secret không hợp lệ.");
        return;
      }

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

      CartController cartController = Get.find<CartController>();
      String userId = 'test1@gmail.com';
      String orderId = DateTime.now().millisecondsSinceEpoch.toString();

      List<CartModel> cartItems = cartController.getItems.map((item) {
        return CartModel(
          id: item.id ?? 0,
          name: item.name ?? '',
          quantity: item.quantity ?? 0,
          price: item.price ?? 0,
          img: item.img ?? '',
          isExit: item.isExit ?? false,
          time: item.time ?? '',
          product: item.product != null ? ProductModel.fromJson(item.product!.toJson()) : null,
        );
      }).toList();

      CartModel order = CartModel(
        id: int.tryParse(orderId),
        name: 'Order $orderId',
        price: cartController.totalAmount.toInt(),
        img: '',
        quantity: cartItems.length,
        isExit: true,
        time: DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
        product: null,
      );

      await saveOrderToServer(order, userId, orderId);
      cartController.addToHistory();
      cartController.clear();

      Get.offAllNamed('/');

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

  Future<void> saveOrderToServer(CartModel order, String userId, String orderId) async {
    try {
      if (order == null || userId == null || orderId == null) {
        print("❌ Dữ liệu đơn hàng không hợp lệ.");
        return;
      }

      var orderData = {
        ...order.toJson(),
        "userId": userId,
        "orderId": orderId,
      };

      if (orderData.values.any((value) => value == null)) {
        print("❌ Dữ liệu đơn hàng không hợp lệ, có giá trị null.");
        return;
      }

      await FirebaseFirestore.instance.collection('order_history').add(orderData);
      print("🟢 Đơn hàng đã được lưu thành công.");
    } catch (e) {
      print("❌ Lỗi lưu đơn hàng vào Firestore: $e");
    }
  }

  Future<Map<String, dynamic>> createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': amount,
        'currency': currency,
        'payment_method_types[]': 'card',
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer sk_test_51RBAS5PTYhy9W7L6fLElQlbNRr8S9uJ6bLbazNyz66xLJHPhHeXH3NU7xptfkkoZMcwIVtoPlinJpQ0DnHrQtcMQ00oEpFAUCh',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: body,
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        print("Stripe API Error: ${response.body}");
        return {};
      }
    } catch (e) {
      print("Lỗi tạo payment intent: $e");
      return {};
    }
  }
}
