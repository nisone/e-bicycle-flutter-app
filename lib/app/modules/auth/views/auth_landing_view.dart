import 'package:bike_rental/app/views/views/auth_view.dart';
import 'package:bike_rental/app/views/views/helper.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/auth_controller.dart';

class AuthLandingView extends GetView<AuthController> {
  const AuthLandingView({super.key});
  @override
  Widget build(BuildContext context) {
    final draggableScrollableController = DraggableScrollableController();

    return Scaffold(
      body: SizedBox.expand(
        child: Stack(
          fit: StackFit.loose,
          clipBehavior: Clip.none,
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/bike.jpg',
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                alignment: Alignment.bottomLeft,
                fit: BoxFit.cover,
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                  width: 360,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Image.asset('assets/branding.png'),
                  )),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: ClipPath(
                clipper: AuthBottomClipper(),
                child: Container(
                  height: MediaQuery.of(context).size.height * .7,
                  padding: const EdgeInsets.all(40),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xffffcc00).withOpacity(.6),
                        const Color(0xffff2e17),
                      ],
                      begin: AlignmentDirectional.topStart,
                      end: AlignmentDirectional.bottomEnd,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    border: Border.all(
                      width: 1.5,
                      color: Colors.white.withOpacity(0.2),
                    ),
                  ),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 360),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'HELLO',
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(color: Colors.white),
                          ),
                          UIHelperViews.vSpaceSmall,
                          Text(
                            'Welcome to Safara E-Bike.',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: Colors.white),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              draggableScrollableController.animateTo(.75,
                                  duration: Durations.short4,
                                  curve: Curves.bounceInOut);
                            },
                            child: const Text('Get Started'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            AuthView(
              draggableScrollableController: draggableScrollableController,
            ),
          ],
        ),
      ),
    );
  }
}

class AuthBottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path()
      ..moveTo(0, size.height / 2)
      ..lineTo(0, size.height)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, size.height * .3)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
