import 'package:flutter/material.dart';
import 'package:stock_management/widgets/app_bar.dart';
import 'package:stock_management/pages/sale_items.dart';
// import 'package:stock_management/widgets/bottom_navigation_bar.dart';

class Sale extends StatefulWidget {
  const Sale({super.key});

  @override
  State<Sale> createState() => _SaleState();
}

class _SaleState extends State<Sale> {

  String _selectedSatus = 'all';
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: const MyAppBar(appBarTitle: "Sale"),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
        const Text('Status'),
        DropdownButton(
          value: _selectedSatus,
                items: const [
                  DropdownMenuItem(value: 'all', child: Text('All')),
                  DropdownMenuItem(value: 'paid', child: Text('Paid')),
                  DropdownMenuItem(value: 'pending', child: Text('Pending')),
                ],
                onChanged: (value){
                  setState(() {
                    _selectedSatus = value!;
                  });
                },
              ),
        const Text('Total Amount'),
        const Text('20.000'),   
      ],),
      ]),
      
      floatingActionButton: Container(
        margin: const EdgeInsets.only(bottom: 30),
        child: FloatingActionButton(
          
          onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const SaleItem()));
          }, 
          child: const Text('+'),),
      ),
    );
  }
}