import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stock_management/models/customer.dart';
import 'package:stock_management/widgets/app_bar.dart';
import 'package:stock_management/widgets/customer_widget.dart';


class CustomerListWidget extends StatelessWidget {
  final List<Customer> customers;

  const CustomerListWidget({super.key, required this.customers});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(appBarTitle: 'Customers',),
      body: ListView.builder(
        itemCount: customers.length,
        itemBuilder: (context, index) {
          final customer = customers[index];
          return CustomerWidget(
            customer: customer,
            onDelete: () {
              CustomerService().deleteCustomer(customer.id);
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
                          initialValue: customer.name,
                          decoration: const InputDecoration(labelText: 'Name'),
                          onChanged: (value) {
                            // Update name
                            nameController.text = value;
                          },
                        ),
                        TextFormField(
                          controller: phoneController,
                          initialValue: customer.phone,
                          decoration: const InputDecoration(labelText: 'Phone'),
                          onChanged: (value) {
                            // Update phone
                            phoneController.text = value; 
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
                            ),
                          );
                        },
                        child: const Text('Save'),
                      ),
                    ],
                  );
                },
              );
            },
          );
        },
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
                      Navigator.of(context).pop(); // Close the dialog
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