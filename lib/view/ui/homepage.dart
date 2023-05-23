import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/helper/helper_api.dart';
import 'package:e_commerce_app/view/shard/appstyle.dart';
import 'package:e_commerce_app/view/shard/home_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final TabController tabController =
      TabController(length: 3, vsync: this);

  List<QueryDocumentSnapshot<Map<String, dynamic>>>? get;
  @override
  void initState() {
    // TODO: implement initState
    getdata();
  }

  getdata() async {
    print(ApiHelper.con);
    if (ApiHelper.con == 0) {
      await ApiHelper.apiHelper.men_api();
      await ApiHelper.apiHelper.kids_api();
      await ApiHelper.apiHelper.women_api();
    }

    await FirebaseFirestore.instance
        .collection("count")
        .doc("cou")
        .set({"id": 1});
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE2E2E2),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(16, 45, 0, 0),
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/desing.png"),
                    fit: BoxFit.fill),
              ),
              child: Container(
                padding: EdgeInsets.only(left: 8, bottom: 15),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Athlestics Shoes",
                      style: appstyleWithhight(
                          30, Colors.white, FontWeight.bold, 1.5),
                    ),
                    Text(
                      "Collection",
                      style: appstyleWithhight(
                          30, Colors.white, FontWeight.bold, 1.2),
                    ),
                    TabBar(
                      padding: EdgeInsets.zero,
                      indicatorSize: TabBarIndicatorSize.label,
                      indicatorColor: Colors.transparent,
                      isScrollable: true,
                      labelColor: Colors.white,
                      controller: tabController,
                      labelStyle: appstyle(20, Colors.white, FontWeight.bold),
                      unselectedLabelColor: Colors.grey.withOpacity(0.3),
                      tabs: [
                        Tab(
                          text: "Men Shoes",
                        ),
                        Tab(
                          text: "Women Shoes",
                        ),
                        Tab(
                          text: "Kids Shoes",
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.265,
              ),
              child: Container(
                padding: EdgeInsets.only(left: 12),
                child: TabBarView(
                  controller: tabController,
                  children: [
                    Home_Widget(men: ApiHelper.men, name: "men_shoes",tabInexd: 0),
                    Home_Widget(men: ApiHelper.women, name: "women_shoes",tabInexd: 1),
                    Home_Widget(men: ApiHelper.kidns, name: "kinds_shoes",tabInexd: 2),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
