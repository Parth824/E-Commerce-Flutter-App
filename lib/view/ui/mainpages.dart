
import 'package:e_commerce_app/view/ui/cart.dart';
import 'package:e_commerce_app/view/ui/favorit.dart';
import 'package:e_commerce_app/view/ui/product_by_cart.dart';
import 'package:e_commerce_app/view/ui/profillepage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controller/mainpage_controoler_provider.dart';
import 'bottomNavbar.dart';
import 'homepage.dart';
import 'serchpage.dart';

class MainPages extends StatelessWidget {
  MainPages({super.key});

  List<Widget> pageList =  [
    HomePage(),
    SerchPage(),
    Favori_Page(),
    Cart_Page(),
    ProfillePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Consumer<MainPageNotifier>(
      builder: (context, value, child) {
        return Scaffold(
          bottomNavigationBar: BottomNavBar(),
          backgroundColor: Color(0xffE2E2E2),
          body: pageList[value.pageIndex],
        );
      },
    );
  }
}


