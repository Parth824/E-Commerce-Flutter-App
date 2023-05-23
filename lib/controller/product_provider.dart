import 'package:flutter/material.dart';

class ProductNotifir extends ChangeNotifier {
  int _activepage = 0;
  List shoesSizes = [];
  List<String> sizes = [];

  List get shoeSizes => shoesSizes;
  set shoesSize(List newSizes) {
    shoesSizes = newSizes;
    notifyListeners();
  }

  int get activepage => _activepage;

  set activepage(int newIndex) {
    _activepage = newIndex;
    notifyListeners();
  }

  void toggleCheck(int index) {
    for (int i = 0; i < shoesSizes.length; i++) {
      if (i == index) {
        shoesSizes[i]['isSelected'] = !shoesSizes[i]['isSelected'];
      }
    }
    notifyListeners();
  }

  List<String> get size => sizes;

  set size(List<String> newsize) {
    sizes = newsize;
    notifyListeners();
  }
}
