class PopularDestinationModel {
  String name;
  String country;
  String image;

  PopularDestinationModel(this.name, this.country, this.image);
}

List<PopularDestinationModel> populars = popularsData
    .map(
      (item) => PopularDestinationModel(
        item['name']!,
        item['country']!,
        item['image']!,
      ),
    )
    .toList();

var popularsData = [
  {
    'name': 'Bali',
    'country': 'Indonesia',
    'image': 'assets/travel_booking_app/images/destination_bali.png'
  },
  {
    'name': 'Paris',
    'country': 'France',
    'image': 'assets/travel_booking_app/images/destination_paris.png'
  },
  {
    'name': 'Rome',
    'country': 'Italy',
    'image': 'assets/travel_booking_app/images/destination_rome.png'
  },
  {
    'name': 'Bali',
    'country': 'Indonesia',
    'image': 'assets/travel_booking_app/images/destination_bali.png'
  },
  {
    'name': 'Paris',
    'country': 'France',
    'image': 'assets/travel_booking_app/images/destination_paris.png'
  },
  {
    'name': 'Rome',
    'country': 'Italy',
    'image': 'assets/travel_booking_app/images/destination_rome.png'
  },
];
