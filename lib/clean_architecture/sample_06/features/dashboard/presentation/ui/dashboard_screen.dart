import 'package:flutter/material.dart';
import 'package:widget_test_practice/clean_architecture/sample_06/features/dashboard/presentation/ui/widget/bottom_navigation_widget.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(),
      bottomNavigationBar: const BottomNavigationWidget(),
    );
  }
}
