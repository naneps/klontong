import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klontong/bloc/product/product.even.dart';
import 'package:klontong/bloc/product/product.state.dart';
import 'package:klontong/models/product.model.dart';
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
      final currentState = state;
      if (currentState is ProductLoaded) {
        final updatedProducts = List<Product>.from(currentState.products)
          ..add(event.product);
        emit(ProductLoaded(updatedProducts));
      }

      await productRepository.addProduct(event.product);

      add(FetchProducts());
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  Future<void> _onDeleteProduct(
      DeleteProduct event, Emitter<ProductState> emit) async {
    try {
      final currentState = state;
      if (currentState is ProductLoaded) {
        final updatedProducts = currentState.products
            .where((product) => product.id != event.id)
            .toList();
        emit(ProductLoaded(updatedProducts));
      }

      await productRepository.deleteProduct(event.id);

      add(FetchProducts());
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  Future<void> _onFetchProducts(
      FetchProducts event, Emitter<ProductState> emit) async {
    try {
      emit(ProductLoading()); // Show loading
      await Future.delayed(
          const Duration(milliseconds: 300)); // Optional debounce
      final products = await productRepository.fetchProducts();
      emit(ProductLoaded(products));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  Future<void> _onUpdateProduct(
      UpdateProduct event, Emitter<ProductState> emit) async {
    try {
      final currentState = state;
      if (currentState is ProductLoaded) {
        final updatedProducts = currentState.products.map((product) {
          return product.id == event.product.id ? event.product : product;
        }).toList();
        emit(ProductLoaded(updatedProducts));
      }

      await productRepository.updateProduct(event.product);

      add(FetchProducts());
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }
}
