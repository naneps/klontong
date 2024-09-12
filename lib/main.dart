import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klontong/bloc/product.bloc.dart';
import 'package:klontong/bloc/product.even.dart';
import 'package:klontong/repositories/product.repository.dart';
import 'package:klontong/screens/product_list_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final productRepository = ProductRepository();

    return MultiBlocProvider(
      providers: [
        BlocProvider<ProductBloc>(
          create: (context) => ProductBloc(
            productRepository,
          )..add(FetchProducts()),
        ),
      ],
      child: const MaterialApp(
        home: ProductListPage(),
      ),
    );
  }
}
