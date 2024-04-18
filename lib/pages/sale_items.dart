import 'package:dropdownfield2/dropdownfield2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:item_count_number_button/item_count_number_button.dart';
import 'package:stock_management/models/customer.dart';
import 'package:stock_management/models/product.dart';

class SaleItem extends StatefulWidget {
  const SaleItem({super.key});

  @override
  State<SaleItem> createState() => _SaleItemState();
}

class _SaleItemState extends State<SaleItem> {
  String? _selectedItem = '';
  String _selectedCustomer = '';
  TextEditingController selectedItemController =
      TextEditingController(text: '');
      final ScrollController _scrollController = ScrollController();
  late List<Product> products = [];
  late List<Customer> customers = [];

  List<String> productList = [];
  List<String> customerList = [];

  final List<Map<String, dynamic>> itemDatas = [];
  double totalDue = 0.0;
  double calclultotalDue(){
    double total= 0.0;
    for(int i=0; i<itemDatas.length; i++){
      total += itemDatas[i]['productAmount'];
    }
    return total;
  }

  @override
  void initState() {
    super.initState();
    refresh();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
  }

   // Function to scroll to the bottom
  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  // void refresh(){
  //   ProductService.getProducts().then((elements) {
  //     setState(() {
  //       products = elements;
  //       products.sort((a, b) => a.name.compareTo(b.name));
  //     });
  //   });
  //   productList = products.map((product) => product.name).toList();
  //   CustomerService.getCustomers().then((elements) {
  //     setState(() {
  //       customers = elements;
  //       customers.sort((a, b) => a.name.compareTo(b.name));
  //     });
  //   });
  //   customerList = customers.map((customer) => customer.name).toList();
  //   print(productList); // print empty for now
  //   print(products); // print empty for now
  // }

  void refresh() async {
    products = await ProductService.getProducts();
    products.sort((a, b) => a.name.compareTo(b.name));
    productList = products.map((product) => product.name).toList();

    customers = await CustomerService.getCustomers();
    customers.sort((a, b) => a.name.compareTo(b.name));
    customerList = customers.map((customer) => customer.name).toList();

    

    setState(() {}); // Trigger a rebuild after data is fetched
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(title: 'Select Item'),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //1st part up
            Expanded(
              child: Column(
                children: [
                  const SizedBox(height: 20),

                  Row(

                      // crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: DropdownMenu(
                              initialSelection: _selectedItem,
                              controller: selectedItemController,
                              onSelected: ((value) {
                                if (value != null) {
                                  _selectedItem = value;
                                  Product prod = products.firstWhere((element) => element.id == value,);
                                  itemDatas.add({
                                    'productRef': '001',
                                    'productName': prod.name,
                                    'productQty': prod.quantity,
                                    'productPrice': prod.price,
                                    'productAmount': 0.0
                                  });
                                }
                                setState(() {
                                  _selectedItem = "";
                                  selectedItemController.text = '';
                                  _scrollToBottom();
                                });
                              }),
                              enableFilter: true,
                              // helperText: 'Select an Item',
                              label: const Text("Select an Item *"),
                              expandedInsets: EdgeInsets.zero,
                              // width: 200,
                              dropdownMenuEntries: <DropdownMenuEntry<String>>[
                                for (Product e in products)
                                  DropdownMenuEntry(
                                      value: e.id, label: e.name),
                              ]),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: DropdownMenu(
                              onSelected: ((value) {
                                if (value != null) {
                                  setState(() {
                                    _selectedCustomer = value;
                                  });
                                }
                              }),
                              enableFilter: true,
                              // helperText: 'Select an Item',
                              label: const Text("Select a Customer *"),
                              expandedInsets: EdgeInsets.zero,
                              // width: 200,

                              dropdownMenuEntries: <DropdownMenuEntry<String>>[
                                for (Customer e in customers)
                                  DropdownMenuEntry(value: e.id, label: e.name),
                              ]),
                        ),
                      ]),
                  const SizedBox(height: 20),
                  // DropDownField(
                  //   value: _selectedItem,
                  //   required: true,

                  //   labelText: 'Select item *',
                  //   icon: const Icon(Icons.sell_outlined),
                  //   items: productList,
                  //   setter: (dynamic newValue) {
                  //     setState(() {
                  //       _selectedItem = newValue;
                  //     });
                  //   },
                  // ),
                  // const SizedBox(height: 20), // Add some spacing
                  // DropDownField(
                  //   value: _selectedCustomer,
                  //   required: true,
                  //   strict: true,
                  //   labelText: 'Select customer *',
                  //   icon: const Icon(Icons.sell_outlined),
                  //   items: customerList,
                  //   setter: (dynamic newValue) {
                  //     setState(() {
                  //       _selectedCustomer = newValue;
                  //     });
                  //   },
                  // ),

                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      // reverse: true,
                      // dragStartBehavior: DragStartBehavior.,
                      child: DataTable(
                        columns: const [
                          // DataColumn(label: Text('Ref')),
                          DataColumn(label: Text('Product')),
                          DataColumn(label: Text('Quantity')),
                          DataColumn(label: Text('Unit Price')),
                          DataColumn(label: Text('Amount')),
                          DataColumn(label: Text('Actions')),
                        ],
                        rows: [
                          for (int i = 0; i < itemDatas.length; i++)
                            i == itemDatas.length-1 ? buildDataTow(itemDatas[i], true) : buildDataTow(itemDatas[i], false),
                          // DataRow(cells: [
                          //   const DataCell(Text('001')),
                          //   const DataCell(Text('Product 1')),
                          //   const DataCell(Text('5')),
                          //   const DataCell(Text('2.300')),
                          //   DataCell(Row(children: [
                          //     incDecItem(),
                          //     IconButton(onPressed: (){}, icon: const Icon(Icons.delete))
                          //   ],)),
                          // ]),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Bottom section
            Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(onPressed: (){}, icon: const Text('Cash')),
                  IconButton(onPressed: (){}, icon: const Text('Transfert')),
                  IconButton(onPressed: (){}, icon: const Text('Credit card')),
                  const Text('Total Due'), 
                  Text(totalDue.toString()),   
                ],
              ),
            ],
          ),
        )
          ],
        ),
      );
    
  }

  PreferredSizeWidget _appBar({required String title}) {
    return AppBar(
      title: Text(title),
    );
  }

  Widget incDecItem() {
    return ItemCount(
      initialValue: 0,
      minValue: 0,
      maxValue: 10,
      decimalPlaces: 0,
      onChanged: (value) {
        // Handle counter value changes
        print('Selected value: $value');
      },
    );
  }

  DataRow buildDataTow(Map<String, dynamic> itemData, bool isLast) {
    return DataRow(cells: [
      // const DataCell(Text('001')),
      DataCell(Text(itemData['productName'])),
      DataCell(
        // incDecItem(),
        isLast ?
          Row(children: [
            IconButton(
              onPressed: (){
                setState(() {
                  itemData['productQty'] --;
                  itemData['productAmount'] = itemData['productQty'] * itemData['productPrice'];
                  totalDue = calclultotalDue(); 
                });
              }, 
              icon: const Icon(Icons.remove_circle_outline_outlined)
            ),
            Text(itemData['productQty'].toString()),
            IconButton(
              onPressed: (){
                setState(() {
                  itemData['productQty'] ++;
                  itemData['productAmount'] = itemData['productQty'] * itemData['productPrice'];
                  totalDue = calclultotalDue(); 
                });
              }, 
              icon: const Icon(Icons.add_circle_outline_outlined)
            ),
          ],)
          :
          Row(children: [
             Text(itemData['productQty'].toString()),
           ],)
      ),
      DataCell(Text(itemData['productPrice'].toString())),
      DataCell(Text(itemData['productAmount'].toString())),
      DataCell(IconButton(onPressed: () {}, icon: const Icon(Icons.delete))),
    ]);
  }
}
