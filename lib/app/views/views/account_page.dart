import 'package:bike_rental/app/controllers/app_controller.dart';
import 'package:bike_rental/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});
  @override
  Widget build(BuildContext context) {
    final AppController app = Get.find<AppController>();
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(
          top: 40,
        ),
        child: Column(
          children: [
            Center(
              child: Text(
                'Profile',
                style: Get.theme.textTheme.displaySmall,
              ),
            ),
            const Divider(),
            ListTile(
              leading: CircleAvatar(
                radius: 25,
                child: Image.network(
                  app.me.value!.photoUrl,
                  loadingBuilder: (context, child, loadingProgress) {
                    return child;
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      'assets/images/e_bike.png',
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
              title: Text(app.me.value?.name ?? 'Leslie Alexander'),
              subtitle: Text(app.me.value?.email ?? 'leslialex@mail.com'),
              trailing: IconButton(
                onPressed: () {
                  // Goto edit profile form page
                },
                icon: const Icon(Icons.edit_document),
              ),
            ),
            const Divider(),
            ListTile(
              onTap: () {},
              leading: const Icon(Icons.directions_bike_rounded),
              title: const Text('Ride history'),
              trailing: const Icon(Icons.arrow_forward_ios_rounded),
            ),
            ListTile(
              onTap: () {},
              leading: const Icon(Icons.question_answer_rounded),
              title: const Text('FAQs'),
              trailing: const Icon(Icons.arrow_forward_ios_rounded),
            ),
            ListTile(
              onTap: () {},
              leading: const Icon(Icons.privacy_tip_rounded),
              title: const Text('Privacy policy'),
              trailing: const Icon(Icons.arrow_forward_ios_rounded),
            ),
            ListTile(
              onTap: () {},
              leading: const Icon(Icons.list_alt_outlined),
              title: const Text('Terms and condition'),
              trailing: const Icon(Icons.arrow_forward_ios_rounded),
            ),
            ListTile(
              onTap: () {},
              leading: const Icon(Icons.help_center_rounded),
              title: const Text('Help & support'),
              trailing: const Icon(Icons.arrow_forward_ios_rounded),
            ),
            ListTile(
              onTap: () {
                app.me.value = null;
                app.accessToken = null;
                Get.offAllNamed(Routes.AUTH_LANDING);
              },
              leading: Icon(
                Icons.logout_rounded,
                color: Get.theme.colorScheme.error,
              ),
              title: Text(
                'Logout',
                style: TextStyle(color: Get.theme.colorScheme.error),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios_rounded,
                color: Get.theme.colorScheme.error,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
