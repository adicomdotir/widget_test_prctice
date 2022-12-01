import 'package:flutter/material.dart';
import 'package:widget_test_practice/dbestech/custom_appbar_reusable_widget/custom_app_bar.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const BackButton(),
        ),
      ),
      body: const Center(
        child: Text(
          'Second Page',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
