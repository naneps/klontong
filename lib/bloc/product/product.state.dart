import 'package:equatable/equatable.dart';
import 'package:klontong/models/product.model.dart';

class ProductError extends ProductState {
  final String message;
  ProductError(this.message);
}

class ProductLoaded extends ProductState {
  final List<Product> products;
  ProductLoaded(this.products);
}

class ProductLoading extends ProductState {}

abstract class ProductState extends Equatable {
  @override
  List<Object?> get props => [];
}
