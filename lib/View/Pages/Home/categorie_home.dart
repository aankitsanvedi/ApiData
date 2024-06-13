// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_01/Model/categories_model.dart';
import 'package:project_01/Model/product_model.dart';

class CategorieHome extends StatefulWidget {
  final CategoriesModel categoriesModels;

  const CategorieHome({super.key, required this.categoriesModels});

  @override
  State<CategorieHome> createState() => _CategorieHomeState();
}

class _CategorieHomeState extends State<CategorieHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(widget.categoriesModels.name.toString()),
        ],
      ),
    ));
  }
}
