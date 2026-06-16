class CustomerService {
  static final List<Map<String, String>> _customers = [];

  List<Map<String, String>> getCustomers() {
    return _customers;
  }

  void addCustomer(Map<String, String> customer) {
    _customers.add(customer);
  }

  void updateCustomer(int index, Map<String, String> customer) {
    _customers[index] = customer;
  }

  void deleteCustomer(int index) {
    _customers.removeAt(index);
  }
}