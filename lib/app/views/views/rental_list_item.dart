import 'package:bike_rental/app/models/rental_model.dart';
import 'package:bike_rental/app/routes/app_pages.dart';
import 'package:bike_rental/app/views/views/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RentalListItem extends StatelessWidget {
  const RentalListItem({super.key, required this.rental});

  final RentalModel rental;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(Routes.TRIP_DETAILS, arguments: rental);
      },
      child: Container(
        height: 100,
        width: MediaQuery.sizeOf(context).width > 900 ? Get.width / 3 : 360,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Get.theme.focusColor,
        ),
        child: Row(
          children: [
            Image.asset('assets/bike.jpg', fit: BoxFit.contain),
            UIHelperViews.hSpaceXLarge,
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('E-BIKE',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Theme.of(context).primaryColor,
                        )),
                Text(
                  rental.rentalStatus,
                  style: Theme.of(context).textTheme.bodySmall!,
                ),
                // 60 * 10 get the price per hour 10 (price per min) to be dynamic from server
                Text(
                    '₦${rental.rentalPaidAmount ?? '**.**'} / ${rental.rentalPaidAmount != null ? (rental.rentalPaidAmount! / (60 * 10)).toStringAsPrecision(2) : '**'}Hrs',
                    style: Theme.of(context).textTheme.bodyLarge!),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
