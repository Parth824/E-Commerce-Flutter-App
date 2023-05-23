import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/controller/mainpage_controoler_provider.dart';
import 'package:e_commerce_app/controller/product_provider.dart';
import 'package:e_commerce_app/helper/helper_api.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'view/ui/mainpages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  await Hive.openBox('cart_box');
  await Hive.openBox('fav_box');
  DocumentSnapshot<Map<String, dynamic>> k =
      await FirebaseFirestore.instance.collection("count").doc("cou").get();
  ApiHelper.con = k['id'];
  print(ApiHelper.con);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MainPageNotifier(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProductNotifir(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getmen();
  }

  getmen() async {
    List m = [];
    List w = [];
    List ki = [];
    for (int i = 1; i <= 10; i++) {
      QuerySnapshot<Map<String, dynamic>> k = await FirebaseFirestore.instance
          .collection('men_shoes')
          .doc("$i")
          .collection("image")
          .get();
      m.add(k.docs);
    }
    ApiHelper.men = m;

    for (int i = 11; i <= 20; i++) {
      QuerySnapshot<Map<String, dynamic>> k = await FirebaseFirestore.instance
          .collection('kinds_shoes')
          .doc("$i")
          .collection("image")
          .get();
      w.add(k.docs);
    }
    ApiHelper.kidns = w;
    setState(() {});
    for (int i = 21; i <= 30; i++) {
      QuerySnapshot<Map<String, dynamic>> k = await FirebaseFirestore.instance
          .collection('women_shoes')
          .doc("$i")
          .collection("image")
          .get();
      ki.add(k.docs);
    }
    ApiHelper.women = ki;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPages(),
    );
  }
}
