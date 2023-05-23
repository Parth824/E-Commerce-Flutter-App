import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/view/shard/appstyle.dart';
import 'package:e_commerce_app/view/ui/mainpages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hive/hive.dart';

import '../../model/constunst.dart';

class Favori_Page extends StatefulWidget {
  const Favori_Page({super.key});

  @override
  State<Favori_Page> createState() => _Favori_PageState();
}

class _Favori_PageState extends State<Favori_Page> {
  final _favBox = Hive.box('fav_box');

  _deleteFav(int key) async {
    await _favBox.delete(key);
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> fav = [];

    final favData = _favBox.keys.map((e) {
      final item = _favBox.get(e);

      return {
        "key": e,
        "id": item['id'],
        "name": item['name'],
        "category": item['category'],
        "price": item['price'],
        "imageUrl": item['imageUrl'],
      };
    }).toList();
    fav = favData.reversed.toList();

    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(16, 45, 0, 0),
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/top_image.png"),
                    fit: BoxFit.fill),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "My Favorites",
                  style: appstyle(25, Colors.white, FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: fav.length,
                itemBuilder: (context, index) {
                  final shoe = fav[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.14,
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: CachedNetworkImage(
                                    imageUrl: shoe['imageUrl'],
                                    height: 70,
                                    width: 70,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 12, left: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        shoe['name'],
                                        style: appstyle(
                                          14,
                                          Colors.black,
                                          FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        shoe['category'],
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "${shoe['price']}",
                                            style: appstyle(
                                              15,
                                              Colors.black,
                                              FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                  onTap: () {
                                    _deleteFav(shoe['key']);
                                    ids.removeWhere(
                                        (element) => element == shoe['id']);

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => MainPages(),
                                      ),
                                    );
                                  },
                                  child: Icon(Ionicons.md_heart_dislike)),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
