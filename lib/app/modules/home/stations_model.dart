// class Stations {
//   List<Station>? data;

//   Stations({this.data});

//   Stations.fromJson(Map<String, dynamic> json) {
//     if (json['data'] != null) {
//       data = <Station>[];
//       json['data'].forEach((v) {
//         data?.add(Station.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final data = <String, dynamic>{};
//     if (data != null) {
//       data['data'] = data?.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

class Station {
//   String? name;
//   String? address;
//   String? imageUrl;
//   List<Bikes>? bikes;
//   int? status;

//   Station({this.name, this.address, this.imageUrl, this.bikes, this.status});

//   factory Station.fromJson(Map<String, dynamic> json) {
//     name = json['name'];
//     address = json['address'];
//     imageUrl = json['image_url'];
//     if (json['bikes'] != null) {
//       bikes = <Bikes>[];
//       json['bikes'].forEach((v) {
//         bikes?.add(Bikes.fromJson(v));
//       });
//     }
//     status = json['status'];

//     return Station();
//   }

//   Map<String, dynamic> toJson() {
//     final data = <String, dynamic>{};
//     data['name'] = name;
//     data['address'] = address;
//     data['image_url'] = imageUrl;
//     if (bikes != null) {
//       data['bikes'] = bikes?.map((v) => v.toJson()).toList();
//     }
//     data['status'] = status;
//     return data;
//   }
// }

// class Bikes {
//   Station? station;
//   int? rentalPrice;
//   String? chassisNumber;
//   String? model;
//   String? type;
//   String? imageUrl;
//   int? status;

//   Bikes(
//       {this.station,
//       this.rentalPrice,
//       this.chassisNumber,
//       this.model,
//       this.type,
//       this.imageUrl,
//       this.status});

//   factory Bikes.fromJson(Map<String, dynamic> json) {
//     station =
//         json['station'] != null ? Station?.fromJson(json['station']) : null;
//     rentalPrice = json['rental_price'];
//     chassisNumber = json['chassis_number'];
//     model = json['model'];
//     type = json['type'];
//     imageUrl = json['image_url'];
//     status = json['status'];

//   }

//   Map<String, dynamic> toJson() {
//     final data = <String, dynamic>{};
//     if (station != null) {
//       data['station'] = station?.toJson();
//     }
//     data['rental_price'] = rentalPrice;
//     data['chassis_number'] = chassisNumber;
//     data['model'] = model;
//     data['type'] = type;
//     data['image_url'] = imageUrl;
//     data['status'] = status;
//     return data;
//   }
// }

// class BikeStation {
//   int? id;
//   String? name;
//   String? address;
//   String? imageUrl;
//   int? status;
//   String? createdAt;
//   String? updatedAt;

//   BikeStation(
//       {this.id,
//       this.name,
//       this.address,
//       this.imageUrl,
//       this.status,
//       this.createdAt,
//       this.updatedAt});

//   BikeStation.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     address = json['address'];
//     imageUrl = json['image_url'];
//     status = json['status'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }

//   Map<String, dynamic> toJson() {
//     final data = <String, dynamic>{};
//     data['id'] = id;
//     data['name'] = name;
//     data['address'] = address;
//     data['image_url'] = imageUrl;
//     data['status'] = status;
//     data['created_at'] = createdAt;
//     data['updated_at'] = updatedAt;
//     return data;
//   }
}
