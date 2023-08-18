import 'package:hive/hive.dart';

import 'customer_info.dart';

class MyDatabase {
  static MyDatabase? _instance;

  MyDatabase._();

  static MyDatabase getInstance() {
    _instance ??= MyDatabase._();
    return _instance!;
  }

  List<CustomerInfo> fetchCustomers() {
    final customersBox = Hive.box<CustomerInfo>('customers');
    return customersBox.values.toList();
  }

  Future<void> addCustomer(CustomerInfo customerInfo) {
    final customersBox = Hive.box<CustomerInfo>('customers');
    return customersBox.put(customerInfo.id, customerInfo);
  }
}
