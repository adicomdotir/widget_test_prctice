import '../dependency_injector.dart';
import 'package:flutter/material.dart';
import 'car_details_bloc.dart';
import '../list/cars_list_bloc.dart';
import '../models/car.dart';
import '../constants.dart';

class CarDetailsPage extends StatefulWidget {
  const CarDetailsPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  final int id;

  @override
  CarDetailsPageState createState() => CarDetailsPageState();
}

class CarDetailsPageState extends State<CarDetailsPage> {
  var carsDetailsBloc = locator<CarDetailsBloc>();
  var carsListBloc = locator<CarsListBloc>();

  @override
  void initState() {
    super.initState();
    carsDetailsBloc.getItem(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder<Car?>(
          stream: carsDetailsBloc.outItem,
          initialData: null,
          builder: (BuildContext context, AsyncSnapshot<Car?> snapshot) {
            print(snapshot.data);
            if (snapshot.data == null) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return Text(snapshot.data!.title);
            }
          },
        ),
      ),
      body: StreamBuilder<Car?>(
        key: const Key(carDetailsKey),
        stream: carsDetailsBloc.outItem,
        initialData: null,
        builder: (BuildContext context, AsyncSnapshot<Car?> snapshot) {
          if (snapshot.data == null) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return _buildDetailsView(snapshot.data!);
          }
        },
      ),
    );
  }

  Text _buildFeaturesView(List<dynamic> features) {
    final allFeatures = StringBuffer();
    for (final feature in features) {
      allFeatures.write('\n $feature \n');
    }
    return Text(allFeatures.toString());
  }

  Widget _buildDetailsView(Car item) {
    final Widget button = item.selected
        ? ElevatedButton(
            child: const Text(removeButton),
            onPressed: () => carsListBloc.deselectItem(widget.id),
          )
        : ElevatedButton(
            child: const Text(selectButton),
            onPressed: () => carsListBloc.selectItem(widget.id),
          );
    return Container(
      padding: const EdgeInsets.all(24.0),
      child: ListView(
        children: <Widget>[
          ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(8.0),
            ),
            child: (item.url == null || item.url.isEmpty)
                ? Image.asset(
                    placeholderImageFilePath,
                    height: 150,
                    fit: BoxFit.cover,
                  )
                : Image.network(
                    item.url,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
          ),
          const SizedBox(
            height: 11.0,
          ),
          Text(
            item.selected ? selectedTitle : notSelectedTitle,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 22.0,
          ),
          Text(item.description),
          const SizedBox(
            height: 33.0,
          ),
          const Text(
            featuresTitle,
            textAlign: TextAlign.left,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          _buildFeaturesView(item.features),
          const SizedBox(
            height: 8.0,
          ),
          button
        ],
      ),
    );
  }
}
