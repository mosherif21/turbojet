import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';
import 'package:turbo_jet/general/general_functions.dart';

import '../components/live_session/live_session.dart';
import '../components/sessions_history/sessions_history.dart';
import '../controllers/home_screen_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeScreenController());
    final screenType = GetScreenType(context);
    return Scaffold(
      bottomNavigationBar: Obx(
        () => StylishBottomBar(
          option: BubbleBarOptions(
            barStyle: BubbleBarStyle.horizontal,
            bubbleFillStyle: BubbleFillStyle.fill,
            opacity: 1,
          ),
          iconSpace: 12.0,
          items: [
            BottomBarItem(
              icon: const Icon(Icons.rocket_launch_outlined),
              title: const Text(
                'Live session',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
              backgroundColor: Colors.black,
              selectedColor: Colors.black,
              selectedIcon: const Icon(
                Icons.rocket_launch_outlined,
                color: Colors.white,
              ),
            ),
            BottomBarItem(
              icon: const Icon(Icons.history),
              title: const Text(
                'Sessions history',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
              selectedIcon: const Icon(Icons.history, color: Colors.white),
              backgroundColor: Colors.black,
              selectedColor: Colors.black,
            ),
          ],
          currentIndex: controller.pageIndex.value,
          onTap: (index) {
            controller.pageIndex.value = index;
            controller.pageController.jumpToPage(controller.pageIndex.value);
          },
        ),
      ),

      body: PageView.builder(
        pageSnapping: false,
        scrollDirection: screenType.isPhone ? Axis.horizontal : Axis.vertical,
        physics: const NeverScrollableScrollPhysics(),
        controller: controller.pageController,
        itemCount: 2,
        itemBuilder: (BuildContext context, int index) {
          switch (index) {
            case 0:
              return const LiveSession();
            case 1:
              return const SessionsHistory();
            default:
              return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
