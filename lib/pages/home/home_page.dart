import 'package:flutter/material.dart';
import 'package:food_delivery_app/pages/account/account_page.dart';
import 'package:food_delivery_app/pages/auth/sign_in_page.dart';
import 'package:food_delivery_app/pages/cart/cart_history.dart';
import 'package:food_delivery_app/pages/home/main_food_page.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:food_delivery_app/pages/cart/cart_page.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  List pages = [
    MainFoodPage(),
    SignInPage(),
      CartPage(), 
    CartHistory(),
    AccountPage(),
     
  ];
  void onTapNav(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColors.mainColor,
        unselectedItemColor: Colors.amberAccent,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _selectedIndex,
        selectedFontSize: 0.0,
        unselectedFontSize: 0.0,
        onTap: onTapNav,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: "home"),
          BottomNavigationBarItem(icon: Icon(Icons.archive), label: "login"),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "cart"),
            BottomNavigationBarItem(icon: Icon(Icons.access_time), label: "historycart"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "me"),
        ],
      ),
    );
  }
}
