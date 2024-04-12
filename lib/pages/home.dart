import 'package:flutter/material.dart';
import 'package:stock_management/models/customer.dart';
import 'package:stock_management/pages/customer.dart';
import 'package:stock_management/pages/inventory.dart';
import 'package:stock_management/pages/product.dart';
import 'package:stock_management/pages/sale.dart';
// import 'package:stock_management/widgets/app_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //customers
  late List<Customer> customers; // CustomerService.getCustomers() as List<Customer>;

  int currentIndex = 0;
  List<Widget> pages =  [
    const Sale(),
    const Inventory(),
    const Product(),
    const CustomerListWidget(customers: [],),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CustomerService.getCustomers().then((elements) {
      setState(() {
        customers = elements;
        pages[3] = CustomerListWidget(customers: customers);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: pages[currentIndex],
      
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index){
          setState(() {
            currentIndex = index;
          });
        },
        selectedItemColor: Colors.white,
        // unselectedItemColor: Colors.pink,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        // backgroundColor: Colors.red,
        currentIndex: currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon:  Icon(Icons.shopping_cart_outlined), 
            label: 'Sale', 
            backgroundColor: Colors.purple
          ),
          BottomNavigationBarItem(icon:  Icon(Icons.inventory_rounded), label: 'Inventory'),
          BottomNavigationBarItem(icon:  Icon(Icons.sell_outlined), label: 'Product'),
          BottomNavigationBarItem(icon:  Icon(Icons.co_present_outlined), label: 'Customer'),
        ],
      ),
    );
  }
}