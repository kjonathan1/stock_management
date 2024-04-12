import 'package:flutter/material.dart';
import 'package:stock_management/widgets/app_bar.dart';
// import 'package:stock_management/widgets/app_bar.dart';
// import 'package:stock_management/widgets/bottom_navigation_bar.dart';

class Inventory extends StatefulWidget {
  const Inventory({super.key});

  @override
  State<Inventory> createState() => _InventoryState();
}

class _InventoryState extends State<Inventory> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MyAppBar(appBarTitle: "Inventory"),
      body: Center(child: Text('Inventory page'),),
    );
  }
}