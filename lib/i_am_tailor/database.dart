import 'customer_info.dart';

class MyDatabase {
  final List<CustomerInfo> _customers = [CustomerInfo()..name = 'یاشار پناهی'];
  static MyDatabase? _instance;

  MyDatabase._();

  static MyDatabase getInstance() {
    _instance ??= MyDatabase._();
    return _instance!;
  }

  List<CustomerInfo> fetchCustomers() => _customers;

  void addCustomer(CustomerInfo customerInfo) {
    _customers.add(customerInfo);
  }
}
