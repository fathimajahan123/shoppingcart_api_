import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shoppingcart_api_/model/product_list_model.dart';

class HomeScreenController with ChangeNotifier {
  int selectedcategoryIndex = 0;
  bool isLoading = false;
  bool isproductsLoading = false;
  List categorylist = ["All"];
  List<ProductModel> listofproducts = [];

  Future<void> getCategories() async {
    categorylist = ["All"];
    isLoading = true;

    notifyListeners();
    final url = Uri.parse("https://fakestoreapi.com/products/categories");

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        categorylist.addAll(jsonDecode(response.body));
      }
    } catch (e) {
      print(e);
    }
    isLoading = false;
    notifyListeners();
  }

  void onCategorySelection(int index) {
    selectedcategoryIndex = index;
    notifyListeners();
    if (selectedcategoryIndex == 0) {
      getAllproducts();
    } else {
      getProductsBycategory(categorylist[selectedcategoryIndex]);
    }
  }

  Future<void> getAllproducts() async {
    isproductsLoading = true;
    notifyListeners();
    final url = Uri.parse("https://fakestoreapi.com/products");
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        listofproducts = productModelFromJson(response.body);
      }
    } catch (e) {
      print(e);
    }
    isproductsLoading = false;
    notifyListeners();
  }

  Future<void> getProductsBycategory(String category) async {
    isproductsLoading = true;
    notifyListeners();
    final url =
        Uri.parse("https://fakestoreapi.com/products/category/$category");
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        listofproducts = productModelFromJson(response.body);
      }
    } catch (e) {
      print(e);
    }
    isproductsLoading = false;
    notifyListeners();
  }
}
