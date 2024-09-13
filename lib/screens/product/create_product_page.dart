import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klontong/bloc/product/product.bloc.dart';
import 'package:klontong/bloc/product/product.even.dart';
import 'package:klontong/models/product.model.dart';

class CreateProductPage extends StatefulWidget {
  final Product? product; // Optional product for editing

  const CreateProductPage({super.key, this.product});

  @override
  _CreateProductPageState createState() => _CreateProductPageState();
}

class _CreateProductPageState extends State<CreateProductPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _priceController;
  late TextEditingController _imageUrlController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product == null ? 'Add Product' : 'Edit Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a product name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a product description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a price';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _imageUrlController,
                decoration: const InputDecoration(labelText: 'Image URL'),
                // validator: (value) {
                //   if (value == null || value.isEmpty) {
                //     return 'Please enter an image URL';
                //   }
                //   return null;
                // },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  maximumSize: const Size.fromHeight(40),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final product = Product(
                      id: widget.product?.id ?? '', // Keep ID for edit
                      name: _nameController.text,
                      description: _descriptionController.text,
                      price: int.tryParse(_priceController.text) ?? 0,
                      imageUrl: _imageUrlController.text,
                      category: 'Makanan',
                      sku: 'sku001',
                    );

                    if (widget.product == null) {
                      context.read<ProductBloc>().add(AddProduct(product));
                    } else {
                      context.read<ProductBloc>().add(UpdateProduct(product));
                    }

                    Navigator.pop(context);
                  }
                },
                child: Text(widget.product == null ? 'Create' : 'Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.product?.name ?? '');
    _descriptionController =
        TextEditingController(text: widget.product?.description ?? '');
    _priceController =
        TextEditingController(text: widget.product?.price.toString() ?? '');
    _imageUrlController =
        TextEditingController(text: widget.product?.imageUrl ?? '');
  }
}
