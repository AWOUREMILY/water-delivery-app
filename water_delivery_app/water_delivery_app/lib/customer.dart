class Customer {
  final String id;
  final String name;
  final String phone;
  final String location;

  Customer({
    required this.id,
    required this.name,
    required this.phone,
    required this.location,
  });

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "phone": phone,
      "location": location,
    };
  }

  factory Customer.fromMap(String id, Map<String, dynamic> data) {
    return Customer(
      id: id,
      name: data["name"] ?? "",
      phone: data["phone"] ?? "",
      location: data["location"] ?? "",
    );
  }
}