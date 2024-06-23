import 'package:bike_rental/app/controllers/app_controller.dart';
import 'package:bike_rental/app/views/views/rental_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bike_rental/app/models/rental_model.dart';

class RidesPage extends StatelessWidget {
  const RidesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AppController app = Get.find<AppController>();
    return Padding(
      padding: const EdgeInsets.only(
        top: 40,
      ),
      child: Column(
        children: [
          Center(
            child: Text(
              'Rental History',
              style: Get.theme.textTheme.displaySmall,
            ),
          ),
          const Divider(),
          Expanded(
            child: ListView.builder(
                itemCount: app.me.value?.rentals.length ?? 1,
                itemBuilder: (_, index) {
                  List<RentalModel> rentals = app.me.value?.rentals ?? [];
                  if ((rentals.length ?? 0) < 1) {
                    return const ListTile(title: Text('Empty rental records'));
                  }
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    child: RentalListItem(
                      rental: rentals[index],
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
