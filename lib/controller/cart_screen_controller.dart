import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shoppingcart_api_/model/cart_model.dart';

class CartScreenController with ChangeNotifier {
  final cartbox = Hive.box<CartModel>("cartBox"); // hive step 3
  List keys = [];
  List<CartModel> cart = [];

  double totalcartAmount = 0;

  Future<void> addProduct(
      {required String name,
      String? image,
      String? desc,
      required int id,
      required double price}) async {
    //to check if the product is already in cart.
    bool isAlreadyinCart = false;

    for (int i = 0; i < cart.length; i++) {
      if (id == cart[i].id) {
        isAlreadyinCart = true;
      }
      print(isAlreadyinCart);
    }
//if the product is alresdy in cart
    if (isAlreadyinCart == true) {
      print("already in cart");
    } else {
      await cartbox.add(CartModel(
          name: name, id: id, image: image, desc: desc, price: price, qty: 1));
    }

    getProducts();
  }

  void getProducts() {
    keys = cartbox.keys.toList();
    cart = cartbox.values.toList();
    calculateTotalAmount();
    notifyListeners();
    debugPrint(keys.toString());
  }

  void removeproduct(int index) {
    cartbox.deleteAt(index);
    getProducts();
  }

  void incrementQty(int index) {
    keys[index];

    int currentQty = cart[index].qty ?? 1;
    currentQty++;
    log(currentQty.toString());
    cartbox.put(
        keys[index],
        CartModel(
            id: cart[index].id,
            desc: cart[index].desc,
            image: cart[index].image,
            name: cart[index].name,
            qty: currentQty,
            price: cart[index].price));
    getProducts();
  }

  void decrementQty(int index) {
    keys[index];

    int currentQty = cart[index].qty ?? 1;

    if (currentQty > 1) {
      currentQty--;
      log(currentQty.toString());
      cartbox.put(
          keys[index],
          CartModel(
              id: cart[index].id,
              desc: cart[index].desc,
              image: cart[index].image,
              name: cart[index].name,
              qty: currentQty,
              price: cart[index].price));
      getProducts();
    }
  }

  calculateTotalAmount() {
    totalcartAmount = 0;
    for (int i = 0; i < cart.length; i++) {
      totalcartAmount += (cart[i].price! * cart[i].qty!);
    }
    print(totalcartAmount);
    notifyListeners();
  }
}
