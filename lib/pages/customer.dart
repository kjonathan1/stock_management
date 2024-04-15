import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stock_management/models/customer.dart';
import 'package:stock_management/widgets/app_bar.dart';
import 'package:stock_management/widgets/customer_widget.dart';


class CustomerListWidget extends StatefulWidget {
  const CustomerListWidget({super.key});

  @override
  State<CustomerListWidget> createState() => _CustomerListWidgetState();
}

class _CustomerListWidgetState extends State<CustomerListWidget> {

  late List<Customer> customers = []; 
  bool hasData = false;

  @override
  void initState() {
    super.initState();
    refresh();
  }

  void refresh(){
    CustomerService.getCustomers().then((elements) {
      setState(() {
        customers = elements;
        customers.sort((a, b) => a.name.compareTo(b.name));
      });
    });
    hasData = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(appBarTitle: 'Customers',),
      body: Visibility(
        //visible == true : child
        //visible == false : replacement
        visible: hasData,
        replacement: const Center(child: CircularProgressIndicator()),
        child: ListView.builder(
          itemCount: customers.length + 2,
          itemBuilder: (context, index) {
            if (index == 0) {
              // Header
              return const Center();
            } else if (index == customers.length + 1) {
              // Footer
              return Center(
                child: SizedBox(
                  height: 65,
                  child: Text('Total Customers: ${customers.length}')
                ),
              );
            } else {
              final customer = customers[index - 1]; // Adjust index for customers
              return CustomerWidget(
              index: index,
              customer: customer,
              onDelete: () {
                CustomerService().deleteCustomer(customer.documentId!);
                hasData = false;
                setState(() {
                  refresh();
                });
              },
              onEdit: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    TextEditingController nameController = TextEditingController(text: customer.name);
                    TextEditingController phoneController = TextEditingController(text: customer.phone);
                    
                    return AlertDialog(
                      title: const Text('Edit Customer'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            controller: nameController,
                            // initialValue: customer.name,
                            decoration: const InputDecoration(labelText: 'Name'),
                            onChanged: (value) {
                              // Update name
                              // nameController.text = value;
                            },
                          ),
                          TextFormField(
                            controller: phoneController,
                            // initialValue: customer.phone,
                            decoration: const InputDecoration(labelText: 'Phone'),
                            onChanged: (value) {
                              // Update phone
                              // phoneController.text = value; 
                            },
                          ),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            // Close dialog
                            Navigator.of(context).pop();
                          },
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            // Save changes
                            CustomerService().updateCustomer(
                              Customer(
                                id: customer.id,
                                name: nameController.text,
                                phone: phoneController.text,
                                documentId: customer.documentId,
                              ),
                            );
                            Navigator.of(context).pop();
                            hasData = false;
                            refresh();
                            // setState(() {
                            //   customers =  ge;
                            // });
                          },
                          child: const Text('Save'),
                        ),
                      ],
                    );
                  },
                );
              },
            );
            
          }},
        
        ),
        // SizedBox(child: Text('Total Customers: ${customers.length}'));
        
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              TextEditingController nameController = TextEditingController();
              TextEditingController phoneController = TextEditingController();
              return AlertDialog(
                title: const Text('Add Customer'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(labelText: 'Name'),
                      onChanged: (value) {
                        // Update name
                        //nameController.text = value;
                      },
                    ),
                    TextFormField(
                      controller: phoneController,
                      decoration: const InputDecoration(labelText: 'Phone'),
                      onChanged: (value) {
                        // Update phone
                        //phoneController.text = value;
                      },
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      // Close dialog
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      // Save customer
                      String customerId = FirebaseFirestore.instance.collection('customers').doc().id;
                      Customer customer = Customer(id: customerId, name: nameController.text, phone: phoneController.text);
                      CustomerService().addCustomer(customer);
                      Navigator.of(context).pop();
                      hasData = false;
                      refresh(); // Close the dialog
                    },
                    child: const Text('Save'),
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}