import 'dart:ui';

import 'package:bike_rental/app/routes/app_pages.dart';
import 'package:bike_rental/app/views/views/account_page.dart';
import 'package:bike_rental/app/views/views/home_page.dart';
import 'package:bike_rental/app/views/views/notification_page_view.dart';
import 'package:bike_rental/app/views/views/rides_page.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final pages = [
    HomePage(),
    const NotificationPageView(),
    const RidesPage(),
    const AccountPage()
  ];

  RxInt currentPageIndex = 0.obs;
  final pageController = PageController();

  HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      // appBar: AppBar(
      //   leading: MediaQuery.sizeOf(context).width < 600
      //       ? null
      //       : const SizedBox.square(),
      //   // actions: [
      //   //   IconButton(
      //   //     onPressed: () {},
      //   //     icon: const Icon(Icons.qr_code_scanner_rounded),
      //   //   ),
      //   // ],
      // ),
      // // drawer: MediaQuery.sizeOf(context).width > 600 ? null : AppDrawer(),
      body: CustomPaint(
        painter: BackgroundPainter(),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: .3, sigmaY: .3),
          child: Container(
            color: Colors.white54,
            child: SafeArea(
              child: Row(
                children: [
                  // if (MediaQuery.sizeOf(context).width > 600) AppDrawer(),
                  Expanded(
                    child: PageView.builder(
                      controller: pageController,
                      itemCount: pages.length,
                      itemBuilder: (context, index) {
                        return pages[index];
                      },
                      onPageChanged: (value) {
                        currentPageIndex.value = value;
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(Routes.SCAN_QR);
        },
        tooltip: 'scan qr',
        child: const Icon(Icons.qr_code_scanner_rounded),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Obx(() => BottomNavigationBar(
            landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
            type: BottomNavigationBarType.fixed,
            useLegacyColorScheme: false,
            currentIndex: currentPageIndex.value,
            onTap: (value) {
              currentPageIndex.value = value;
              pageController.animateToPage(value,
                  duration: Durations.medium1, curve: Curves.easeIn);
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_rounded),
                label: 'Home',
                tooltip: 'navigate to home view',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.notifications_rounded),
                label: 'Notifications',
                tooltip: 'show notifications',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.directions_bike_rounded),
                label: 'Rides',
                tooltip: 'navigate to ride history view',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_rounded),
                label: 'Account',
                tooltip: 'show profile',
              )
            ],
          )),
    );
  }
}

class BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final height = size.height;
    final width = size.width;
    Paint paint = Paint();

    Path bg = Path();
    bg.addRect(Rect.fromLTRB(0, 0, width, height));
    paint.color = Get.theme.colorScheme.secondary;
    canvas.drawPath(bg, paint);

    Path ovalPath = Path();
    ovalPath.moveTo(0, height * 0.2);
    ovalPath.quadraticBezierTo(
        width * 0.45, height * 0.25, width * .51, height * .5);

    ovalPath.quadraticBezierTo(width * 0.58, height * 0.8, width * .1, height);

    ovalPath.lineTo(0, height);

    ovalPath.close();

    paint.color = Get.theme.colorScheme.primary;
    canvas.drawPath(ovalPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
