import 'package:flutter/material.dart';
import 'package:mockshop/services/api.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class ManageProducts extends StatefulWidget {
  final dynamic token;
  const ManageProducts({required this.token, super.key});

  @override
  State<ManageProducts> createState() => _ManageProductsState();
}

class _ManageProductsState extends State<ManageProducts> {
  void editProduct() {}
  late String email;

  @override
  void initState() {
    super.initState();
    Map<String, dynamic> decodedToken = JwtDecoder.decode(widget.token);
    email = decodedToken['email'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: Api.getproductsof('test'),
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
                      Text(email),
                      TextButton(
                          onPressed: editProduct, child: const Text('Edit')),
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
