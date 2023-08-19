import 'package:flutter/material.dart';
import 'package:widget_test_practice/i_am_tailor/add_edit_customer_screen.dart';
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
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddEditCustomerScreen(
                    customerId: customerInfo.id,
                  ),
                ),
              );
            },
            icon: const Icon(Icons.edit_attributes),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: double.maxFinite,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    customerInfo.name ?? '',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            ..._buildAllAttribute(),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildAllAttribute() {
    return [
      AttributeRowWidget(
        values: [customerInfo.doorCamar ?? 0, customerInfo.doorBasan ?? 0],
        titles: [
          getCustomerInfoTitle('doorCamar'),
          getCustomerInfoTitle('doorBasan')
        ],
      ),
      AttributeRowWidget(
        values: [customerInfo.ghadBasan ?? 0, customerInfo.ghadDaman ?? 0],
        titles: [
          getCustomerInfoTitle('ghadBasan'),
          getCustomerInfoTitle('ghadDaman')
        ],
      ),
      AttributeRowWidget(
        values: [customerInfo.doorGardan ?? 0, customerInfo.ghadBalaTane ?? 0],
        titles: [
          getCustomerInfoTitle('doorGardan'),
          getCustomerInfoTitle('ghadBalaTane')
        ],
      ),
      AttributeRowWidget(
        values: [customerInfo.ghadPayinTane ?? 0, -1],
        titles: [
          getCustomerInfoTitle('ghadPayinTane'),
          getCustomerInfoTitle('')
        ],
      ),
      AttributeRowWidget(
        values: [customerInfo.karorJelo ?? 0, customerInfo.karorPosht ?? 0],
        titles: [
          getCustomerInfoTitle('karorJelo'),
          getCustomerInfoTitle('karorPosht')
        ],
      ),
      AttributeRowWidget(
        values: [customerInfo.doorSine ?? 0, customerInfo.faseleSine ?? 0],
        titles: [
          getCustomerInfoTitle('doorSine'),
          getCustomerInfoTitle('faseleSine')
        ],
      ),
      AttributeRowWidget(
        values: [customerInfo.ghadSine ?? 0, customerInfo.ghadSarshane ?? 0],
        titles: [
          getCustomerInfoTitle('ghadSine'),
          getCustomerInfoTitle('ghadSarshane')
        ],
      ),
      AttributeRowWidget(
        values: [customerInfo.ghadAstin ?? 0, customerInfo.doorBazo ?? 0],
        titles: [
          getCustomerInfoTitle('ghadAstin'),
          getCustomerInfoTitle('doorBazo')
        ],
      ),
      AttributeRowWidget(
        values: [customerInfo.doorMoch ?? 0, customerInfo.doorMosht ?? 0],
        titles: [
          getCustomerInfoTitle('doorMoch'),
          getCustomerInfoTitle('doorMosht')
        ],
      ),
      AttributeRowWidget(
        values: [customerInfo.ghadArenj ?? 0, customerInfo.ghadSaraphone ?? 0],
        titles: [
          getCustomerInfoTitle('ghadArenj'),
          getCustomerInfoTitle('ghadSaraphone')
        ],
      ),
      AttributeRowWidget(
        values: [customerInfo.ghadPirahan ?? 0, customerInfo.doorRan ?? 0],
        titles: [
          getCustomerInfoTitle('ghadPirahan'),
          getCustomerInfoTitle('doorRan')
        ],
      ),
      AttributeRowWidget(
        values: [customerInfo.ghadShalvar ?? 0, customerInfo.dampa ?? 0],
        titles: [
          getCustomerInfoTitle('ghadShalvar'),
          getCustomerInfoTitle('dampa')
        ],
      ),
    ];
  }
}

class AttributeRowWidget extends StatelessWidget {
  const AttributeRowWidget({
    Key? key,
    required this.values,
    required this.titles,
  }) : super(key: key);

  final List<double> values;
  final List<String> titles;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Row(
        children: [
          AttributeCardWidget(
            title: titles[0],
            value: values[0],
          ),
          if (titles[1].isNotEmpty && values[1] >= 0)
            AttributeCardWidget(
              title: titles[1],
              value: values[1],
            ),
        ],
      ),
    );
  }
}

class AttributeCardWidget extends StatelessWidget {
  final String title;
  final double value;
  const AttributeCardWidget({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            joinString(title, value),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  String joinString(String title, double value) {
    return '$title : $value سانتیمتر';
  }
}
