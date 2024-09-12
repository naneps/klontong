import 'package:dio/dio.dart';
import 'package:klontong/models/product.model.dart';

class ProductRepository {
  final Dio dio = Dio();
  final String baseUrl =
      "https://crudcrud.com/api/473f8d312b0e4af0ab7e92d271d26097/products";

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
