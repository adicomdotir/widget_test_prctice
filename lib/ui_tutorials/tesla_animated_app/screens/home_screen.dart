import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:widget_test_practice/ui_tutorials/tesla_animated_app/constanins.dart';
import 'package:widget_test_practice/ui_tutorials/tesla_animated_app/home_controller.dart';

import 'components/door_lock.dart';
import 'components/tesla_bottom_navigationbar.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final HomeController _controller = HomeController();

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, snapshot) {
        return Scaffold(
          bottomNavigationBar: TeslaBottomNavigationBar(
            onTap: (index) {},
            selectedTab: 0,
          ),
          body: SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: constraints.maxHeight * 0.1,
                      ),
                      child: SvgPicture.asset(
                        'assets/tesla_animated_app/icons/Car.svg',
                        width: double.infinity,
                      ),
                    ),
                    Positioned(
                      right: constraints.maxWidth * 0.05,
                      child: DoorLock(
                        press: _controller.updateRightDoorLock,
                        isLock: _controller.isRightDoorLock,
                      ),
                    ),
                    Positioned(
                      left: constraints.maxWidth * 0.05,
                      child: DoorLock(
                        press: _controller.updateLeftDoorLock,
                        isLock: _controller.isLeftDoorLock,
                      ),
                    ),
                    Positioned(
                      top: constraints.maxHeight * 0.13,
                      child: DoorLock(
                        press: _controller.updateBonnetDoorLock,
                        isLock: _controller.isBonnetDoorLock,
                      ),
                    ),
                    Positioned(
                      bottom: constraints.maxHeight * 0.17,
                      child: DoorLock(
                        press: _controller.updateTrunkDoorLock,
                        isLock: _controller.isTrunkDoorLock,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}
