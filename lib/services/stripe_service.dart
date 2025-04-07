import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:food_delivery_app/widgets/const.dart'; // Đảm bảo là bạn đã khai báo đúng stripeSecretKey

class StripeService {
  StripeService._();

  static final StripeService instance = StripeService._();

  Future<void> makePayment() async {
    try {
      // Tạo PaymentIntent
      String? paymentIntentClientSecret = await _createPaymentIntent(
        10,  // Số tiền cần thanh toán, ví dụ là 1000 VNĐ
        "vnd", // Đơn vị tiền tệ là VNĐ (mã chuẩn của Stripe là 'vnd')
      );
      if (paymentIntentClientSecret == null) return;

      // Khởi tạo Payment Sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntentClientSecret,
          merchantDisplayName: "Food-App", // Tên cửa hàng
        ),
      );

      // Hiển thị Payment Sheet và xử lý thanh toán
      await _processPayment(); 
    } catch (e) {
      print("Error during payment process: $e");
    }
  }

  /// Tạo PaymentIntent để giao dịch
  Future<String?> _createPaymentIntent(int amount, String currency) async {
    try {
      final Dio dio = Dio();
      Map<String, dynamic> data = {
        "amount": _calculateAmount(amount),  // Số tiền tính toán (chuyển thành đơn vị nhỏ nhất, ví dụ cent)
        "currency": currency.toLowerCase(),  // Đảm bảo là viết thường cho currency (ví dụ 'vnd')
      };

      var response = await dio.post(
        "https://api.stripe.com/v1/payment_intents",
        data: data,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {
            "Authorization": "Bearer $stripeSecretKey",  // Không nên để stripeSecretKey trong ứng dụng
            "Content-Type": 'application/x-www-form-urlencoded',
          },
        ),
      );

      if (response.statusCode == 200 && response.data != null) {
        return response.data["client_secret"];
      } else {
        print("Error from Stripe API: ${response.data}");
        return null;
      }
    } catch (e) {
      print("Error creating payment intent: $e");
    }
    return null;
  }

  // Xử lý Payment Sheet và hoàn tất thanh toán
  Future<void> _processPayment() async {
    try {
      // Hiển thị Payment Sheet
      await Stripe.instance.presentPaymentSheet();
      
      // Xác nhận thanh toán
      await Stripe.instance.confirmPaymentSheetPayment();
      print("Payment successful!");
    } catch (e) {
      print("Error processing payment: $e");
    }
  }

  // Tính toán số tiền (ví dụ: từ VNĐ thành cent)
  String _calculateAmount(int amount) {
    final calculatedAmount = amount * 100;  // Chuyển từ VNĐ sang cent
    return calculatedAmount.toString();
  }
}
