import 'dart:convert';
import 'package:e_commerce_app/helper/helper_db.dart';
import 'package:flutter/services.dart';

class ApiHelper {
  ApiHelper._();

  static final ApiHelper apiHelper = ApiHelper._();
  static int a = 0;
  static int b = 1;
  static int c = 1;
  static int d = 0;
  static int g = 0;
  static int con = 0;

  static List men = [];
  static List women = [];
  static List kidns = [];

  Future<void> men_api() async {
    String res = await rootBundle.loadString("assets/json/men_shoes.json");

    if (res != null) {
      List data = json.decode(res);

      data.forEach((e) async {
        Map<String, dynamic> k = {
          "name": e['name'],
          "category": e['category'],
          "oldPrice": e['oldPrice'],
          "price": e['price'],
          "description": e['description'],
          "title": e['title'],
        };
        await DbHelper.dbHelper.insertDataMap(data: k, name: "men_shoes");
      });

      data.forEach((e) async {
        g = 0;
        e['imageUrl'].forEach((e) async {
          await DbHelper.dbHelper
              .intsertimage(data: {'image': e}, name: "men_shoes");
        });
        b++;
      });

      data.forEach((element) {
        d = 0;
        element['sizes'].forEach((e) async {
          await DbHelper.dbHelper.intsertsize(data: e, name: "men_shoes");
        });
        c++;
      });
    }
  }

  Future<void> kids_api() async {
    String res = await rootBundle.loadString("assets/json/kids_shoes.json");

    if (res != null) {
      List data = json.decode(res);

      data.forEach((e) async {
        Map<String, dynamic> k = {
          "name": e['name'],
          "category": e['category'],
          "oldPrice": e['oldPrice'],
          "price": e['price'],
          "description": e['description'],
          "title": e['title'],
        };
        await DbHelper.dbHelper.insertDataMap(data: k, name: "kinds_shoes");
      });

      data.forEach((e) async {
        g = 0;
        e['imageUrl'].forEach((e) async {
          await DbHelper.dbHelper
              .intsertimage(data: {'image': e}, name: "kinds_shoes");
        });
        b++;
      });

      data.forEach((element) {
        d = 0;
        element['sizes'].forEach((e) async {
          await DbHelper.dbHelper.intsertsize(data: e, name: "kinds_shoes");
        });
        c++;
      });
    }
  }

  Future<void> women_api() async {
    String res = await rootBundle.loadString("assets/json/women_shoes.json");

    if (res != null) {
      List data = json.decode(res);

      data.forEach((e) async {
        Map<String, dynamic> k = {
          "name": e['name'],
          "category": e['category'],
          "oldPrice": e['oldPrice'],
          "price": e['price'],
          "description": e['description'],
          "title": e['title'],
        };
        await DbHelper.dbHelper.insertDataMap(data: k, name: "women_shoes");
      });

      data.forEach((e) async {
        g = 0;
        e['imageUrl'].forEach((e) async {
          await DbHelper.dbHelper
              .intsertimage(data: {'image': e}, name: "women_shoes");
        });
        b++;
      });

      data.forEach((element) {
        d = 0;
        element['sizes'].forEach((e) async {
          await DbHelper.dbHelper.intsertsize(data: e, name: "women_shoes");
        });
        c++;
      });
    }
  }
}
