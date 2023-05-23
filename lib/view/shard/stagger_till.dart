import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/view/shard/appstyle.dart';
import 'package:flutter/material.dart';

class StaggerTile extends StatefulWidget {
  const StaggerTile({super.key, required this.imageuri, required this.name, required this.price});

  final String imageuri;
  final String name;
  final String price;

  @override
  State<StaggerTile> createState() => _StaggerTileState();
}

class _StaggerTileState extends State<StaggerTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              imageUrl: widget.imageuri,
              fit: BoxFit.fill,
            ),
            Container(
              height:73,
                padding: EdgeInsets.only(top: 12), 
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.name,
                      style: appstyleWithhight(17, Colors.black, FontWeight.w700,1),
                    ),
                    Text(
                      widget.price,
                      style: appstyleWithhight(13, Colors.black, FontWeight.w700,1),
                    ),
                  ],
                ),
              
            ),
          ],
        ),
      ),
    );
  }
}
