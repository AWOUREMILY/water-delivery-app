import 'package:cloud_firestore/cloud_firestore.dart';
import 'order_model.dart';

class OrderService {
  final orders = FirebaseFirestore.instance.collection("orders");

  Future<void> placeOrder(OrderModel order) async {
    await orders.add(order.toMap());
  }

  Stream getOrdersByUser(String uid) {
    return orders.where("uid", isEqualTo: uid).snapshots();
  }

  Future<void> updateStatus(String id, String status) async {
    await orders.doc(id).update({"status": status});
  }

  Future<void> deleteOrder(String id) async {
    await orders.doc(id).delete();
  }
}