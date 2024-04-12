import 'package:flutter/material.dart';

class MyBottomNavigationBar extends StatefulWidget {
  const MyBottomNavigationBar({super.key});

  @override
  State<MyBottomNavigationBar> createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (index){print(index);},
      backgroundColor: Colors.black,
      currentIndex: 1,
      items: const [
        BottomNavigationBarItem(icon:  Icon(Icons.shopping_cart_outlined), label: 'Sale'),
        BottomNavigationBarItem(icon:  Icon(Icons.inventory_rounded), label: 'Inventory'),
        BottomNavigationBarItem(icon:  Icon(Icons.sell_outlined), label: 'Product'),
        BottomNavigationBarItem(icon:  Icon(Icons.co_present_outlined), label: 'Customer'),
      ],
    );
  }
}