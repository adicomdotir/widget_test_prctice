import 'package:flutter/material.dart';

import 'customer_info.dart';
import 'database.dart';

class AddEditCustomerScreen extends StatefulWidget {
  const AddEditCustomerScreen({Key? key}) : super(key: key);

  @override
  State<AddEditCustomerScreen> createState() => _AddEditCustomerScreenState();
}

class _AddEditCustomerScreenState extends State<AddEditCustomerScreen> {
  final CustomerInfo customerInfo = CustomerInfo();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('افراد جدید'),
        actions: [
          IconButton(
            onPressed: () {
              if (customerInfo.name == null || customerInfo.name!.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'لطفا نام و نام خانوادگی را وارد کنید',
                      style: TextStyle(fontFamily: 'Vazir'),
                    ),
                  ),
                );
              } else {
                MyDatabase.getInstance().addCustomer(customerInfo);
                Navigator.pop(context);
              }
            },
            icon: const Icon(Icons.save),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFieldWidget(
                title: 'نام و نام خانوادگی',
                suffixText: '',
                value: '',
                onChanged: (value) {
                  customerInfo.name = value;
                },
              ),
              const SizedBox(
                height: 16,
              ),
              TextFieldWidget(
                title: 'دور کمر',
              ),
              const SizedBox(
                height: 8,
              ),
              TextFieldWidget(
                title: 'دور باسن',
              ),
              const SizedBox(
                height: 8,
              ),
              TextFieldWidget(
                title: 'قد باسن',
              ),
              const SizedBox(
                height: 8,
              ),
              TextFieldWidget(
                title: 'قد دامن',
              ),
              const SizedBox(
                height: 8,
              ),
              TextFieldWidget(
                title: 'دور گردن',
              ),
              const SizedBox(
                height: 8,
              ),
              TextFieldWidget(
                title: 'قد بالاتنه جلو',
              ),
              const SizedBox(
                height: 8,
              ),
              TextFieldWidget(
                title: 'قد بالاتنه پشت',
              ),
              const SizedBox(
                height: 8,
              ),
              TextFieldWidget(
                title: 'کارور جلو',
              ),
              const SizedBox(
                height: 8,
              ),
              TextFieldWidget(
                title: 'کارور پشت',
              ),
              const SizedBox(
                height: 8,
              ),
              TextFieldWidget(
                title: 'دور سینه',
              ),
              const SizedBox(
                height: 8,
              ),
              TextFieldWidget(
                title: 'فاصله سینه',
              ),
              const SizedBox(
                height: 8,
              ),
              TextFieldWidget(
                title: 'قد سینه',
              ),
              const SizedBox(
                height: 8,
              ),
              TextFieldWidget(
                title: 'قد سرشانه',
              ),
              const SizedBox(
                height: 8,
              ),
              TextFieldWidget(
                title: 'قد استین',
              ),
              const SizedBox(
                height: 8,
              ),
              TextFieldWidget(
                title: 'دور باوز',
              ),
              const SizedBox(
                height: 8,
              ),
              TextFieldWidget(
                title: 'دور مچ',
              ),
              const SizedBox(
                height: 8,
              ),
              TextFieldWidget(
                title: 'دور مشت',
              ),
              const SizedBox(
                height: 8,
              ),
              TextFieldWidget(
                title: 'قد ارنج',
              ),
              const SizedBox(
                height: 8,
              ),
              TextFieldWidget(
                title: 'قد سارافون',
              ),
              const SizedBox(
                height: 8,
              ),
              TextFieldWidget(
                title: 'قد پیراهن یا بلوز',
              ),
              const SizedBox(
                height: 8,
              ),
              TextFieldWidget(
                title: 'دور ران',
              ),
              const SizedBox(
                height: 8,
              ),
              TextFieldWidget(
                title: 'قد شلوار',
              ),
              const SizedBox(
                height: 8,
              ),
              TextFieldWidget(
                title: 'دمپا',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TextFieldWidget extends StatelessWidget {
  final String title;
  final String suffixText;
  final String value;
  final void Function(String value)? onChanged;

  TextFieldWidget({
    Key? key,
    required this.title,
    this.onChanged,
    this.value = '0',
    this.suffixText = 'سانتی متر',
  }) : super(key: key);

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    _controller.text = value.toString();

    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: TextField(
            controller: _controller,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
            onChanged: onChanged,
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            suffixText,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
