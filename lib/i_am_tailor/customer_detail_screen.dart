import 'package:flutter/material.dart';
import 'package:widget_test_practice/i_am_tailor/customer_info.dart';

class CustomerDetailScreen extends StatelessWidget {
  final CustomerInfo customerInfo;
  const CustomerDetailScreen({
    Key? key,
    required this.customerInfo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('مشخصات فرد'),
      ),
      body: SizedBox.expand(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(customerInfo.name ?? ''),
            Text(customerInfo.name ?? ''),
            Text(customerInfo.name ?? ''),
            Text(customerInfo.name ?? ''),
            Text(customerInfo.name ?? ''),
          ],
        ),
      ),
    );
  }
}
