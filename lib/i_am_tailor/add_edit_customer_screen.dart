import 'package:flutter/material.dart';

import 'customer_info.dart';
import 'database.dart';

class AddEditCustomerScreen extends StatefulWidget {
  final String? customerId;

  const AddEditCustomerScreen({
    Key? key,
    this.customerId,
  }) : super(key: key);

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
            onPressed: () async {
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
                final uk = UniqueKey();
                customerInfo.id = uk.hashCode.toString();
                await MyDatabase.getInstance().addCustomer(customerInfo);
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
                textInputType: TextInputType.text,
                onChanged: (value) {
                  customerInfo.name = value;
                },
              ),
              const SizedBox(
                height: 16,
              ),
              TextFieldWidget(
                title: 'دور کمر',
                onChanged: (value) {
                  customerInfo.doorCamar = double.tryParse(value) ?? 0;
                },
              ),
              const SizedBox(
                height: 8,
              ),
              TextFieldWidget(
                title: 'دور باسن',
                onChanged: (value) {
                  customerInfo.doorBasan = double.tryParse(value) ?? 0;
                },
              ),
              const SizedBox(
                height: 8,
              ),
              TextFieldWidget(
                title: 'قد باسن',
                onChanged: (value) {
                  customerInfo.ghadBasan = double.tryParse(value) ?? 0;
                },
              ),
              const SizedBox(
                height: 8,
              ),
              TextFieldWidget(
                title: 'قد دامن',
                onChanged: (value) {
                  customerInfo.ghadDaman = double.tryParse(value) ?? 0;
                },
              ),
              const SizedBox(
                height: 8,
              ),
              TextFieldWidget(
                title: 'دور گردن',
                onChanged: (value) {
                  customerInfo.doorGardan = double.tryParse(value) ?? 0;
                },
              ),
              const SizedBox(
                height: 8,
              ),
              TextFieldWidget(
                title: 'قد بالاتنه جلو',
                onChanged: (value) {
                  customerInfo.ghadBalaTane = double.tryParse(value) ?? 0;
                },
              ),
              const SizedBox(
                height: 8,
              ),
              TextFieldWidget(
                title: 'قد بالاتنه پشت',
                onChanged: (value) {
                  customerInfo.ghadPayinTane = double.tryParse(value) ?? 0;
                },
              ),
              const SizedBox(
                height: 8,
              ),
              TextFieldWidget(
                title: 'کارور جلو',
                onChanged: (value) {
                  customerInfo.karorJelo = double.tryParse(value) ?? 0;
                },
              ),
              const SizedBox(
                height: 8,
              ),
              TextFieldWidget(
                title: 'کارور پشت',
                onChanged: (value) {
                  customerInfo.karorPosht = double.tryParse(value) ?? 0;
                },
              ),
              const SizedBox(
                height: 8,
              ),
              TextFieldWidget(
                title: 'دور سینه',
                onChanged: (value) {
                  customerInfo.doorSine = double.tryParse(value) ?? 0;
                },
              ),
              const SizedBox(
                height: 8,
              ),
              TextFieldWidget(
                title: 'فاصله سینه',
                onChanged: (value) {
                  customerInfo.faseleSine = double.tryParse(value) ?? 0;
                },
              ),
              const SizedBox(
                height: 8,
              ),
              TextFieldWidget(
                title: 'قد سینه',
                onChanged: (value) {
                  customerInfo.ghadSine = double.tryParse(value) ?? 0;
                },
              ),
              const SizedBox(
                height: 8,
              ),
              TextFieldWidget(
                title: 'قد سرشانه',
                onChanged: (value) {
                  customerInfo.ghadSarshane = double.tryParse(value) ?? 0;
                },
              ),
              const SizedBox(
                height: 8,
              ),
              TextFieldWidget(
                title: 'قد استین',
                onChanged: (value) {
                  customerInfo.ghadAstin = double.tryParse(value) ?? 0;
                },
              ),
              const SizedBox(
                height: 8,
              ),
              TextFieldWidget(
                title: 'دور باوز',
                onChanged: (value) {
                  customerInfo.doorBazo = double.tryParse(value) ?? 0;
                },
              ),
              const SizedBox(
                height: 8,
              ),
              TextFieldWidget(
                title: 'دور مچ',
                onChanged: (value) {
                  customerInfo.doorMoch = double.tryParse(value) ?? 0;
                },
              ),
              const SizedBox(
                height: 8,
              ),
              TextFieldWidget(
                title: 'دور مشت',
                onChanged: (value) {
                  customerInfo.doorMosht = double.tryParse(value) ?? 0;
                },
              ),
              const SizedBox(
                height: 8,
              ),
              TextFieldWidget(
                title: 'قد ارنج',
                onChanged: (value) {
                  customerInfo.ghadArenj = double.tryParse(value) ?? 0;
                },
              ),
              const SizedBox(
                height: 8,
              ),
              TextFieldWidget(
                title: 'قد سارافون',
                onChanged: (value) {
                  customerInfo.ghadSaraphone = double.tryParse(value) ?? 0;
                },
              ),
              const SizedBox(
                height: 8,
              ),
              TextFieldWidget(
                title: 'قد پیراهن یا بلوز',
                onChanged: (value) {
                  customerInfo.ghadPirahan = double.tryParse(value) ?? 0;
                },
              ),
              const SizedBox(
                height: 8,
              ),
              TextFieldWidget(
                title: 'دور ران',
                onChanged: (value) {
                  customerInfo.doorRan = double.tryParse(value) ?? 0;
                },
              ),
              const SizedBox(
                height: 8,
              ),
              TextFieldWidget(
                title: 'قد شلوار',
                onChanged: (value) {
                  customerInfo.ghadShalvar = double.tryParse(value) ?? 0;
                },
              ),
              const SizedBox(
                height: 8,
              ),
              TextFieldWidget(
                title: 'دمپا',
                onChanged: (value) {
                  customerInfo.dampa = double.tryParse(value) ?? 0;
                },
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
  final TextInputType textInputType;

  TextFieldWidget({
    Key? key,
    required this.title,
    this.onChanged,
    this.textInputType = TextInputType.number,
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
              fontSize: 16,
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
            keyboardType: textInputType,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.all(0),
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
            style: const TextStyle(fontSize: 12),
          ),
        ),
      ],
    );
  }
}
