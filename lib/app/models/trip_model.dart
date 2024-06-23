// modified rental resources model
class TripModel {
  final int? id;
  final int rentalUserId;
  final int rentalBikeId;
  final String? rentalStarted;
  final String? rentalEnded;
  final int rentalPickupStation;
  final int? rentalReturnedStation;
  final double? rentalPaidAmount;
  final int? rentalTransactionId;
  final bool rentalIsPaid;
  final String rentalStatus;

  // id
  // user
  // bikeImage
  // bikeModel
  // bikeChassisNumber
  // bikeType
  // startedDate
  // startedTime
  // endedDate
  // endedTime
  // pickupStation
  // returnedStation
  TripModel(
      {this.id,
      required this.rentalUserId,
      required this.rentalBikeId,
      required this.rentalStarted,
      required this.rentalEnded,
      required this.rentalPickupStation,
      required this.rentalReturnedStation,
      required this.rentalPaidAmount,
      this.rentalTransactionId,
      required this.rentalIsPaid,
      required this.rentalStatus});

  factory TripModel.fromMap(Map<String, dynamic> data) {
    return TripModel(
        id: data['rental_id'],
        rentalUserId: data['rental_user_id'],
        rentalBikeId: data['rental_bike_id'],
        rentalStarted: data['rental_started'],
        rentalEnded: data['rental_ended'],
        rentalPickupStation: data['rental_pickup_station'],
        rentalReturnedStation: data['rental_returned_station'],
        rentalPaidAmount: data['rental_paid_amount'] != null
            ? double.parse(data['rental_paid_amount'])
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
      'rental_started': rentalStarted,
      'rental_ended': rentalEnded,
      'rental_pickup_station': rentalPickupStation,
      'rental_returned_station': rentalReturnedStation,
      'rental_paid_amount': rentalPaidAmount,
      'rental_transaction_id': rentalTransactionId,
      'rental_is_paid': rentalIsPaid,
      'rental_status': rentalStatus
    };
  }
}
