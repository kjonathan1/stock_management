import 'package:flutter/material.dart';
import 'package:stock_management/models/customer.dart';

class CustomerWidget extends StatelessWidget {
  final int index;
  final Customer customer;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const CustomerWidget({super.key, 
    required this.index,
    required this.customer,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(child: Text("${index+1}")),
      title: Text(customer.name),
      subtitle: Text(customer.phone),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: onEdit,
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}

