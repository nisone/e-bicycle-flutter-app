import 'package:bike_rental/global.dart';

class RentalModel {
  final int? id;
  final int rentalUserId;
  final int rentalBikeId;
 final String bikeModel, bikeImageUrl, bikeCNo;
  final DateTime? rentalStarted;
  final DateTime? rentalEnded;
  final int rentalPickupStation;
  final int? rentalReturnedStation;
final String? pickupAddress, returnAddress;
  final double? rentalPaidAmount;
  final int? rentalTransactionId;
  final bool rentalIsPaid;
  final String rentalStatus;
  RentalModel(
      {this.id,
      required this.rentalUserId,
      required this.rentalBikeId,
      required this.bikeModel,
required this.bikeCNo,
required this.bikeImageUrl,
      required this.rentalStarted,
      required this.rentalEnded,
this.returnAddress, this.pickupAddress,
      required this.rentalPickupStation,
      required this.rentalReturnedStation,
      required this.rentalPaidAmount,
      this.rentalTransactionId,
      required this.rentalIsPaid,
      required this.rentalStatus});

  factory RentalModel.fromMap(Map<String, dynamic> data) {
    return RentalModel(
        id: data['rental_id'],
        rentalUserId: data['rental_user_id'],
        rentalBikeId: data['rental_bike_id'],
        bikeImageUrl: Global.baseUrl + data['rental_bike_image_url'],
        bikeModel: data['rental_bike_model'],
        bikeCNo: data['rental_bike_chassis_number'],
        pickupAddress: data['rental_pickup_address'],
        returnAddress: data['rental_return_address'],
        rentalStarted: data['rental_started'] != null
            ? DateTime.parse(data['rental_started'])
            : null,
        rentalEnded: data['rental_ended'] != null
            ? DateTime.parse(data['rental_ended'])
            : null,
        rentalPickupStation: data['rental_pickup_station'],
        rentalReturnedStation: data['rental_returned_station'],
        rentalPaidAmount: data['rental_paid_amount'] != null
            ? double.parse(data['rental_paid_amount'].toString())
            : null,
        rentalTransactionId: data['rental_transaction_id'],
        rentalIsPaid: data['rental_is_paid'],
        rentalStatus: data['rental_status']);
  }

  Map<String, dynamic> toJson() {
    return {
      'rental_id': id,
      'rental_user_id': rentalUserId,
      'rental_bike_id': rentalBikeId,
      'rental_started': rentalStarted?.toIso8601String(),
      'rental_ended': rentalEnded?.toIso8601String(),
      'rental_pickup_station': rentalPickupStation,
      'rental_returned_station': rentalReturnedStation,
      'rental_paid_amount': rentalPaidAmount,
      'rental_transaction_id': rentalTransactionId,
      'rental_is_paid': rentalIsPaid,
      'rental_status': rentalStatus
    };
  }
}
