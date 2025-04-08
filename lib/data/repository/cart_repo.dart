import 'dart:convert';

import 'package:food_delivery_app/model/cart_model.dart';
import 'package:food_delivery_app/model/product_model.dart';
import 'package:food_delivery_app/pages/cart/cart_history.dart';
import 'package:food_delivery_app/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';



class CartRepo {
  //
  final SharedPreferences sharedPreferences;
  CartRepo({required this.sharedPreferences});

  List<String> cart = [];
  List<String> cartHistory = [];

  void addToCartLIst(List<CartModel> cartList) {
    // sharedPreferences.remove(AppConstants.CART_LIST);
    // sharedPreferences.remove(AppConstants.CART_HISTORY_LIST);
    // return;
    var time = DateTime.now().toString();
    cart = [];

    cartList.forEach((element) {
      element.time = time;
      return cart.add(jsonEncode(element));
    });

    sharedPreferences.setStringList(AppConstants.CART_LIST, cart);
    // print(sharedPreferences.getStringList(AppConstants.CART_LIST));
    // getCartList();
  }

  List<CartModel> getCartList() {
    List<String> carts = [];
    if (sharedPreferences.containsKey(AppConstants.CART_LIST)) {
      carts = sharedPreferences.getStringList(AppConstants.CART_LIST)!; // Bomba hato
      // print("inside getCartList" + cart.toString());
    }
    List<CartModel> cartList = [];

    carts.forEach((element) => cartList.add(CartModel.fromJson(jsonDecode(element))));
    return cartList;
  }

  List<CartModel> getCartHistoryList() {
    if (sharedPreferences.containsKey(AppConstants.CART_HISTORY_LIST)) {
      // cartHistory = [];
      cartHistory = sharedPreferences.getStringList(AppConstants.CART_HISTORY_LIST)!;
    }
    List<CartModel> cartListHistory = [];
    cartHistory.forEach((element) => cartListHistory.add(CartModel.fromJson(jsonDecode(element))));
    return cartListHistory;
  }

// List<CartModel> getCartHistoryList() {
//   if (sharedPreferences.containsKey(AppConstants.CART_HISTORY_LIST)) {
//     cartHistory = sharedPreferences.getStringList(AppConstants.CART_HISTORY_LIST)!;
//   }

//   List<CartModel> cartListHistory = [];

//   if (cartHistory.isEmpty) {
//     // 👇 Thêm đơn hàng giả nếu danh sách rỗng
//     cartListHistory = [
//       CartModel(
//         id: 1,
//         name: "Bánh Mì Trứng",
//         price: 15000,
//         img: "/assets/images/food12.png",
//         quantity: 1,
//         isExit: true,
//         time: "2025-04-07 09:00:00",
//         product: ProductModel(
//           id: 1,
//           name: "Bánh Mì Trứng",
//           description: "Bánh mì giòn, trứng chiên thơm béo",
//           price: 15000,
//           stars: 4,
//           img: "/assets/images/food12.png",
//           location: "TP.HCM",
//           createdAt: "2025-04-01",
//           updatedAt: "2025-04-01",
//           typeId: 1,
//         ),
//       ),
//       CartModel(
//         id: 2,
//         name: "Sữa Tươi Trân Châu",
//         price: 30000,
//         img: "/uploads/suatrua.png",
//         quantity: 2,
//         isExit: true,
//         time: "2025-04-06 15:30:00",
//         product: ProductModel(
//           id: 2,
//           name: "Sữa Tươi Trân Châu",
//           description: "Sữa tươi thanh mát kèm trân châu đen",
//           price: 30000,
//           stars: 5,
//           img: "/uploads/suatrua.png",
//           location: "Hà Nội",
//           createdAt: "2025-04-01",
//           updatedAt: "2025-04-01",
//           typeId: 2,
//         ),
//       ),
//     ];
//   } else {
//     // 👇 Nếu có dữ liệu thật thì dùng dữ liệu thật
//     cartHistory.forEach((element) {
//       cartListHistory.add(CartModel.fromJson(jsonDecode(element)));
//     });
//   }

//   return cartListHistory;
// }



  void addToCartHistoryList() {
  if (sharedPreferences.containsKey(AppConstants.CART_HISTORY_LIST)) {
    cartHistory = sharedPreferences.getStringList(AppConstants.CART_HISTORY_LIST)!;
  }

  if (cart.isNotEmpty) { // Kiểm tra giỏ hàng có sản phẩm không
    for (int i = 0; i < cart.length; i++) {
      cartHistory.add(cart[i]);
    }
    removeCart(); // Xóa giỏ hàng sau khi đã lưu vào lịch sử
    sharedPreferences.setStringList(AppConstants.CART_HISTORY_LIST, cartHistory);
  } else {
    print("Giỏ hàng trống. Không có đơn hàng để lưu vào lịch sử.");
  }
}


  void removeCart() {
    cart = [];
    sharedPreferences.remove(AppConstants.CART_LIST);
  }

  void clearCartHistory() {
    removeCart();
    cartHistory = [];
    sharedPreferences.remove(AppConstants.CART_HISTORY_LIST);
  }
}
