import 'package:e_commerce_app/model/constunst.dart';
import 'package:e_commerce_app/view/shard/appstyle.dart';
import 'package:e_commerce_app/view/ui/favorit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
// import 'package:ionicons/ionicons.dart';

class ProductCart extends StatefulWidget {
  const ProductCart(
      {super.key,
      required this.price,
      required this.id,
      required this.category,
      required this.name,
      required this.image});

  final String price;
  final String id;
  final String category;
  final String name;
  final String image;
  @override
  State<ProductCart> createState() => _ProductCartState();
}

class _ProductCartState extends State<ProductCart> {
  final _favBox = Hive.box('fav_box');

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

    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    bool selected = true;
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 20, 0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width * 0.6,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.white,
                spreadRadius: 1,
                blurRadius: 0.6,
                offset: Offset(1, 1),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.23,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(widget.image),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 10,
                    top: 10,
                    child: GestureDetector(
                      onTap: () {
                        if (ids.contains(widget.id)) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Favori_Page(),
                            ),
                          );
                        } else {
                          _creatFav({
                            "id": widget.id,
                            "name": widget.name,
                            "category": widget.category,
                            "price":widget.price,
                            "imageUrl":widget.image
                          });
                        }
                      },
                      child:(ids.contains(widget.id))? Icon(
                        AntDesign.heart
                      ): Icon(
                        AntDesign.hearto
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.name,
                      style: appstyleWithhight(
                          20, Colors.black, FontWeight.bold, 1.1),
                    ),
                    Text(
                      widget.category,
                      style: appstyleWithhight(
                          15, Colors.grey, FontWeight.bold, 1.1),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 0, right: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.price,
                            style: appstyleWithhight(
                                18, Colors.black, FontWeight.w600, 1.1),
                          ),
                          Row(
                            children: [
                              Text(
                                "Colors",
                                style: appstyle(
                                  15,
                                  Colors.grey,
                                  FontWeight.w500,
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              ChoiceChip(
                                label: Text(" "),
                                selected: selected,
                                visualDensity: VisualDensity.compact,
                                selectedColor: Colors.black,
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
