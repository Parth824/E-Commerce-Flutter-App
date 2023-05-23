import 'package:e_commerce_app/view/shard/appstyle.dart';
import 'package:flutter/material.dart';

class ChekoutButton extends StatelessWidget {
  const ChekoutButton({
    super.key, this.onTap, required this.lable,
  });
  final void Function()? onTap; 
  final String lable;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.
            black,
            borderRadius: BorderRadius.circular(12),
          ),
          height: 50,
          width: MediaQuery.of(context).size.width * 0.9,
          child: Center(
            child: Text(
              lable,
              style: appstyle(
                15,
                Colors.white,
                FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
