import 'package:flutter/material.dart';
import 'package:mockshop/components/advance_button_colored.dart';
import 'package:mockshop/components/product_text_field.dart';
import 'package:mockshop/pages/login.dart';
import 'package:mockshop/services/api.dart';
import 'package:mockshop/services/validator.dart';

class EditProduct extends StatefulWidget {
  final dynamic token;
  final dynamic id;
  const EditProduct({required this.token, this.id, super.key});

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  final productNameController = TextEditingController();
  final productDescriptionController = TextEditingController();
  final productPriceController = TextEditingController();
  dynamic vendor;

  void finishEditProduct() async {
    if (vendor != null) {
      await Api.updateproduct(widget.id, {
        'vendorusername': vendor['username'],
        'productname': productNameController.text,
        'description': productDescriptionController.text,
        'price': productPriceController.text
      });
      if (!context.mounted) return;
      Navigator.pop(context);
      Navigator.pushNamed(context, '/manage_products', arguments: widget.token);
    }
  }

  void deleteProduct() {
    Api.deleteproduct(widget.id);
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
      body: FutureBuilder(
          future: Api.getproduct(widget.id),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            } else {
              if (vendor == null) {
                return const LoginPage();
              }
              productNameController.text = snapshot.data.productName ?? '';
              productDescriptionController.text =
                  snapshot.data.description ?? '';
              productPriceController.text = snapshot.data.price.toString();
              return SafeArea(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
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
                        ),
                        const SizedBox(height: 20),
                        ProductTextField(
                          controller: productNameController,
                          hintText: "Product Name",
                          length: 30,
                          lines: 1,
                        ),
                        const SizedBox(height: 20),
                        ProductTextField(
                          controller: productDescriptionController,
                          hintText: "Product Description",
                          length: 300,
                          lines: 3,
                        ),
                        const SizedBox(height: 20),
                        ProductTextField(
                          controller: productPriceController,
                          hintText: "Product Price",
                          length: 8,
                          lines: 1,
                        ),
                        const SizedBox(height: 20),
                        AdvanceButtonColored(
                          displayText: "Finish Edit",
                          onPressed: finishEditProduct,
                          color: Colors.green,
                        ),
                        const SizedBox(height: 20),
                        AdvanceButtonColored(
                          displayText: "Delete",
                          onPressed: deleteProduct,
                          color: Colors.red,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          }),
    );
  }
}
