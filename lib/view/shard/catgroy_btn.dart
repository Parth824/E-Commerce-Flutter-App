import 'package:e_commerce_app/view/shard/appstyle.dart';
import 'package:flutter/material.dart';

class CatgaroyBtn extends StatelessWidget {
  const CatgaroyBtn({super.key, this.onPressed, required this.buttonClr, required this.lable});
  final void Function()? onPressed;
  final Color buttonClr;
  final String lable;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      child: Container(
        height: 40,
        width: MediaQuery.of(context).size.width * 0.244,
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: buttonClr,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.circular(7),
        ),
        child: Center(
          child: Text(
            lable,
            style: appstyle(
              14,
              buttonClr,
              FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
