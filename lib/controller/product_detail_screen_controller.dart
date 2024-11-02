import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shoppingcart_api_/model/product_list_model.dart';

class ProductDetailScreenController with ChangeNotifier {
  ProductModel? productdetails;
  bool isLoading = false;
  getsingleproductdetails(String productId) async {
    final url = Uri.parse("https://fakestoreapi.com/products/$productId");
    isLoading = true;
    notifyListeners();
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        productdetails = singleproductModelFromJson(response.body);
      }
    } catch (e) {
      print(e);
    }
    isLoading = false;
    notifyListeners();
  }
}
