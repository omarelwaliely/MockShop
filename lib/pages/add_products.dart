import 'package:flutter/material.dart';
import 'package:mockshop/components/advance_button_colored.dart';
import 'package:mockshop/components/product_text_field.dart';
import 'package:mockshop/services/api.dart';
import 'package:mockshop/services/validator.dart';

class AddProducts extends StatefulWidget {
  final String token;

  const AddProducts({required this.token, super.key});

  @override
  State<AddProducts> createState() => _AddProductsState();
}

class _AddProductsState extends State<AddProducts> {
  final productNameController = TextEditingController();
  final productDescriptionController = TextEditingController();
  final productPriceController = TextEditingController();
  dynamic vendor;

  void addProductToStore(BuildContext context) async {
    if (vendor != null) {
      await Api.addproduct({
        'vendorusername': vendor['username'],
        'productname': productNameController.text,
        'description': productDescriptionController.text,
        'price': productPriceController.text,
      });
      if (!context.mounted) return;
      Navigator.pop(context);
      Navigator.pushNamed(context, '/manage_products', arguments: widget.token);
    } else {
      Navigator.pop(context);
      Navigator.pushNamed(context, '/login');
    }
  }

  void goBack(BuildContext context) {
    Navigator.pop(context);
    Navigator.pushNamed(context, '/manage_products', arguments: widget.token);
  }

  @override
  void initState() {
    vendor = Validator.validateVendor(context, widget.token);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
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
            Image.asset(
              'lib/assets/logo.png',
              height: 100,
            ),
            const SizedBox(height: 50),
            ProductTextField(
              controller: productNameController,
              hintText: "Product Name",
              length: 30,
              lines: 1,
            ),
            ProductTextField(
              controller: productDescriptionController,
              hintText: "Product Description",
              length: 300,
              lines: 1,
            ),
            ProductTextField(
              controller: productPriceController,
              hintText: "Product Price",
              length: 20,
              lines: 1,
            ),
            const SizedBox(height: 20),
            AdvanceButtonColored(
              displayText: "Add Product",
              onPressed: () => addProductToStore(context),
              color: Colors.green, // Use the same color as EditProduct
            ),
          ],
        ),
      ),
    );
  }
}
