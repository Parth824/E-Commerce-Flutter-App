import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/controller/product_provider.dart';
import 'package:e_commerce_app/view/shard/appstyle.dart';
import 'package:e_commerce_app/view/ui/favorit.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../model/constunst.dart';
import '../shard/check_out_button.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key, required this.name, required this.id});

  final String name;
  final String id;
  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  PageController pageController = PageController();
  final _cartBox = Hive.box('cart_box');
  final _favBox = Hive.box('fav_box');

  String? image;

  Future<void> _createCart(Map<String, dynamic> newCart) async {
    await _cartBox.add(newCart);
  }

  Future<void> _creatFav(Map<String, dynamic> addFav) async {
    await _favBox.add(addFav);
    getfavorites();
  }

  getfavorites() {
    final favData = _favBox.keys.map((e) {
      final item = _favBox.get(e);
      return {
        'key': e,
        'id': item['id'],
      };
    }).toList();

    favor = favData.toList();
    ids = favor.map((e) => e['id']).toList();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(widget.name)
            .doc(widget.id)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("${snapshot.error}"),
            );
          } else if (snapshot.hasData) {
            DocumentSnapshot<Map<String, dynamic>>? data = snapshot.data;
            return Consumer<ProductNotifir>(
              builder: (context, value, child) {
                return CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      automaticallyImplyLeading: false,
                      leadingWidth: 0,
                      title: Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                                value.shoeSizes.clear();
                              },
                              child: Icon(
                                Ionicons.close,
                                color: Colors.black,
                              ),
                            ),
                            GestureDetector(
                              onTap: null,
                              child: Icon(
                                Ionicons.ellipsis_horizontal,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      pinned: true,
                      snap: false,
                      floating: true,
                      backgroundColor: Colors.transparent,
                      expandedHeight: MediaQuery.of(context).size.height,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Stack(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.5,
                              width: MediaQuery.of(context).size.width,
                              child: StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection(widget.name)
                                    .doc(widget.id)
                                    .collection('image')
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasError) {
                                    return Center(
                                      child: Text("${snapshot.error}"),
                                    );
                                  } else if (snapshot.hasData) {
                                    QuerySnapshot<Map<String, dynamic>>? k =
                                        snapshot.data;
                                    List<
                                            QueryDocumentSnapshot<
                                                Map<String, dynamic>>> data1 =
                                        k!.docs;
                                    image = data1[0]['image'];
                                    return PageView.builder(
                                      controller: pageController,
                                      itemCount: data1.length,
                                      onPageChanged: (val) {
                                        value.activepage = val;
                                      },
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        return Stack(
                                          children: [
                                            Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.39,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              color: Colors.grey.shade300,
                                              child: CachedNetworkImage(
                                                imageUrl: data1[index]['image'],
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                            Positioned(
                                              top: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.1,
                                              right: 20,
                                              child: GestureDetector(
                                                onTap: () {
                                                  if (ids.contains(widget.id)) {
                                                    Navigator.of(context)
                                                        .push(MaterialPageRoute(
                                                      builder: (context) =>
                                                          Favori_Page(),
                                                    ));
                                                  } else {
                                                    _creatFav({
                                                      "id": data!.id,
                                                      "name": data['name'],
                                                      "category":
                                                          data['catgory'],
                                                      "price": data['price'],
                                                      "imageUrl": data1[0]
                                                          ['image'],
                                                    });
                                                  }
                                                },
                                                child: ids.contains(data!.id)? Icon(
                                                  Ionicons.heart,
                                                  color: Colors.grey,
                                                ):Icon(
                                                  Ionicons.heart_circle_outline,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              bottom: 0,
                                              left: 0,
                                              right: 0,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.3,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: List<Widget>.generate(
                                                  data1.length,
                                                  (index) => Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 4),
                                                    child: CircleAvatar(
                                                      radius: 5,
                                                      backgroundColor:
                                                          value.activepage !=
                                                                  index
                                                              ? Colors.grey
                                                              : Colors.black,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
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
                            Positioned(
                              bottom: 20,
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30),
                                ),
                                child: Container(
                                  height: MediaQuery.of(context).size.height *
                                      0.645,
                                  width: MediaQuery.of(context).size.width,
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          data!['name'],
                                          style: appstyle(25, Colors.black,
                                              FontWeight.bold),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              data['category'],
                                              style: appstyle(
                                                15,
                                                Colors.grey,
                                                FontWeight.w500,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 15,
                                            ),
                                            RatingBar.builder(
                                              initialRating: 4,
                                              minRating: 1,
                                              direction: Axis.horizontal,
                                              allowHalfRating: true,
                                              itemCount: 5,
                                              itemSize: 22,
                                              itemPadding: EdgeInsets.symmetric(
                                                  horizontal: 1),
                                              itemBuilder: (context, index) {
                                                return Icon(
                                                  Icons.star,
                                                  size: 15,
                                                  color: Colors.black,
                                                );
                                              },
                                              onRatingUpdate: (value) {},
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "\$${data['price']}",
                                              style: appstyle(
                                                20,
                                                Colors.black,
                                                FontWeight.w600,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "Colors",
                                                  style: appstyle(
                                                    15,
                                                    Colors.black,
                                                    FontWeight.w500,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                CircleAvatar(
                                                  radius: 7,
                                                  backgroundColor: Colors.black,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                CircleAvatar(
                                                  radius: 7,
                                                  backgroundColor: Colors.red,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Column(
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "Select Sizes",
                                                  style: appstyle(
                                                    15,
                                                    Colors.black,
                                                    FontWeight.w600,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 15,
                                                ),
                                                Text(
                                                  "View size guide",
                                                  style: appstyle(
                                                    15,
                                                    Colors.grey,
                                                    FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            SizedBox(
                                              height: 40,
                                              child: ListView.builder(
                                                itemCount:
                                                    value.shoeSizes.length,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                padding: EdgeInsets.zero,
                                                itemBuilder: (context, index) {
                                                  return Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 8),
                                                    child: ChoiceChip(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(100),
                                                        side: BorderSide(
                                                          color: Colors.black,
                                                          width: 1,
                                                          style:
                                                              BorderStyle.solid,
                                                        ),
                                                      ),
                                                      label: Text(
                                                        value.shoeSizes[index]
                                                            ['size'],
                                                        style: appstyle(
                                                          14,
                                                          value.shoeSizes[index]
                                                                  ['isSelected']
                                                              ? Colors.white
                                                              : Colors.black38,
                                                          FontWeight.w500,
                                                        ),
                                                      ),
                                                      selectedColor:
                                                          Colors.black,
                                                      // disabledColor: Colors.white,
                                                      selected:
                                                          value.shoeSizes[index]
                                                              ['isSelected'],
                                                      onSelected: (newvalue) {
                                                        if (value.sizes
                                                            .contains(
                                                          value.shoeSizes[index]
                                                              ['size'],
                                                        )) {
                                                          value.sizes.remove(
                                                              value.shoeSizes[
                                                                      index]
                                                                  ['size']);
                                                        } else {
                                                          value.sizes.add(value
                                                                  .shoeSizes[
                                                              index]['size']);
                                                        }

                                                        print(value.sizes);
                                                        value
                                                            .toggleCheck(index);
                                                      },
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Divider(
                                          indent: 10,
                                          endIndent: 10,
                                          color: Colors.black,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.8,
                                          child: Text(
                                            data['title'],
                                            style: appstyle(
                                              15,
                                              Colors.black,
                                              FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          data['description'],
                                          textAlign: TextAlign.justify,
                                          maxLines: 4,
                                          style: appstyle(12, Colors.black,
                                              FontWeight.normal),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Padding(
                                            padding: EdgeInsets.only(top: 12),
                                            child: ChekoutButton(
                                              onTap: () async {
                                                print(value.size);
                                                await _createCart({
                                                  'id': data.id,
                                                  'name': data['name'],
                                                  'sizes': value.size[0],
                                                  'category': data['category'],
                                                  'imageUrl': image,
                                                  'price': data['price'],
                                                  'qty': 1,
                                                });
                                                value.sizes.clear();
                                                Navigator.pop(context);
                                              },
                                              lable: "Add to Cart",
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          }
          return Center(
            child: CircleAvatar(),
          );
        },
      ),
    );
  }
}
