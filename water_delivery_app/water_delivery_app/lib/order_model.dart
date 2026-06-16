class OrderModel {
  final String id;
  final String uid;
  final List<Map<String, dynamic>> items;
  final double total;
  final String status;

  OrderModel({
    required this.id,
    required this.uid,
    required this.items,
    required this.total,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "items": items,
      "total": total,
      "status": status,
      "timestamp": DateTime.now(),
    };
  }
}