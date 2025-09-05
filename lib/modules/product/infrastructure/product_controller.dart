import 'dart:convert';

import 'package:http/http.dart' as http;
import '../models/product_model.dart';

class ProductController {

  static String baseURL = "https://686fdb184838f58d11232457.mockapi.io";

  static Future<List<ProductModel>> getProducts() async {
    final response = await http.get(Uri.parse('$baseURL/product'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map((json) => ProductModel.fromJson(json)).toList().take(10).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  static Future<bool> addProduct(ProductModel product) async {
    final response = await http.post(
      Uri.parse('$baseURL/product'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(product.toJson(product)),
    );

    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> updateProduct(ProductModel product) async {
    final response = await http.put(
      Uri.parse('$baseURL/product/${product.id}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(product.toJson(product)),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> deleteProduct(String id) async {
    final response = await http.delete(
      Uri.parse('$baseURL/product/$id'),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<ProductModel> getProductById(String id) async {
    final response = await http.get(Uri.parse('$baseURL/product/$id'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      return ProductModel.fromJson(jsonData);
    } else {
      throw Exception('Failed to load product');
    }
  }
}

