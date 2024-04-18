import 'package:cloud_firestore/cloud_firestore.dart';

class Sale {
  String? id;
  String reference;
  DateTime? date;
  String paymentMethode;
  double totalDue;
  double discount = 0;
  String customerName;
  List<Map<String, dynamic>> saleItems;
  //user data soon

  Sale(
      {this.id,
      required this.reference,
      this.date,
      required this.paymentMethode,
      required this.totalDue,
      required this.discount,
      required this.customerName,
      required this.saleItems});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'reference': reference,
      'date': date,
      'paymentMethode': paymentMethode,
      'totalDue': totalDue,
      'discount': discount,
      'customerName': customerName,
      'saleItems': saleItems,
    };
  }

  factory Sale.fromMap(Map<String, dynamic>? data) {
    if (data == null) {
      throw ArgumentError("Data cannot be null");
    }

    return Sale(
      id: data['id'] ?? '', // Provide default value if data['id'] is null
      reference: data['reference'] ?? '', // Provide default value if data['name'] is null
      date: data['date'].toDate(),
      paymentMethode: data['paymentMethode'] ?? '',
      totalDue: data['totalDue'] ?? 0,
      discount: data['discount'] ?? 0,
      customerName: data['customerName'] ?? '',
      //saleItems: data['saleItems'] ?? [],
      saleItems: List<Map<String, dynamic>>.from(data['saleItems'] ?? []),
    );
  }
}

/////////////////// Sale service //////////////////////////

class SaleService {

  final CollectionReference salesCollectionReference =
      FirebaseFirestore.instance.collection('sales');

  Future<void>? addSale(Sale sale) {
    try{
      final db = FirebaseFirestore.instance;
      String documentID = salesCollectionReference.doc().id;
      sale.id = documentID;
      sale.date = DateTime.now();
      db
      .collection("sales")
      .doc(documentID)
      .set(sale.toMap())
      .onError((e, _) => print("Error writing document: $e"));
    } catch(error){
      print("Error writing document: $error");
    }
    // db
    //     .collection("sales")
    //     .add(sale.toMap())
    //     .then((documentSnapshot) =>
    //         print("Added Data with ID: ${documentSnapshot.id}"))
    //     .onError((error, stackTrace) => print('$error --> $stackTrace'));
  }

  static Future<List<Sale>> getSales() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('sales').get();

      List<Sale> sales = querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return Sale.fromMap(data); 
      }).toList();

      return sales;
    } catch (error) {
      print('Error fetching Sales: $error');
      return [];
    }
  }

  // Future<void> updateSale(Sale sale) async {
  //   try {
  //     final db = FirebaseFirestore.instance;
  //     await db.collection('sales').doc(sale.documentId).update({
  //       'name': sale.name,
  //       'price': sale.price,
  //       // Add other fields as needed
  //     });
  //     print('Sale updated successfully');
  //   } catch (error) {
  //     print('Error adding Sale: $error');
  //   }
  // }

  // Future<void>? deleteSale(String documentId) {
  //   final db = FirebaseFirestore.instance;
  //   db.collection("sales").doc(documentId).delete().then(
  //         (doc) => print("Document deleted"),
  //         onError: (e) => print("Error updating document $e"),
  //       );
  // }
}
