import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  String id;
  String name;
  double? quantity;
  String? documentId;

  Product({required this.id, required this.name,  this.quantity, this.documentId});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'quantity': quantity,
      'documentId': documentId,
    };
  }

  factory Product.fromMap(Map<String, dynamic>? data, String id) {
    if (data == null) {
      throw ArgumentError("Data cannot be null");
    }

    return Product(
      id: data['id'] ?? '', // Provide default value if data['id'] is null
      name: data['name'] ?? '', // Provide default value if data['name'] is null
      quantity: data['quantity'] ?? 0, // Provide default value if data['phone'] is null
      documentId: id,
    );
  }


}

/////////////////// Product service //////////////////////////

class ProductService {
  final CollectionReference products =
      FirebaseFirestore.instance.collection('products');

  Future<void>? addProduct(Product product) {
    
    final db = FirebaseFirestore.instance;
    db.collection("products").add(product.toMap())
      .then((documentSnapshot) => print("Added Data with ID: ${documentSnapshot.id}"))
      .onError((error, stackTrace) => print('$error --> $stackTrace'));
    
  }

  static Future<List<Product>> getProducts() async {
   

    try {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('products').get();
    
    List<Product> products = querySnapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      String id = doc.id;
      return Product.fromMap(data, id); // Pass both data and id to the Product constructor
    }).toList();

    return products;
  } catch (error) {
    print('Error fetching Products: $error');
    return []; 
  }

  }

  Future<void> updateProduct(Product product) async {
    try {
      final db = FirebaseFirestore.instance;
      await db.collection('products').doc(product.documentId).update({
        'name': product.name,
        // 'phone': product.quantity,
        // Add other fields as needed
      });
      print('Product updated successfully');
    } catch (error) {
      print('Error adding Product: $error');
    }

  }

  Future<void>? deleteProduct(String documentId) {
    final db = FirebaseFirestore.instance;
    db.collection("products").doc(documentId).delete().then(
      (doc) => print("Document deleted"),
      onError: (e) => print("Error updating document $e"),
    );
  }


}