import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stock_management/models/customer.dart';
import 'package:stock_management/models/sale.dart';
import 'package:stock_management/widgets/app_bar.dart';
import 'package:stock_management/pages/sale_items.dart';
// import 'package:stock_management/widgets/bottom_navigation_bar.dart';

class SaleWidget extends StatefulWidget {
  const SaleWidget({super.key});

  @override
  State<SaleWidget> createState() => _SaleWidgetState();
}

class _SaleWidgetState extends State<SaleWidget> {

  late List<Sale> sales = [];
  //late List<Customer> customers = []; 
  String _selectedSatus = 'all';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SaleService.getSales().then((value) {
      setState(() {
        sales = value;
      });
    });
  }



  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: const MyAppBar(appBarTitle: "Sale"),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

        Expanded(
                    child: SingleChildScrollView(
                    
                      child: DataTable(
                        columns: const [
                          DataColumn(label: Text('Ref')),
                          DataColumn(label: Text('Date')),
                          DataColumn(label: Text('Customer')),
                          DataColumn(label: Text('Amount')),
                          DataColumn(label: Text('Payment')),
                          DataColumn(label: Text('Actions')),
                        ],
                        rows: [
                          for(int i = 0; i < sales.length; i++)
                            buildDataTow(sales[i])
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
        const Text('Payment method'),
        DropdownButton(
          value: _selectedSatus,
                items: const [
                  DropdownMenuItem(value: 'all', child: Text('All')),
                  DropdownMenuItem(value: 'cash', child: Text('Cash')),
                  DropdownMenuItem(value: 'transfert', child: Text('Transfert')),
                  DropdownMenuItem(value: 'card', child: Text('Credit card')),
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

  DataRow buildDataTow(Sale itemData) {

    String formattedDateTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(itemData.date!);
    // String formattedDateTime = itemData.date!.toDate().toString();
    //Customer customer = customers.firstWhere((element) => element.id == itemData.customerName,);
    return DataRow(cells: [
      DataCell(Text(itemData.reference)),
      DataCell(Text(formattedDateTime)),
      DataCell(Text(itemData.customerName)),
      DataCell(Text(itemData.totalDue.toString())),
      DataCell(Text(itemData.paymentMethode)),
      DataCell(IconButton(onPressed: () {}, icon: const Icon(Icons.print))),
    ]);
  }

}