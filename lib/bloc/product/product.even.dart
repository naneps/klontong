import 'package:equatable/equatable.dart';
import 'package:klontong/models/product.model.dart';

class AddProduct extends ProductEvent {
  final Product product;
  AddProduct(this.product);
}

class DeleteProduct extends ProductEvent {
  final String id;
  DeleteProduct(this.id);
}

class FetchProducts extends ProductEvent {
  FetchProducts();
  @override
  List<Object?> get props => [];
}

abstract class ProductEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class UpdateProduct extends ProductEvent {
  final Product product;
  UpdateProduct(this.product);
}
