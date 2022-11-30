import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/product.dart';

const String authority = 'fakestoreapi.com';

class ProductRepository {
  ProductRepository._();
  static final ProductRepository _instance = ProductRepository._();
  static ProductRepository get instance => _instance;

  Future<List<Product>> getProducts() async {
    try {
      Uri url = Uri.https(authority, '/products');
      final http.Response response = await http.get(url);
      final List jsonData = jsonDecode(response.body);
      final products = jsonData.map((json) => Product.fromJson(json)).toList();

      return products;
    } catch (e) {
      rethrow;
    }
  }

  Future<Product> getProduct(int id) async {
    try {
      Uri url = Uri.https(authority, '/products/$id');
      final http.Response response = await http.get(url);
      final jsonData = jsonDecode(response.body);
      final product = Product.fromJson(jsonData);

      return product;
    } catch (e) {
      rethrow;
    }
  }
}
