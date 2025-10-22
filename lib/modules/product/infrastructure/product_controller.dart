import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:productos/helpers/api_adapter.dart';
import '../models/product_model.dart';

class ProductController {

  static String baseURL = "https://686fdb184838f58d11232457.mockapi.io";

  final apiAdapter = ApiAdapter<ProductModel>(
    baseUrl: baseURL,
    endpoint: "product",
    model: ProductModel.empty(),
  );

  // Shorter method to get all products
  Future<List<ProductModel>> getProducts() => apiAdapter.getAll();

  static Future<bool> addProduct(ProductModel product) async {
    final api = await ApiAdapter<ProductModel>(baseUrl:  baseURL, endpoint: "product", model: ProductModel.empty());
    final response = await api.add(product);
    return response;
  }

  static Future<bool> updateProduct(ProductModel product) async {
    final api = await ApiAdapter<ProductModel>(baseUrl:  baseURL, endpoint: "product", model: ProductModel.empty());
    final response = await api.update(product.id, product);
    return response;
  }

  static Future<bool> deleteProduct(String id) async {

    final api = await ApiAdapter<ProductModel>(baseUrl:  baseURL, endpoint: "product", model: ProductModel.empty());
    final response = await api.delete(id);
    return response;
  }

  static Future<ProductModel> getProductById(String id) async {

    final api = await ApiAdapter<ProductModel>(baseUrl:  baseURL, endpoint: "product", model: ProductModel.empty());
    final response = await api.getById(id);
    return response;
  }
}

