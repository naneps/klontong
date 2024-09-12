import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klontong/bloc/product.bloc.dart';
import 'package:klontong/bloc/product.even.dart';
import 'package:klontong/bloc/product.state.dart';
import 'package:klontong/screens/create_product_page.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Product List')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const CreateProductPage();
          }));
        },
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProductLoaded) {
            return ListView.builder(
              itemCount: state.products.length,
              itemBuilder: (context, index) {
                final product = state.products[index];
                return ListTile(
                  leading: SizedBox(
                    width: 100,
                    height: 100,
                    child: Image.network(
                      product.imageUrl,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.inventory);
                      },
                    ),
                  ),
                  title: Text(product.name),
                  subtitle: Text(product.description),
                  trailing: SizedBox(
                    width: 100,
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            // Handle edit functionality if needed
                          },
                          icon: const Icon(Icons.edit),
                        ),
                        IconButton(
                          onPressed: () {
                            context
                                .read<ProductBloc>()
                                .add(DeleteProduct(product.id));
                            context.read<ProductBloc>().add(FetchProducts());
                          },
                          icon: const Icon(Icons.delete),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (state is ProductError) {
            return Center(child: Text(state.message));
          }
          return Container();
        },
      ),
    );
  }
}
