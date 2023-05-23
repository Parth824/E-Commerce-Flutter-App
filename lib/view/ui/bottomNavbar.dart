import 'package:e_commerce_app/controller/mainpage_controoler_provider.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

import '../shard/bottom_navigation_bar.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<MainPageNotifier>(
      builder: (context, value, child) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: EdgeInsets.all(12),
              margin: EdgeInsets.symmetric(
                horizontal: 10,
              ),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BottomNaWigets(
                    icon: (value.mainPageModel.indexPage == 0)
                        ? Ionicons.home
                        : Ionicons.home_outline,
                    onTap: () {
                      value.pageIndex = 0;
                    },
                  ),
                  BottomNaWigets(
                    icon: (value.mainPageModel.indexPage == 1)
                        ? Ionicons.search
                        : Ionicons.search,
                    onTap: () {
                      value.pageIndex = 1;
                    },
                  ),
                  BottomNaWigets(
                    icon: (value.mainPageModel.indexPage == 2)
                        ? Ionicons.heart
                        : Ionicons.heart_circle_outline,
                    onTap: () {
                      value.pageIndex = 2;
                    },
                  ),
                  BottomNaWigets(
                    icon: (value.mainPageModel.indexPage == 3)
                        ? Ionicons.cart
                        : Ionicons.cart_outline,
                    onTap: () {
                      value.pageIndex = 3;
                    },
                  ),
                  BottomNaWigets(
                    icon: (value.mainPageModel.indexPage == 4)
                        ? Ionicons.person
                        : Ionicons.person_outline,
                    onTap: () {
                      value.pageIndex = 4;
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
