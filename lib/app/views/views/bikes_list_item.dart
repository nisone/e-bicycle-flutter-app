import 'package:bike_rental/app/controllers/app_controller.dart';
import 'package:bike_rental/app/models/bike_model.dart';
import 'package:bike_rental/app/routes/app_pages.dart';
import 'package:bike_rental/app/services/remote_services.dart';
import 'package:bike_rental/app/views/views/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final AppController app = Get.find<AppController>();

class BikesListItem extends StatelessWidget {
  const BikesListItem({super.key, required this.bike});
  final BikeModel bike;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(Routes.TRIP_DETAILS);
      },
      child: Container(
        height: 100,
        padding: const EdgeInsets.only(left: 8),
        width: MediaQuery.sizeOf(context).width > 900 ? Get.width / 3 : 360,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Get.theme.focusColor,
        ),
        child: Row(
          children: [
            Image.network(
              width: 75,
              bike.imageUrl,
              fit: BoxFit.contain,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress != null) {
                  return const Padding(
                      padding: EdgeInsets.all(14),
                      child: CircularProgressIndicator.adaptive());
                }

                return child;
              },
              errorBuilder: (context, error, stackTrace) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    'assets/images/bicycle.png',
                    width: 100,
                    fit: BoxFit.contain,
                  ),
                );
              },
            ),
            UIHelperViews.hSpaceXLarge,
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(bike.model,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Theme.of(context).primaryColor,
                          )),
                  Text(
                    bike.type,
                    style: Theme.of(context).textTheme.bodySmall!,
                  ),
                  Text(bike.chassisNumber,
                      style: Theme.of(context).textTheme.bodySmall!),
                ],
              ),
            ),
            UIHelperViews.hSpaceSmall,
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return RentBikeDialog(bike: bike);
                  },
                );
              },
              icon: const Icon(Icons.arrow_forward_ios_rounded),
            ),
          ],
        ),
      ),
    );
  }
}

class RentBikeDialog extends StatelessWidget {
  const RentBikeDialog({
    super.key,
    required this.bike,
  });

  final BikeModel bike;

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      scrollable: true,
      title: const Text('Bike details'),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      fit: BoxFit.contain,
                      image: Image.network(
                        bike.imageUrl,
                      ).image)),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                    minWidth: 360,
                    minHeight: 200,
                    maxHeight: MediaQuery.sizeOf(context).height / 3),
                // child: const Text('some image promo'),
              ),
            ),
          ),
          Text(
            '${bike.model} - ${bike.type}',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Opacity(
            opacity: .7,
            child: Text(
              bike.chassisNumber,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UIHelperViews.vSpaceXLarge,
              Text('PICK UP STATION',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).primaryColor,
                      )),
              Text(bike.stationAddress,
                  style: Theme.of(context).textTheme.bodyMedium!),
            ],
          ),
          UIHelperViews.vSpaceMedium,
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: const Text('Close'),
        ),
        ObxValue(
            (isLoading) => ElevatedButton(
                  onPressed: isLoading.value
                      ? null
                      : () async {
                          isLoading(true);
                          if (!await RemoteServices.createRental(
                              bike.id, app.accessToken!)) {
                            Get.back();
                            Get.snackbar(
                                'failed', 'Bike not available any more.',
                                snackPosition: SnackPosition.BOTTOM);
                            isLoading(false);
                            return;
                          }
                          isLoading(false);
                          Get.back();
                          Get.snackbar('success',
                              'Bike booked successfully! Head to rides and start your ride.',
                              snackPosition: SnackPosition.BOTTOM);
                        },
                  child: isLoading.value
                      ? const CircularProgressIndicator.adaptive()
                      : const Text('Rent now'),
                ),
            false.obs),
      ],
    );
  }
}
