import 'package:cloud_firestore/cloud_firestore.dart';

class Customer {
  String id;
  String name;
  String phone;

  Customer({required this.id, required this.name, required this.phone});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
    };
  }

  factory Customer.fromMap(Map<String, dynamic> map) {
    return Customer(
      id: map['id'],
      name: map['name'],
      phone: map['phone'],
    );
  }


}

/////////////////// Customer service //////////////////////////

class CustomerService {
  final CollectionReference customers =
      FirebaseFirestore.instance.collection('customers');

  Future<void>? addCustomer(Customer customer) {
    // final db = FirebaseFirestore.instance;
    // print(db.collection("customers"));    
    // return db
    // .collection("customers")
    // .add(customer.toMap());
    // .onError((e) => print("Error writing document: $e"));
 
      return  customers.doc(customer.id).set(customer.toMap()).then((value){
      print("Done");
    }).catchError((error)=> print(error));
 
    
  }

  // Future<List<Customer>> getCustomers() async {
  //   QuerySnapshot querySnapshot = await customers.get();
  //   return querySnapshot.docs
  //       .map((doc) => Customer.fromMap(doc.data() as Map<String, dynamic>))
  //       .toList();
  // }

  static Future<List<Customer>> getCustomers() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('customers').get();
    return querySnapshot.docs
        .map((doc) => Customer.fromMap(doc.data() as Map<String, dynamic>))
        .toList();
  }

  Future<void> updateCustomer(Customer customer) {
    return customers.doc(customer.id).update(customer.toMap());
  }

  Future<void> deleteCustomer(String customerId) {
    return customers.doc(customerId).delete();
  }


}