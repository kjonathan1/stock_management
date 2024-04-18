import 'package:flutter/material.dart';
import 'package:stock_management/models/product.dart';

class ProductWidget extends StatelessWidget {
  final int index;
  final Product product;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const ProductWidget({super.key, 
    required this.index,
    required this.product,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(child: Text("${index+1}")),
      title: Text("${product.name} - ${product.price} \$"),
      subtitle: Text(product.quantity.toString()),
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

