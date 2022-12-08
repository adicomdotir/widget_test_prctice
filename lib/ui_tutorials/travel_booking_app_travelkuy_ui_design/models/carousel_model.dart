class CarouselModel {
  String image;

  CarouselModel(this.image);
}

List<CarouselModel> carousels =
    carouselsData.map((item) => CarouselModel(item['image']!)).toList();

var carouselsData = [
  {"image": "assets/travel_booking_app/images/carousel_flight_discount.png"},
  {"image": "assets/travel_booking_app/images/carousel_hotel_discount.png"},
  {"image": "assets/travel_booking_app/images/carousel_covid_discount.png"},
];
