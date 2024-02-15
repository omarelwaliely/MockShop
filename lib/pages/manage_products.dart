import 'package:flutter/material.dart';
import 'package:mockshop/pages/login.dart';
import 'package:mockshop/services/api.dart';
import 'package:mockshop/services/validator.dart';
import 'package:collection/collection.dart';

class ManageProducts extends StatefulWidget {
  final dynamic token;

  const ManageProducts({this.token, Key? key}) : super(key: key);

  @override
  State<ManageProducts> createState() => _ManageProductsState();
}

class _ManageProductsState extends State<ManageProducts> {
  late dynamic vendor;
  void logout() {
    Api.logoutuser();
    Navigator.pop(context);
    Navigator.pushNamed(context, '/login');
  }

  @override
  void initState() {
    vendor = Validator.validateVendor(context, widget.token);
    super.initState();
  }

  void editProduct(BuildContext context, String id) {
    Navigator.pop(context);
    Navigator.pushNamed(context, '/edit_product',
        arguments: [widget.token, id]);
  }

  void addProduct(BuildContext context) {
    Navigator.pop(context);
    Navigator.pushNamed(context, '/add_products', arguments: widget.token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      body: FutureBuilder(
        future: vendor != null
            ? Api.getproductsof(vendor['_id'])
            : Future.value(["ERROR"]),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          } else if (const ListEquality().equals(snapshot.data, ["ERROR"])) {
            return const LoginPage();
          } else {
            final products = snapshot.data;
            return SafeArea(
              child: Stack(
                children: [
                  SafeArea(
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
                                  onTap: () => editProduct(context, product.id),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 16.0,
                    right: 16.0,
                    child: FloatingActionButton(
                      onPressed: () => addProduct(context),
                      backgroundColor: Colors.grey[700],
                      shape: const CircleBorder(),
                      mini: true,
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 16.0,
                    left: 16.0,
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
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
