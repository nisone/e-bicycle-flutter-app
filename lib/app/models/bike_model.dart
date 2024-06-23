import 'package:bike_rental/global.dart';

class BikeModel {
  final int id;
  final int stationId;
  final String chassisNumber;
  final String model;
  final String type;
  final String imageUrl;
  final String stationAddress;
  final double rating;
  final bool rented;
  BikeModel({
    required this.id,
    required this.stationId,
    required this.chassisNumber,
    required this.model,
    required this.type,
    required this.imageUrl,
    required this.stationAddress,
    required this.rating,
    required this.rented,
  });
  factory BikeModel.fromMap(bike) {
    return BikeModel(
      id: bike['bike_id'],
      stationId: bike['bike_station_id'],
      chassisNumber: bike['bike_chassis_number'],
      model: bike['bike_model'],
      type: bike['bike_type'],
      imageUrl: Global.baseUrl + bike['bike_image_url'],
      stationAddress: bike['bike_station'],
      rating: double.parse(bike['bike_rating'].toString()),
      rented: bike['bike_rented'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "station_id": stationId,
      "chassis_number": chassisNumber,
      "model": model,
      "type": type,
      "image_url": imageUrl,
      "station": stationAddress,
      "rating": rating,
      "rented": rented,
    };
  }
}
