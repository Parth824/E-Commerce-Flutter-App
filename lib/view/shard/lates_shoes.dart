import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/view/shard/stagger_till.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';


class letastShoes extends StatelessWidget {
  const letastShoes({
    super.key, required this.men, required this.name,
  });
  final List men;
  final String name;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("$name").snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text("${snapshot.error}"),
          );
        } else if (snapshot.hasData) {
          QuerySnapshot<Map<String, dynamic>>? data = snapshot.data;
          List<QueryDocumentSnapshot<Map<String, dynamic>>> data1 = data!.docs;
          return StaggeredGridView.countBuilder(
            crossAxisCount: 2,
            padding: EdgeInsets.zero,
            crossAxisSpacing: 20,
            mainAxisSpacing: 16,
            itemCount: data1.length,
            scrollDirection: Axis.vertical,
            staggeredTileBuilder: (index) => StaggeredTile.extent(
              (index % 2 == 0) ? 1 : 1,
              (index % 4 == 1 || index % 4 == 3)
                  ? MediaQuery.of(context).size.height * 0.35
                  : MediaQuery.of(context).size.height * 0.31,
            ),
            itemBuilder: (context, index) {
              return StaggerTile(
                imageuri: (men.isNotEmpty)
                    ? men[index][0]['image']
                    : "https://d326fntlu7tb1e.cloudfront.net/uploads/710d020f-2da8-4e9e-8cff-0c8f24581488-GV6674.webp",
                name: data1[index]['name'],
                price: "\$${data1[index]['price']}",
              );
            },
          );
        }
        return Center(
          child: CircleAvatar(),
        );
      },
    );
  }
}