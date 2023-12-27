import 'package:flutter/material.dart';
import 'package:mockshop/services/api.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: Api.getallproducts(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          } else {
            final products = snapshot.data;
            return SafeArea(
              child: Column(
                children: products.map<Widget>((product) {
                  return Row(
                    children: [
                      Text('Product Name: ${product.productName}'),
                      Text('Product Description: ${product.description}'),
                      Text('Product Price: ${product.price}'),
                    ],
                  );
                }).toList(),
              ),
            );
          }
        },
      ),
    );
  }
}
