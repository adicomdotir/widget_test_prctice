import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:widget_test_practice/ui_tutorials/travel_booking_app_travelkuy_ui_design/constants/color_constant.dart';
import 'package:widget_test_practice/ui_tutorials/travel_booking_app_travelkuy_ui_design/constants/style_constant.dart';
import 'package:widget_test_practice/ui_tutorials/travel_booking_app_travelkuy_ui_design/models/carousel_model.dart';
import 'package:widget_test_practice/ui_tutorials/travel_booking_app_travelkuy_ui_design/models/popular_destination_model.dart';
import 'package:widget_test_practice/ui_tutorials/travel_booking_app_travelkuy_ui_design/widgets/bottom_navigation_travelkuy.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _current = 0;

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; ++i) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mBackgroundColor,
        title: SvgPicture.asset(
          'assets/travel_booking_app/svg/travelkuy_logo.svg',
        ),
        elevation: 0,
      ),
      backgroundColor: mBackgroundColor,
      bottomNavigationBar: BottomNavigationTravelkuy(),
      body: Container(
        child: ListView(
          physics: const ClampingScrollPhysics(),
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Text(
                'Hi, Franklin This Promos for You!',
                style: mTitleStyle,
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(left: 16, right: 16),
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 190,
                    child: Swiper(
                      onIndexChanged: (value) {
                        setState(() {
                          _current = value;
                        });
                      },
                      autoplay: true,
                      layout: SwiperLayout.DEFAULT,
                      itemCount: carousels.length,
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                              image: AssetImage(
                                carousels[index].image,
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: map(carousels, (index, image) {
                          return Container(
                            alignment: Alignment.centerLeft,
                            height: 6,
                            width: 6,
                            margin: const EdgeInsets.only(right: 8),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color:
                                  _current == index ? mBlueColor : mGreyColor,
                            ),
                          );
                        }),
                      ),
                      Text(
                        'More...',
                        style: mMoreDiscountStyle,
                      ),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 16,
                top: 24,
              ),
              child: Text(
                'Let\'s Booking!',
                style: mTitleStyle,
              ),
            ),
            Container(
              height: 144,
              margin: const EdgeInsets.only(
                left: 16,
                right: 16,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(
                            right: 8,
                          ),
                          padding: const EdgeInsets.only(
                            left: 16,
                          ),
                          height: 64,
                          decoration: BoxDecoration(
                            color: mFillColor,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: mBorderColor, width: 1),
                          ),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                'assets/travel_booking_app/svg/service_flight_icon.svg',
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Flight',
                                      style: mServiceTitleStyle,
                                    ),
                                    Text(
                                      'Feel freedom',
                                      style: mServiceSubtitleStyle,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(
                            right: 8,
                          ),
                          padding: const EdgeInsets.only(
                            left: 16,
                          ),
                          height: 64,
                          decoration: BoxDecoration(
                            color: mFillColor,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: mBorderColor, width: 1),
                          ),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                'assets/travel_booking_app/svg/service_flight_icon.svg',
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Flight',
                                      style: mServiceTitleStyle,
                                    ),
                                    Text(
                                      'Feel freedom',
                                      style: mServiceSubtitleStyle,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(
                            right: 8,
                          ),
                          padding: const EdgeInsets.only(
                            left: 16,
                          ),
                          height: 64,
                          decoration: BoxDecoration(
                            color: mFillColor,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: mBorderColor, width: 1),
                          ),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                'assets/travel_booking_app/svg/service_flight_icon.svg',
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Flight',
                                      style: mServiceTitleStyle,
                                    ),
                                    Text(
                                      'Feel freedom',
                                      style: mServiceSubtitleStyle,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(
                            right: 8,
                          ),
                          padding: const EdgeInsets.only(
                            left: 16,
                          ),
                          height: 64,
                          decoration: BoxDecoration(
                            color: mFillColor,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: mBorderColor, width: 1),
                          ),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                'assets/travel_booking_app/svg/service_flight_icon.svg',
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Flight',
                                      style: mServiceTitleStyle,
                                    ),
                                    Text(
                                      'Feel freedom',
                                      style: mServiceSubtitleStyle,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 16,
                top: 24,
                bottom: 12,
              ),
              child: Text(
                'Popular Destinations!',
                style: mTitleStyle,
              ),
            ),
            Container(
              height: 140,
              child: ListView.builder(
                itemCount: populars.length,
                padding: const EdgeInsets.only(left: 16, right: 16),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Container(
                      width: 120,
                      height: 140,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: mBorderColor, width: 1),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 16),
                        child: Column(
                          children: [
                            Image.asset(
                              populars[index].image,
                              height: 74,
                            ),
                            Text(
                              populars[index].name,
                              style: mPopularDestinationTitleStyle,
                            ),
                            Text(
                              populars[index].country,
                              style: mPopularDestinationSubtitleStyle,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 16,
                top: 24,
                bottom: 12,
              ),
              child: Text(
                'Travlog!',
                style: mTitleStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
