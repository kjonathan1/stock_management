import 'package:cloud_firestore/cloud_firestore.dart';

class Customer {
  String id;
  String name;
  String phone;
  String? documentId;

  Customer({required this.id, required this.name, required this.phone, this.documentId});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'documentId': documentId,
    };
  }

  factory Customer.fromMap(Map<String, dynamic>? data, String id) {
    if (data == null) {
      throw ArgumentError("Data cannot be null");
    }

    return Customer(
      id: data['id'] ?? '', // Provide default value if data['id'] is null
      name: data['name'] ?? '', // Provide default value if data['name'] is null
      phone: data['phone'] ?? '', // Provide default value if data['phone'] is null
      documentId: id,
    );
  }


}

/////////////////// Customer service //////////////////////////

class CustomerService {
  final CollectionReference customers =
      FirebaseFirestore.instance.collection('customers');

  Future<void>? addCustomer(Customer customer) {
    
    final db = FirebaseFirestore.instance;
    db.collection("customers").add(customer.toMap())
      .then((documentSnapshot) => print("Added Data with ID: ${documentSnapshot.id}"))
      .onError((error, stackTrace) => print('$error --> $stackTrace'));
    
  }

  static Future<List<Customer>> getCustomers() async {
   
    
    try {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('customers').get();
    
    List<Customer> customers = querySnapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      String id = doc.id;
      return Customer.fromMap(data, id); // Pass both data and id to the Customer constructor
    }).toList();

    return customers;
  } catch (error) {
    print('Error fetching customers: $error');
    return []; 
  }
  }

  Future<void> updateCustomer(Customer customer) async {
    try {
      final db = FirebaseFirestore.instance;
      await db.collection('customers').doc(customer.documentId).update({
        'name': customer.name,
        'phone': customer.phone,
        // Add other fields as needed
      });
      print('Customer updated successfully');
    } catch (error) {
      print('Error adding customer: $error');
    }

  }

  Future<void>? deleteCustomer(String documentId) {
    final db = FirebaseFirestore.instance;
    db.collection("customers").doc(documentId).delete().then(
      (doc) => print("Document deleted"),
      onError: (e) => print("Error updating document $e"),
    );
  }


}