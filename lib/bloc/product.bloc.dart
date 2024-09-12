import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klontong/bloc/product.even.dart';
import 'package:klontong/bloc/product.state.dart';
import 'package:klontong/repositories/product.repository.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository productRepository;

  ProductBloc(this.productRepository) : super(ProductLoading()) {
    on<FetchProducts>(_onFetchProducts);
    on<AddProduct>(_onAddProduct);
    on<UpdateProduct>(_onUpdateProduct);
    on<DeleteProduct>(_onDeleteProduct);
  }

  Future<void> _onAddProduct(
      AddProduct event, Emitter<ProductState> emit) async {
    try {
      await productRepository.addProduct(event.product);
      // Trigger FetchProducts to refresh the list
      add(FetchProducts());
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  Future<void> _onDeleteProduct(
      DeleteProduct event, Emitter<ProductState> emit) async {
    try {
      await productRepository.deleteProduct(event.id);
      // Trigger FetchProducts to refresh the list
      add(FetchProducts());
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  Future<void> _onFetchProducts(
      FetchProducts event, Emitter<ProductState> emit) async {
    try {
      final products = await productRepository.fetchProducts();
      emit(ProductLoaded(products));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  Future<void> _onUpdateProduct(
      UpdateProduct event, Emitter<ProductState> emit) async {
    try {
      await productRepository.updateProduct(event.product);
      // Trigger FetchProducts to refresh the list
      add(FetchProducts());
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }
}
