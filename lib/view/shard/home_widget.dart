import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/controller/product_provider.dart';
import 'package:e_commerce_app/view/shard/produtcart.dart';
import 'package:e_commerce_app/view/ui/product_by_cart.dart';
import 'package:e_commerce_app/view/ui/product_page.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

import 'appstyle.dart';
import 'new_shoes.dart';

class Home_Widget extends StatelessWidget {
  const Home_Widget({
    super.key,
    required this.men,
    required this.name,
    required this.tabInexd,
  });

  final List men;
  final String name;
  final int tabInexd;

  @override
  Widget build(BuildContext context) {
    var productNotifier = Provider.of<ProductNotifir>(context);
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.405,
          child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection("$name").snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text("${snapshot.error}"),
                );
              } else if (snapshot.hasData) {
                QuerySnapshot<Map<String, dynamic>>? data = snapshot.data;
                List<QueryDocumentSnapshot<Map<String, dynamic>>> data1 =
                    data!.docs;
                return ListView.builder(
                  itemCount: data1.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () async {
                        QuerySnapshot<Map<String, dynamic>> k =
                            await FirebaseFirestore.instance
                                .collection("$name")
                                .doc(data1[index].id)
                                .collection('size')
                                .get();

                        for (int i = 0; i < k.docs.length; i++) {
                          Map m = {
                            "size": k.docs[i]['size'],
                            "isSelected": k.docs[i]['isSelected']
                          };

                          productNotifier.shoeSizes.add(m);
                        }
                        print(productNotifier.shoeSizes);
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                ProductPage(name: name, id: data1[index].id),
                          ),
                        );
                      },
                      child: ProductCart(
                        price: "\$${data1[index]['price']}",
                        category: data1[index]['category'],
                        id: data1[index].id,
                        image: (men.isNotEmpty)
                            ? men[index][0]['image']
                            : "https://d326fntlu7tb1e.cloudfront.net/uploads/d60aca33-909b-4df7-9ad7-b75039438e29-GX1398_a1.webp",
                        name: data1[index]['name'],
                      ),
                    );
                  },
                );
              }
              return Center(
                child: CircleAvatar(),
              );
            },
          ),
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 20, 12, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Latest Shoes",
                    style: appstyle(20, Colors.black, FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              Product_By_Cart(tabInexd: tabInexd),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        Text(
                          "Show All",
                          style: appstyle(19, Colors.black, FontWeight.w500),
                        ),
                        Icon(
                          Ionicons.caret_forward,
                          size: 20,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.125,
          child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection("$name").snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text("${snapshot.error}"),
                );
              } else if (snapshot.hasData) {
                QuerySnapshot<Map<String, dynamic>>? data = snapshot.data;
                List<QueryDocumentSnapshot<Map<String, dynamic>>> data1 =
                    data!.docs;
                return ListView.builder(
                  itemCount: data1.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: NewShoes(
                          imageurl: (men.isNotEmpty)
                              ? men[index][0]['image']
                              : "https://d326fntlu7tb1e.cloudfront.net/uploads/d60aca33-909b-4df7-9ad7-b75039438e29-GX1398_a1.webp"),
                    );
                  },
                );
              }
              return Center(
                child: CircleAvatar(),
              );
            },
          ),
        ),
      ],
    );
  }
}
