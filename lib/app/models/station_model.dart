import 'package:bike_rental/app/models/bike_model.dart';
import 'package:bike_rental/global.dart';

class StationModel {
  final String name;
  final String address;
  final String imageUrl;
  final int bikesCount;
  final List<BikeModel> bikes;
  final bool status;

  StationModel({
    required this.name,
    required this.address,
    required this.imageUrl,
    required this.bikesCount,
    required this.bikes,
    required this.status,
  });

  factory StationModel.fromMap(Map<String, dynamic> data) {
    return StationModel(
      name: data['station_name'],
      address: data['station_address'],
      imageUrl: Global.baseUrl + data['station_image_url'],
      bikesCount: data['station_bikes_count'],
      bikes: (data['station_bikes'] as List)
          .map((bike) => BikeModel.fromMap(bike))
          .toList(),
      status: data['station_status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "address": address,
      "image_url": imageUrl,
      "bikes_count": bikesCount,
      "bikes": bikes.map((bike) => bike.toJson()).toList(),
      "status": status
    };
  }
}
