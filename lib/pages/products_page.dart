import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mockshop/pages/login.dart';
import 'package:mockshop/services/api.dart';
import 'package:mockshop/services/validator.dart';

class ProductsPage extends StatefulWidget {
  final dynamic token;

  const ProductsPage({required this.token, Key? key}) : super(key: key);

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  void viewProduct(BuildContext context, String id) {
    Navigator.pop(context);
    Navigator.pushNamed(context, '/view_product',
        arguments: [widget.token, id]);
  }

  void logout() {
    Api.logoutuser();
    Navigator.pop(context);
    Navigator.pushNamed(context, '/login');
  }

  dynamic customer;

  @override
  void initState() {
    customer = Validator.validateCustomer(context, widget.token);
    super.initState();
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
            if (customer == null) {
              return const LoginPage();
            }
            final products = snapshot.data;
            return SafeArea(
              child: Stack(
                children: [
                  Column(
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
                                onTap: () => viewProduct(context, product.id),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: 16,
                    left: 16,
                    child: FloatingActionButton(
                      onPressed: logout,
                      backgroundColor: Colors.grey[700],
                      shape: const CircleBorder(),
                      mini: true,
                      child: const Icon(
                        Icons.logout,
                        color: Colors.white,
                      ),
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
