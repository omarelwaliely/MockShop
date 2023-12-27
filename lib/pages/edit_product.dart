import 'package:flutter/material.dart';
import 'package:mockshop/components/product_text_field.dart';
import 'package:mockshop/services/api.dart';

class EditProduct extends StatelessWidget {
  EditProduct({super.key});
  final productNameController = TextEditingController();
  final productDescriptionController = TextEditingController();
  final productPriceController = TextEditingController();
  void finishEditProduct() {
    Api.updateproduct('658b52aae8f2d3e6c249f6ff', {
      'vendorusername': 'test',
      'productname': productNameController.text,
      'description': productDescriptionController.text,
      'price': productPriceController.text
    });
  }

  void deleteProduct() {
    Api.deleteproduct('658b52aae8f2d3e6c249f6ff');
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
        TextButton(
          onPressed: finishEditProduct,
          child: const Text("Finish Edit"),
        ),
        TextButton(
          onPressed: deleteProduct,
          child: const Text("Delete"),
        )
      ]),
    );
  }
}
