import 'package:flutter/material.dart';
import 'package:mockshop/components/product_text_field.dart';
import 'package:mockshop/services/api.dart';

class AddProducts extends StatelessWidget {
  AddProducts({super.key});
  final productNameController = TextEditingController();
  final productDescriptionController = TextEditingController();
  final productPriceController = TextEditingController();
  void addProductToStore() {
    Api.addproduct({
      'vendorusername': 'test',
      'productname': productNameController.text,
      'description': productDescriptionController.text,
      'price': productPriceController.text
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        ProductTextField(
            controller: productNameController, hintText: "Product Name"),
        ProductTextField(
            controller: productDescriptionController,
            hintText: "Product Description"),
        ProductTextField(
            controller: productPriceController, hintText: "Product Price"),
        TextButton(onPressed: addProductToStore, child: const Text("Test"))
      ]),
    );
  }
}
