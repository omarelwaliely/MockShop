import 'package:flutter/material.dart';
import 'package:mockshop/components/product_card.dart';
import 'package:mockshop/model/product.dart';
import 'package:mockshop/pages/login.dart';
import 'package:mockshop/services/api.dart';
import 'package:mockshop/services/validator.dart';

class ViewProduct extends StatefulWidget {
  final String id;
  final String token;

  const ViewProduct({required this.token, required this.id, Key? key})
      : super(key: key);

  @override
  State<ViewProduct> createState() => _ViewProductState();
}

class _ViewProductState extends State<ViewProduct> {
  late Product product;
  void goBack(BuildContext context) {
    Navigator.pop(context);
    Navigator.pushNamed(context, '/products_page', arguments: widget.token);
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
      body: SafeArea(
        child: FutureBuilder<dynamic>(
          future: Api.getproduct(widget.id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError || snapshot.data == null) {
              return Center(
                child: Text(
                    'Error: ${snapshot.data != null ? snapshot.error : 'no product'}'),
              );
            } else {
              if (customer == null) {
                return const LoginPage();
              }
              Product product = snapshot.data;
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () => goBack(context),
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  Center(
                    child: Image.asset(
                      'lib/assets/logo.png',
                    ),
                  ),
                  const SizedBox(height: 30),
                  ProductCard(
                    title: 'Vendor',
                    content: product.vendorName.toString(),
                  ),
                  ProductCard(
                    title: 'Name',
                    content: product.productName.toString(),
                  ),
                  ProductCard(
                    title: 'Description',
                    content: product.description.toString(),
                  ),
                  ProductCard(
                    title: 'Price',
                    content: "${product.price.toString()}\$",
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
