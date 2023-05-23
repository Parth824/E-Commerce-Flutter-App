import 'package:flutter/material.dart';

import '../shard/appstyle.dart';

class ProfillePage extends StatefulWidget {
  const ProfillePage({super.key});

  @override
  State<ProfillePage> createState() => _ProfillePageState();
}

class _ProfillePageState extends State<ProfillePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "ProFile Page",
          style: appstyle(
            40,
            Colors.black,
            FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
