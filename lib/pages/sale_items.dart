import 'package:dropdownfield2/dropdownfield2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stock_management/models/customer.dart';
import 'package:stock_management/models/product.dart';


class SaleItem extends StatefulWidget {
  const SaleItem({super.key});

  @override
  State<SaleItem> createState() => _SaleItemState();
}

class _SaleItemState extends State<SaleItem> {

  String _selectedItem = '';
  String _selectedCustomer = '';
  late List<Product> products = []; 
  late List<Customer> customers = []; 

  List<String> productList = [];
  List<String> customerList = [];


  @override
  void initState() {
    super.initState();
    refresh();
  }

  void refresh(){
    ProductService.getProducts().then((elements) {
      setState(() {
        products = elements;
        products.sort((a, b) => a.name.compareTo(b.name));
      });
    });
    productList = products.map((product) => product.name).toList();
    CustomerService.getCustomers().then((elements) {
      setState(() {
        customers = elements;
        customers.sort((a, b) => a.name.compareTo(b.name));
      });
    });
    customerList = customers.map((customer) => customer.name).toList();
    print(productList); // print empty for now
    print(products); // print empty for now
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: _appBar(title: 'Select Item'),
      body: Column(children: [
        DropDownField(
        value: _selectedItem,
        required: true,
        strict: true,
        labelText: 'Select item *',
        icon: const Icon(Icons.sell_outlined),
        items: productList,
        setter: (dynamic newValue) {
            _selectedCustomer = newValue;
        }
    ),
        
        const SizedBox(height: 15,),
        Center(
        child: DataTable(
          columns: const[
            DataColumn(label: Text('Ref')),
            DataColumn(label: Text('Customer')),
            DataColumn(label: Text('Amount')),
            DataColumn(label: Text('Status')),
          ],
          rows: const [
            DataRow(cells: [
              DataCell(Text('001')),
              DataCell(Text('David')),
              DataCell(Text('2.300')),
              DataCell(Text('Done')),
            ]),
            DataRow(cells: [
              DataCell(Text('002')),
              DataCell(Text('Alice')),
              DataCell(Text('6.300')),
              DataCell(Text('Done')),
            ]),
            DataRow(cells: [
              DataCell(Text('003')),
              DataCell(Text('Mary')),
              DataCell(Text('3.300')),
              DataCell(Text('Draft')),
            ]),
          ],
        ),
      ),

      const Row(children: [
        Text('Global Discount:'),
        SizedBox(width: 15,),
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Discount amount',
            ),
          ),
        )
      ],),

      const Divider(
              color: Colors.black
            ),
        
      
      const Row(children: [
        Text('SubTotal'), 
        Text('22.000'),   
      ],),

       const Row(children: [
        Text('Discount'), 
        Text('2.000'),   
      ],),

      

    

      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        IconButton(onPressed: (){}, icon: const Text('Cash')),
        IconButton(onPressed: (){}, icon: const Text('Transfert')),
        IconButton(onPressed: (){}, icon: const Text('Credit card')),
        const Text('Total Due'), 
        const Text('20.000'),   
      ],),

      ],),
    );
  }


  PreferredSizeWidget _appBar({required String title}){
    return AppBar(
      title: Row(
        children:  [
          SizedBox(width: 100, child: Text(title)),
          Expanded(
            child: DropDownField(
              value: _selectedCustomer,
              required: true,
              strict: true,
              labelText: 'Select customer *',
              icon: const Icon(Icons.sell_outlined),
              items: customerList,
              setter: (dynamic newValue) {
                  _selectedCustomer = newValue;
              }
                    ),
          ),
        ]
      )
    );
  }


}