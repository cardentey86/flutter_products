import 'dart:convert';
import 'package:http/http.dart' as http;
import 'base_model.dart';

class ApiAdapter<T extends BaseModel<T>> {
  final String baseUrl;
  final String endpoint;
  final T? model;

  ApiAdapter({
    required this.baseUrl,
    required this.endpoint,
    this.model,
  });

  Uri _buildUri([String? path]) {
    return Uri.parse('$baseUrl/$endpoint${path != null ? '/$path' : ''}');
  }

  Future<List<T>> getAll() async {
    final response = await http.get(_buildUri());

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map((item) => model!.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load $endpoint');
    }
  }

  Future<T> getById(String id) async {
    final response = await http.get(_buildUri(id));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      return model!.fromJson(jsonData);
    } else {
      throw Exception('Failed to load item with id $id');
    }
  }

  Future<bool> add(T item) async {
    final response = await http.post(
      _buildUri(),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(item.toJson()),
    );
    return response.statusCode == 201;
  }

  Future<bool> update(String id, T item) async {
    final response = await http.put(
      _buildUri(id),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(item.toJson()),
    );
    return response.statusCode == 200;
  }

  Future<bool> delete(String id) async {
    final response = await http.delete(_buildUri(id));
    return response.statusCode == 200;
  }
}
