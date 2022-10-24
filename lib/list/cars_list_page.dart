import '../dependency_injector.dart';
import 'package:flutter/material.dart';
import '../details/car_details_page.dart';
import '../models/car.dart';
import 'cars_list_bloc.dart';
import '../constants.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  ListPageState createState() => ListPageState();
}

class ListPageState extends State<ListPage> {
  var listBloc = locator<CarsListBloc>();

  @override
  void initState() {
    super.initState();
    listBloc.loadItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(listPageTitle),
      ),
      body: StreamBuilder<CarsList>(
        stream: listBloc.outCars,
        initialData: null,
        builder: (BuildContext context, AsyncSnapshot<CarsList> snapshot) {
          if (snapshot.hasError) {
            return _displayErrorMessage(snapshot.error.toString());
          } else if (snapshot.data == null) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.data?.errorMessage != null) {
            return _displayErrorMessage(snapshot.data!.errorMessage!);
          } else {
            return SingleChildScrollView(
              child: ListView(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                key: const Key(carsListKey),
                physics: const NeverScrollableScrollPhysics(),
                children: snapshot.data!.items!.map(
                  (Car value) {
                    return _buildListRow(value);
                  },
                ).toList(),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _displayErrorMessage(String errorMessage) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Column(
          children: <Widget>[
            const Spacer(),
            Text(
              errorMessage.replaceFirst(
                wildString,
                errorMessage,
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            ElevatedButton(
              child: const Text(retryButton),
              onPressed: () {
                listBloc.loadItems();
              },
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  Widget _buildListRow(Car car) {
    return Card(
      color: car.selected ? Colors.blue.shade200 : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
      ),
      child: ListTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
              child: (car.url == null || car.url.isEmpty)
                  ? Image.asset(
                      placeholderImageFilePath,
                      height: 150,
                      fit: BoxFit.cover,
                    )
                  : Image.network(
                      car.url,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                car.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
            ),
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            pricePerDayText.replaceFirst(
              wildString,
              car.pricePerDay.toStringAsFixed(2),
            ),
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
        ),
        onTap: () {
          _displayDetails(car);
        },
      ),
    );
  }

  void _displayDetails(Car car) async {
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return CarDetailsPage(id: car.id);
        },
      ),
    );
  }
}
