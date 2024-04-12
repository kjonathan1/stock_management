import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stock_management/widgets/app_bar.dart';

class SaleItem extends StatefulWidget {
  const SaleItem({super.key});

  @override
  State<SaleItem> createState() => _SaleItemState();
}

class _SaleItemState extends State<SaleItem> {

  String _selectedItem = '';
  String _selectedCustomer = '';

  final List<Map<String, String>> items = [
    {'value': '1', 'displayedText': 'Item1'},
    {'value': '2', 'displayedText': 'Item2'},
    {'value': '3', 'displayedText': 'Item3'},
  ];

  final List<Map<String, String>> customers = [
    {'value': '1', 'displayedText': 'Customer1'},
    {'value': '2', 'displayedText': 'Customer2'},
    {'value': '3', 'displayedText': 'Customer3'},
  ];

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: _appBar(title: 'Select Item'),
      body: Column(children: [
        SizedBox(
          width: double.infinity,
          child: DropdownButton(
                value: _selectedItem,
                items: [
                  const DropdownMenuItem(value: '', child: Text('Select Items')),
                  for(Map<String, String> item in items)
                    DropdownMenuItem(
                      value: item['value'], 
                      child: Text(item['displayedText']!),
                    )
                ],
                onChanged: (value){
                  setState(() {
                    _selectedItem = value!;
                  });
                },
              ),
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
        children: [
          Expanded(child: Text(title)),
          DropdownButton(
              value: _selectedCustomer,
              items: [
                DropdownMenuItem(value: '', child: Text(title)),
                for(Map<String, String> item in customers)
                  DropdownMenuItem(
                    value: item['value'], 
                    child: Text(item['displayedText']!),
                  )
              ],
              onChanged: (value){
                setState(() {
                  _selectedCustomer = value!;
                });
              },
            )
        ]
      )
    );
  }


}