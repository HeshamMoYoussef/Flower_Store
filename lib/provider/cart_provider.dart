import 'package:flower_app/shared/item.dart';
import 'package:flutter/material.dart';

class Cart with ChangeNotifier {
  // create new properties & methods

  List selectedProducts = [];
  int price = 0;

  add(Item product) {
    selectedProducts.add(product);
    price += product.price.round();
    notifyListeners();
  }

  delete(Item product) {
    selectedProducts.remove(product);
    price -= product.price.round();
    notifyListeners();
  }

  get itemCount {
    return selectedProducts.length;
  }

  // use " notifyListeners(); " at the end of every method
}
