import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/view/shard/appstyle.dart';
import 'package:e_commerce_app/view/shard/check_out_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hive/hive.dart';
// import 'package:ionicons/ionicons.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class Cart_Page extends StatefulWidget {
  @override
  State<Cart_Page> createState() => _Cart_PageState();
}

class _Cart_PageState extends State<Cart_Page> {
  final _cartBox = Hive.box('cart_box');

  @override
  Widget build(BuildContext context) {
    List<dynamic> cart = [];
    final CartData = _cartBox.keys.map((e) {
      final item = _cartBox.get(e);
      print(item);
      return {
        "key": e,
        'id': item['id'],
        'name': item['name'],
        'sizes': item['sizes'],
        'category': item['category'],
        'imageUrl': item['imageUrl'],
        'price': item['price'],
        'qty': item['qty'],
      };
    }).toList();

    cart = CartData.reversed.toList();
    print(cart);
    return Scaffold(
      backgroundColor: Color(0xffE2E2E2),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Ionicons.close,
                    color: Colors.black,
                  ),
                ),
                Text(
                  "My Cart",
                  style: appstyle(
                    25,
                    Colors.black,
                    FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.65,
                  child: ListView.builder(
                    itemCount: cart.length,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      Map data = cart[index];
                      return Padding(
                        padding: EdgeInsets.all(8),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Slidable(
                            key: ValueKey(0),
                            endActionPane: ActionPane(
                              motion: ScrollMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: doNothing,
                                  flex: 1,
                                  backgroundColor: Color(0xff000000),
                                  foregroundColor: Colors.white,
                                  icon: Icons.delete,
                                  label: 'Delete',
                                )
                              ],
                            ),
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.13,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade500,
                                    spreadRadius: 5,
                                    blurRadius: 0.3,
                                    offset: Offset(0, 1),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(12),
                                        child: CachedNetworkImage(
                                          imageUrl: data['imageUrl'],
                                          width: 70,
                                          height: 70,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(top: 12, left: 20),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              data['name'],
                                              style: appstyle(
                                                13,
                                                Colors.black,
                                                FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              data['category'],
                                              style: appstyle(
                                                12,
                                                Colors.grey,
                                                FontWeight.w600,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  data['price'],
                                                  style: appstyle(
                                                    14,
                                                    Colors.black,
                                                    FontWeight.w600,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 15,
                                                ),
                                                Text(
                                                  "Sizes",
                                                  style: appstyle(
                                                      14,
                                                      Colors.grey,
                                                      FontWeight.w600),
                                                ),
                                                SizedBox(
                                                  width: 7,
                                                ),
                                                Text(
                                                  data['sizes'],
                                                  style: appstyle(
                                                      14,
                                                      Colors.grey,
                                                      FontWeight.w600),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(8),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              InkWell(
                                                onTap: () {},
                                                child: Icon(
                                                  AntDesign.minussquare,
                                                  size: 20,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              Text(
                                                data['qty'].toString(),
                                                style: appstyle(
                                                  10,
                                                  Colors.black,
                                                  FontWeight.w600,
                                                ),
                                              ),
                                              Icon(
                                                AntDesign.plussquare,
                                                size: 20,
                                                color: Colors.black,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: ChekoutButton(
                lable: "Proceed to Checkout",
              ),
            ),
          ],
        ),
      ),
    );
  }

  void doNothing(BuildContext context) {}
}
