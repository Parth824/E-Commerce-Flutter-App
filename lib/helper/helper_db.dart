import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/helper/helper_api.dart';

class DbHelper {
  DbHelper._();

  static final DbHelper dbHelper = DbHelper._();

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<void> insertDataMap({required Map<String, dynamic> data,required String name}) async {
    await firebaseFirestore
        .collection("$name")
        .doc("${ApiHelper.a = ApiHelper.a + 1}")
        .set(data);
  }

  Future<void> intsertimage({required Map<String, dynamic> data,required String name}) async {
    await firebaseFirestore
        .collection("$name")
        .doc("${ApiHelper.b }")
        .collection("image")
        .doc("${ApiHelper.g = ApiHelper.g+1}")
        .set(data);
  }
  Future<void> intsertsize({required Map<String, dynamic> data,required String name}) async {
    await firebaseFirestore
        .collection("$name")
        .doc("${ApiHelper.c}")
        .collection("size")
        .doc("${ApiHelper.d = ApiHelper.d+1}")
        .set(data);
  }
}
