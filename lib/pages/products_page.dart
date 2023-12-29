import 'package:flutter/material.dart';
import 'package:mockshop/model/product.dart';
import 'package:mockshop/services/api.dart';

class ProductsPage extends StatelessWidget {
  final dynamic token;

  const ProductsPage({required this.token, Key? key}) : super(key: key);

  void viewProduct(BuildContext context, Product product) {
    Navigator.pushNamed(context, '/view_product', arguments: product);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      body: FutureBuilder(
        future: Api.getallproducts(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          } else {
            final products = snapshot.data;

            return SafeArea(
              child: Column(
                children: [
                  Image.asset(
                    'lib/assets/logo.png',
                  ),
                  const SizedBox(height: 30),
                  Expanded(
                    child: ListView.builder(
                      itemCount: products.length,
                      itemBuilder: (BuildContext context, int index) {
                        var product = products[index];
                        return Card(
                          margin: const EdgeInsets.all(10.0),
                          color: Colors.white,
                          child: ListTile(
                            title: Text(product.productName),
                            onTap: () => viewProduct(context, product),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
