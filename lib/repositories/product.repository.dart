import 'package:dio/dio.dart';
import 'package:klontong/models/product.model.dart';

class ProductRepository {
  final Dio dio = Dio();
  final String baseUrl =
      "https://crudcrud.com/api/bae8ffe295af4a8390d4fd951c3f4ace/products";

  Future<void> addProduct(Product product) async {
    await dio.post(baseUrl, data: product.toJson());
  }

  Future<void> deleteProduct(String id) async {
    print('Deleting product with id: $id');
    await dio.delete('$baseUrl/$id');
  }

  Future<List<Product>> fetchProducts({int page = 1}) async {
    final response = await dio.get(baseUrl);
    if (response.statusCode == 200) {
      return (response.data as List).map((e) => Product.fromJson(e)).toList();
    } else {
      throw Exception("Failed to fetch products");
    }
  }

  Future<void> updateProduct(Product product) async {
    await dio.put('$baseUrl/${product.id}', data: product.toJson());
  }
}
