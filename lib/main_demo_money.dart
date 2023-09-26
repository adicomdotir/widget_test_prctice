import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(
    MaterialApp(
      theme: ThemeData(fontFamily: 'Vazir'),
      home: const HomeScreen(),
    ),
  );
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(),
        body: Column(
          children: const [
            StatisticWidget(),
            TabBar(
              tabs: [
                Text(
                  'هزینه',
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
                Text(
                  'درامد',
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              ],
            ),
            DateWidget(),
            Expanded(
              child: TabBarView(
                children: [
                  ExpenseListWidget(),
                  ExpenseListWidget(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ExpenseListWidget extends StatelessWidget {
  const ExpenseListWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.all(8),
          child: SizedBox(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: Text('300000 تومان'),
                ),
                Text('25%'),
                Text('خانه'),
                Icon(Icons.holiday_village),
              ],
            ),
          ),
        );
      },
    );
  }
}

class StatisticWidget extends StatelessWidget {
  const StatisticWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;

    return SizedBox(
      width: double.infinity,
      height: 100,
      child: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: const Text(
                'مانده در حساب 30000000',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'روزانه',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      '+ 5%',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'هفتگی',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      '+ 15%',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'ماهانه',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      '- 10%',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class DateWidget extends StatelessWidget {
  const DateWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: 100,
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            child: const Icon(
              Icons.arrow_back_ios_new,
              size: 18,
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          const Directionality(
            textDirection: TextDirection.rtl,
            child: Text(
              '8 ابان 1402',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          Container(
            alignment: Alignment.center,
            child: const Icon(
              Icons.arrow_forward_ios_outlined,
              size: 18,
            ),
          ),
        ],
      ),
    );
  }
}
