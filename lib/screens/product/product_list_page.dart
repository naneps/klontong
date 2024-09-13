import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klontong/bloc/auth/login.bloc.dart';
import 'package:klontong/bloc/auth/login.event.dart';
import 'package:klontong/bloc/product/product.bloc.dart';
import 'package:klontong/bloc/product/product.even.dart';
import 'package:klontong/bloc/product/product.state.dart';
import 'package:klontong/bloc/theme/theme.bloc.dart';
import 'package:klontong/bloc/theme/theme.event.dart';
import 'package:klontong/screens/auth/login_page.dart';
import 'package:klontong/screens/product/create_product_page.dart';
import 'package:klontong/widgets/product.widget.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6), // Theme toggle icon
            onPressed: () {
              context.read<ThemeBloc>().add(ToggleTheme());
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              context.read<LoginBloc>().add(LogoutEvent());
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const CreateProductPage();
          }));
        },
        child: const Icon(Icons.add),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<ProductBloc>().add(FetchProducts());
        },
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                if (state is ProductLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is ProductLoaded) {
                  return ListView.separated(
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 16),
                    physics: const BouncingScrollPhysics(),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    itemCount: state.products.length,
                    itemBuilder: (context, index) {
                      final product = state.products[index];
                      return ProductWidget(product: product);
                    },
                  );
                } else if (state is ProductError) {
                  return Center(child: Text(state.message));
                }
                return Container();
              },
            ),
          ),
        ),
      ),
    );
  }
}
