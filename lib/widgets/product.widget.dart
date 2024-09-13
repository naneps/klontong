import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klontong/bloc/product/product.bloc.dart';
import 'package:klontong/bloc/product/product.even.dart';
import 'package:klontong/models/product.model.dart';
import 'package:klontong/screens/product/create_product_page.dart';
import 'package:klontong/screens/product/product_detail_page.dart';

class ProductWidget extends StatelessWidget {
  final Product product;

  const ProductWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        border: Border.all(
          color: Colors.grey.shade300,
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailPage(product: product),
            ),
          );
        },
        onLongPress: () {},
        leading: SizedBox(
          width: 90,
          height: 90,
          child: Image.network(
            product.imageUrl,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(Icons.inventory);
            },
          ),
        ),
        title: Text(
          product.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          product.priceFormatted,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 12),
        ),
        trailing: SizedBox(
          width: 100,
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return CreateProductPage(product: product);
                  }));
                },
                icon: const Icon(Icons.edit),
              ),
              IconButton(
                onPressed: () {
                  context.read<ProductBloc>().add(DeleteProduct(product.id));
                },
                icon: const Icon(Icons.delete),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
