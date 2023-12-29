import 'package:flutter/material.dart';
import 'package:mockshop/components/product_card.dart';
import 'package:mockshop/model/product.dart';

class ViewProduct extends StatefulWidget {
  final Product product;
  const ViewProduct({required this.product, super.key});

  @override
  State<ViewProduct> createState() => _ViewProductState();
}

class _ViewProductState extends State<ViewProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      body: SafeArea(
        child: Column(
          children: [
            Center(
                child: Image.asset(
              'lib/assets/logo.png',
            )),
            const SizedBox(height: 30),
            ProductCard(
              title: 'Vendor',
              content: widget.product.vendorName.toString(),
            ),
            ProductCard(
              title: 'Name',
              content: widget.product.productName.toString(),
            ),
            ProductCard(
              title: 'Description',
              content: widget.product.description.toString(),
            ),
            ProductCard(
              title: 'Price',
              content: "${widget.product.price.toString()}\$",
            )
          ],
        ),
      ),
    );
  }
}
