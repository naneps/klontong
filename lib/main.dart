import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klontong/bloc/auth/login.bloc.dart';
import 'package:klontong/bloc/auth/login.event.dart';
import 'package:klontong/bloc/auth/login.state.dart';
import 'package:klontong/bloc/product/product.bloc.dart';
import 'package:klontong/bloc/product/product.even.dart';
import 'package:klontong/repositories/product.repository.dart';
import 'package:klontong/screens/auth/login_page.dart';
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
        // ProductBloc for handling product-related state
        BlocProvider<ProductBloc>(
          create: (context) => ProductBloc(
            productRepository,
          )..add(FetchProducts()),
        ),

        // LoginBloc for handling login-related state
        BlocProvider<LoginBloc>(
          create: (context) => LoginBloc()..add(CheckLoginStatus()),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MainNavigation(),
      ),
    );
  }
}

class MainNavigation extends StatelessWidget {
  const MainNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        // If user is already logged in, go to ProductListPage
        if (state is LoginSuccess) {
          return const ProductListPage();
        }
        // Otherwise, show LoginPage
        return LoginPage();
      },
    );
  }
}
