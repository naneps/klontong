import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class Product extends Equatable {
  final String? id;
  final String? name;
  final String description;
  final int price;
  final String category;
  final String sku;
  final String imageUrl;

  const Product({
    this.id,
    this.name,
    required this.description,
    required this.price,
    required this.category,
    required this.sku,
    required this.imageUrl,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
      price: json['harga'],
      category: json['categoryName'],
      sku: json['sku'],
      imageUrl: json['image'],
    );
  }

  String get priceFormatted => NumberFormat.currency(
        decimalDigits: 0,
        locale: 'ID',
        symbol: 'Rp ',
      ).format(price);

  @override
  List<Object?> get props =>
      [id, name, description, price, category, sku, imageUrl];
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'harga': price,
      'categoryName': category,
      'sku': sku,
      'image': imageUrl,
    };
  }
}
