import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/category_model.dart';
import '../models/product_model.dart';
import '../../../../core/error/exceptions.dart';

abstract class ProductRemoteDataSource {
  Future<List<CategoryModel>> fetchCategories();
  Future<List<ProductModel>> fetchProductsByCategory(String category);
  Future<ProductModel> fetchProductDetails(int id);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  static const String baseUrl = 'https://fakestoreapi.com';

  @override
  Future<List<CategoryModel>> fetchCategories() async {
    final response = await http.get(Uri.parse('$baseUrl/products/categories'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => CategoryModel.fromJson({'name': json})).toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<ProductModel>> fetchProductsByCategory(String category) async {
    final response = await http.get(Uri.parse('$baseUrl/products/category/$category'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => ProductModel.fromJson(json)).toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<ProductModel> fetchProductDetails(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/products/$id'));
    if (response.statusCode == 200) {
      return ProductModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}