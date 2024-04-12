import 'package:flutter/material.dart';
import 'package:stock_management/widgets/app_bar.dart';
// import 'package:stock_management/widgets/app_bar.dart';
// import 'package:stock_management/widgets/bottom_navigation_bar.dart';

class Product extends StatefulWidget {
  const Product({super.key});

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MyAppBar(appBarTitle: "Product"),
      body: Center(child: Text('Product page'),),
    );
  }
}