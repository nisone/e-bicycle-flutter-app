import 'package:bike_rental/app/models/rental_model.dart';
import 'package:bike_rental/app/views/views/helper.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/trip_details_controller.dart';

class TripDetailsView extends GetView<TripDetailsController> {
  const TripDetailsView({super.key});
  @override
  Widget build(BuildContext context) {
    final RentalModel rental;
    if (controller.rental.value == null) {
      return const Scaffold(
        body: Center(
          child: Text('Invalid rental argument'),
        ),
      );
    }
    rental = controller.rental.value!;
    return Scaffold(
      appBar: AppBar(
        title: const Text('TRIP DETAILS'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          fit: BoxFit.contain,
                          image: Image.network(
                            rental.bikeImageUrl,
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
                rental.bikeModel,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Opacity(
                opacity: .7,
                child: Text(
                  rental.bikeCNo,
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
                  Text(rental.pickupAddress ?? '',
                      style: Theme.of(context).textTheme.bodyMedium!),
                ],
              ),
              if (rental.rentalReturnedStation != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    UIHelperViews.vSpaceXLarge,
                    Text('RETURN STATION',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Theme.of(context).primaryColor,
                            )),
                    Text(
                      rental.returnAddress ?? '',
                      style: Theme.of(context).textTheme.bodyMedium!,
                      textAlign: TextAlign.right,
                    ),
                  ],
                ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Divider(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (rental.rentalStarted != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text('FROM'),
                        Text(DateFormat('d MMMM, y')
                            .format(rental.rentalStarted!)),
                        Text(DateFormat('hh:mm a')
                            .format(rental.rentalStarted!)),
                      ],
                    ),
                  if (rental.rentalEnded != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text('TO'),
                        Text(DateFormat('d MMMM, y')
                            .format(rental.rentalEnded!)),
                        Text(DateFormat('hh:mm a').format(rental.rentalEnded!)),
                      ],
                    )
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Divider(),
              ),
              if (rental.rentalPaidAmount != null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                   Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        if(rental.rentalIsPaid)
                          Text('Amount paid')
                        else
                          Text('Total to be paid'),
                        // Text('Inclusive all taxes'),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(rental.rentalPaidAmount.toString(), style:const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      ],
                    )
                  ],
                ),
              Center(
                child: Text(rental.rentalStatus.toUpperCase()),
              ),
              Wrap(
                alignment: WrapAlignment.center,
                runSpacing: 8,
                spacing: 8,
                children: [
                  if (rental.rentalStatus == 'processing' ||
                      rental.rentalStatus == 'booked')
                    ElevatedButton(
                      onPressed: () {
                        controller.startRent(rental.id!);
                      },
                      child: const Text('Start now'),
                    ),
                  if (rental.rentalStatus == 'running')
                    ElevatedButton(
                      onPressed: () {
                        controller.endRent(rental.id!);
                      },
                      child: const Text('End now'),
                    ),
                  if (rental.rentalStatus == 'ended' && !rental.rentalIsPaid)
                    ElevatedButton(
                      onPressed: () {
                        controller.payRent(rental.id!);
                      },
                      child: const Text('Pay now'),
                    )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 'booked', 'running', 'ended', 'cancelled'
