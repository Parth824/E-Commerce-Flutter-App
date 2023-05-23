import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/helper/helper_api.dart';
import 'package:e_commerce_app/view/shard/appstyle.dart';
import 'package:e_commerce_app/view/shard/catgroy_btn.dart';
import 'package:e_commerce_app/view/shard/custem_spceser.dart';
import 'package:e_commerce_app/view/shard/lates_shoes.dart';
import 'package:e_commerce_app/view/shard/stagger_till.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:ionicons/ionicons.dart';

class Product_By_Cart extends StatefulWidget {
  const Product_By_Cart({super.key, required this.tabInexd});
  final int tabInexd;
  @override
  State<Product_By_Cart> createState() => _Product_By_CartState();
}

class _Product_By_CartState extends State<Product_By_Cart>
    with TickerProviderStateMixin {
  late final TabController tabController =
      TabController(length: 3, vsync: this);

  List brand = [
    "assets/images/adidas.png",
    "assets/images/gucci.png",
    "assets/images/jordan.png",
    "assets/images/nike.png",
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController.animateTo(widget.tabInexd);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE2E2E2),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(16, 45, 0, 0),
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/desing.png"),
                    fit: BoxFit.fill),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(6, 12, 16, 18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Icon(
                            Ionicons.close,
                            color: Colors.white,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            filter();
                          },
                          child: Icon(
                            Ionicons.filter,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  TabBar(
                    padding: EdgeInsets.zero,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorColor: Colors.transparent,
                    isScrollable: true,
                    labelColor: Colors.white,
                    controller: tabController,
                    labelStyle: appstyle(20, Colors.white, FontWeight.bold),
                    unselectedLabelColor: Colors.grey.withOpacity(0.3),
                    tabs: [
                      Tab(
                        text: "Men Shoes",
                      ),
                      Tab(
                        text: "Women Shoes",
                      ),
                      Tab(
                        text: "Kidns Shoes",
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.2,
                  left: 16,
                  right: 12),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: TabBarView(
                  controller: tabController,
                  children: [
                    letastShoes(men: ApiHelper.men, name: "men_shoes"),
                    letastShoes(men: ApiHelper.women, name: "women_shoes"),
                    letastShoes(men: ApiHelper.kidns, name: "kinds_shoes"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future filter() {
    double _value = 100;
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.white54,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.85,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 8,
              ),
              Container(
                height: 5,
                width: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black38,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
                child: Column(
                  children: [
                    CustemSpcer(),
                    Text(
                      "Filter",
                      style: appstyle(
                        25,
                        Colors.black,
                        FontWeight.bold,
                      ),
                    ),
                    CustemSpcer(),
                    Text(
                      "Gender",
                      style: appstyle(18, Colors.black, FontWeight.bold),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        CatgaroyBtn(
                          buttonClr: Colors.black,
                          lable: "Men",
                        ),
                        CatgaroyBtn(
                          buttonClr: Colors.grey,
                          lable: "Women",
                        ),
                        CatgaroyBtn(
                          buttonClr: Colors.grey,
                          lable: "Kids",
                        ),
                      ],
                    ),
                    CustemSpcer(),
                    Text(
                      "Category",
                      style: appstyle(
                        15,
                        Colors.black,
                        FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        CatgaroyBtn(
                          buttonClr: Colors.black,
                          lable: "Shoes",
                        ),
                        CatgaroyBtn(
                          buttonClr: Colors.grey,
                          lable: "Apparrels",
                        ),
                        CatgaroyBtn(
                          buttonClr: Colors.grey,
                          lable: "Accessories",
                        ),
                      ],
                    ),
                    CustemSpcer(),
                    Slider(
                      value: _value,
                      divisions: 50,
                      max: 500,
                      thumbColor: Colors.black,
                      inactiveColor: Colors.grey,
                      activeColor: Colors.black,
                      label: _value.toString(),
                      secondaryTrackValue: 200,
                      onChanged: (val) {},
                    ),
                    CustemSpcer(),
                    Text(
                      "Brand",
                      style: appstyle(16, Colors.black, FontWeight.bold),
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      height: 100,
                      // color: Colors.amber,
                      child: ListView.builder(
                        itemCount: brand.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Image.asset(
                                brand[index],
                                height: 60,
                                width: 80,
                                color: Colors.black,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
