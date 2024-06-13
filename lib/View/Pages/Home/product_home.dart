import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project_01/Model/product_model.dart';

class ProductHome extends StatelessWidget {
  final ProductModel productModel;
  const ProductHome({super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipOval(
                child: Image.network(
                    width: 200,
                    height: 200,
                    productModel.images!.first.toString())),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 20),
              child: Text(
                productModel.title.toString(),
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 15),
              child: Text(productModel.description.toString()),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 15),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    onPressed: () {}, child: const Text('Confirm Order', style: TextStyle(color: Colors.white),)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
