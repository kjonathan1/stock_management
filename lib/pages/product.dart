import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stock_management/models/product.dart';
import 'package:stock_management/widgets/app_bar.dart';
import 'package:stock_management/widgets/product_widget.dart';



class ProductListWidget extends StatefulWidget {
  const ProductListWidget({super.key});

  @override
  State<ProductListWidget> createState() => _ProductListWidgetState();
}

class _ProductListWidgetState extends State<ProductListWidget> {

  late List<Product> products = []; 
  bool hasData = false;

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
    hasData = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(appBarTitle: 'Products',),
      body: Visibility(
        //visible == true : child
        //visible == false : replacement
        visible: hasData,
        replacement: const Center(child: CircularProgressIndicator()),
        child: ListView.builder(
          itemCount: products.length + 2,
          itemBuilder: (context, index) {
            if (index == 0) {
              // Header
              return const Center();
            } else if (index == products.length + 1) {
              // Footer
              return Center(
                child: SizedBox(
                  height: 65,
                  child: Text('Total Products: ${products.length}')
                ),
              );
            } else {
              final product = products[index - 1]; // Adjust index for products
              return ProductWidget(
              index: index,
              product: product,
              onDelete: () {
                ProductService().deleteProduct(product.documentId!);
                hasData = false;
                setState(() {
                  refresh();
                });
              },
              onEdit: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    TextEditingController nameController = TextEditingController(text: product.name);
                    
                    return AlertDialog(
                      title: const Text('Edit Product'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            controller: nameController,
                            // initialValue: product.name,
                            decoration: const InputDecoration(labelText: 'Name'),
                            onChanged: (value) {
                              // Update name
                              // nameController.text = value;
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
                            ProductService().updateProduct(
                              Product(
                                id: product.id,
                                name: nameController.text,
                                documentId: product.documentId,
                              ),
                            );
                            Navigator.of(context).pop();
                            hasData = false;
                            refresh();
                            // setState(() {
                            //   products =  ge;
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
        // SizedBox(child: Text('Total Products: ${products.length}'));
        
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              TextEditingController nameController = TextEditingController();
              
              return AlertDialog(
                title: const Text('Add Product'),
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
                      // Save product
                      String productId = FirebaseFirestore.instance.collection('products').doc().id;
                      Product product = Product(id: productId, name: nameController.text);
                      ProductService().addProduct(product);
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