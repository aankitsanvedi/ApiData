import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_01/View/Pages/Card/card_page.dart';
import 'package:project_01/View/Pages/Home/home_page.dart';
import 'package:project_01/View/Pages/Home/home_screen.dart';
import 'package:project_01/View/Pages/Profile/user_Profile_page.dart';
import 'package:project_01/View/Pages/Order/order_page.dart';
import 'package:project_01/View/Pages/Wallet/wallet_page.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int currentindex = 0;
  final screen = [
 //  const HomePage(),
   const HomeScreen(),
    const CardPage(),
    const OrderPage(),
    const WalletPage(),
    const UserProfilePage()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.red,
          // fixedColor: Colors.black,
          iconSize: 30,
          fixedColor: Colors.white,
          currentIndex: currentindex,
          onTap: (value) {
            currentindex = value;
            setState(() {});
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: Colors.white,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
              label: 'Cart',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.shopping_bag,
                color: Colors.white,
              ),
              label: 'Order',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.wallet,
                color: Colors.white,
              ),
              label: 'Wallet',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              label: 'Profile',
            ),
          ]),
      body: screen[currentindex],
    );
  }
}
