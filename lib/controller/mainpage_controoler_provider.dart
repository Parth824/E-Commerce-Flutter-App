import 'package:e_commerce_app/model/mainpage_model.dart';
import 'package:flutter/material.dart';

class MainPageNotifier extends ChangeNotifier {
  MainPageModel mainPageModel = MainPageModel(indexPage: 0);

  int get pageIndex => mainPageModel.indexPage;

  set pageIndex(int newIndex) {
    mainPageModel.indexPage = newIndex;
    notifyListeners();
  }
}
